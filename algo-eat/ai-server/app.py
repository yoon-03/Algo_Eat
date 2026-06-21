from flask import Flask, request, jsonify
from flask_cors import CORS

import json
import random
import pymysql
import pandas as pd

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)
CORS(app)

DB_CONFIG = {
    "host": "localhost",
    "port": 3306,
    "user": "root",
    "password": "Rpwn1004!",
    "database": "algoeatDB",
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor
}

def load_foods_from_db():
    connection = pymysql.connect(**DB_CONFIG)

    try:
        with connection.cursor() as cursor:
            sql = """
                SELECT
                    Food_id AS foodId,
                    Name AS name,
                    Category AS category,
                    Nation AS nation,
                    Type AS type,
                    Ingredient AS ingredient,
                    Taste AS taste
                FROM Food
            """
            cursor.execute(sql)
            return cursor.fetchall()
    finally:
        connection.close()

def parse_taste(text):
    try:
        return " ".join(json.loads(text))
    except:
        return ""

def get_taste_list(text):
    try:
        return json.loads(text)
    except:
        return []

def parse_preference(preference):
    try:
        if not preference:
            return {}
        if isinstance(preference, dict):
            return preference
        return json.loads(preference)
    except:
        return {}

def make_features(row):
    return (
        f"{row.get('category', '')} "
        f"{row.get('nation', '')} "
        f"{row.get('type', '')} "
        f"{row.get('ingredient', '')} "
        f"{parse_taste(row.get('taste', ''))}"
    )



def make_preference_reasons(food, preference):
    reasons = []

    if not preference:
        return reasons

    nation = food.get("nation")
    food_type = food.get("type")

    tastes = get_taste_list(food.get("taste", ""))

    if (
        "nation" in preference and
        nation in preference["nation"] and
        preference["nation"][nation] >= 3
    ):
        reasons.append(
            f"자주 선택한 {nation} 메뉴 기반 추천"
        )

    if (
        "type" in preference and
        food_type in preference["type"] and
        preference["type"][food_type] >= 3
    ):
        reasons.append(
            f"최근 선호하는 {food_type} 음식과 유사"
        )

    if "taste" in preference:
        for taste in tastes:
            if preference["taste"].get(taste, 0) >= 3:
                reasons.append(
                    f"선호하는 {taste} 맛 포함"
                )
                break

    return reasons
def make_reasons(
        target_food,
        recommended_food,
        preference=None,
        is_random=False
):
    if is_random:
        return ["새로운 메뉴 탐색 추천"]

    reasons = []

    preference_reasons = make_preference_reasons(
        recommended_food,
        preference
    )

    reasons.extend(preference_reasons)

    if (
        target_food.get("nation") and
        target_food.get("nation") == recommended_food.get("nation")
    ):
        reasons.append(
            f"같은 국가: {recommended_food.get('nation')}"
        )

    if (
        target_food.get("type") and
        target_food.get("type") == recommended_food.get("type")
    ):
        reasons.append(
            f"같은 종류: {recommended_food.get('type')}"
        )

    if (
        target_food.get("ingredient") and
        target_food.get("ingredient") == recommended_food.get("ingredient")
    ):
        reasons.append(
            f"같은 주재료: {recommended_food.get('ingredient')}"
        )

    target_tastes = set(
        get_taste_list(target_food.get("taste", ""))
    )

    recommended_tastes = set(
        get_taste_list(recommended_food.get("taste", ""))
    )

    common_tastes = list(
        target_tastes.intersection(recommended_tastes)
    )

    if common_tastes:
        reasons.append(
            f"비슷한 맛: {', '.join(common_tastes)}"
        )

    if not reasons:
        reasons.append("전체적인 음식 특징이 유사함")

    return reasons[:3]

def preference_bonus(food, preference):
    bonus = 0.0

    weights = {
        "nation": 0.04,
        "type": 0.04,
        "ingredient": 0.03,
        "taste": 0.02
    }

    for key in ["nation", "type", "ingredient"]:
        value = food.get(key)
        if value and key in preference:
            count = preference[key].get(value, 0)
            bonus += min(count, 5) * weights[key]

    tastes = get_taste_list(food.get("taste", ""))
    if "taste" in preference:
        for taste in tastes:
            count = preference["taste"].get(taste, 0)
            bonus += min(count, 5) * weights["taste"]

    return bonus

def build_recommendations(food_id, blacklist=None, preference=None, top_n=4):
    if blacklist is None:
        blacklist = []

    preference = parse_preference(preference)

    foods = load_foods_from_db()

    if not foods:
        return []

    df = pd.DataFrame(foods)
    df["features"] = df.apply(make_features, axis=1)

    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(df["features"])
    similarity_matrix = cosine_similarity(tfidf_matrix, tfidf_matrix)

    if food_id not in df["foodId"].values:
        return []

    target_index = df[df["foodId"] == food_id].index[0]
    target_food = df.iloc[target_index].to_dict()

    exclude_ids = set(int(x) for x in blacklist)
    exclude_ids.add(int(food_id))

    similarity_scores = list(enumerate(similarity_matrix[target_index]))

    similar_candidates = []

    for index, base_score in similarity_scores:
        current_food_id = int(df.iloc[index]["foodId"])

        if current_food_id in exclude_ids:
            continue

        recommended_food = df.iloc[index].to_dict()

        bonus = preference_bonus(recommended_food, preference)
        final_score = float(base_score) + bonus

        similar_candidates.append({
            "foodId": current_food_id,
            "name": recommended_food["name"],
            "score": round(final_score, 4),
            "reasons": make_reasons(
                target_food,
                recommended_food,
                preference
            )
        })

    similar_candidates = sorted(
        similar_candidates,
        key=lambda x: x["score"],
        reverse=True
    )

    top_similar_candidates = similar_candidates[:10]
    random.shuffle(top_similar_candidates)

    similar_picks = top_similar_candidates[:2]
    picked_ids = set(item["foodId"] for item in similar_picks)

    random_candidates = []

    for _, row in df.iterrows():
        current_food_id = int(row["foodId"])

        if current_food_id in exclude_ids:
            continue

        if current_food_id in picked_ids:
            continue

        recommended_food = row.to_dict()
        bonus = preference_bonus(recommended_food, preference)

        random_candidates.append({
            "foodId": current_food_id,
            "name": recommended_food["name"],
            "score": round(bonus, 4),
            "reasons": ["새로운 메뉴 탐색 추천"]
        })

    random.shuffle(random_candidates)
    random_picks = random_candidates[:2]

    recommendations = similar_picks + random_picks

    return recommendations[:top_n]

@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "AI 추천 서버 정상 실행 중"
    })

@app.route("/recommend", methods=["POST"])
def recommend():
    data = request.get_json()

    food_id = data.get("foodId")
    blacklist = data.get("blackList", [])
    preference = data.get("preference", "{}")

    if food_id is None:
        return jsonify({
            "error": "foodId 필요"
        }), 400

    try:
        food_id = int(food_id)
        blacklist = [int(x) for x in blacklist]
    except:
        return jsonify({
            "error": "foodId 또는 blackList 형식 오류"
        }), 400

    recommendations = build_recommendations(
        food_id=food_id,
        blacklist=blacklist,
        preference=preference,
        top_n=4
    )

    return jsonify({
        "recommendations": recommendations
    })

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )
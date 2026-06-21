package com.inhatc.demo.controller;

import com.inhatc.demo.dto.GeminiRequest;
import com.inhatc.demo.dto.GeminiResponse;
import com.inhatc.demo.entity.Food;
import com.inhatc.demo.repository.FoodRepository;
import com.inhatc.demo.service.GeminiService;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/gemini")
@RequiredArgsConstructor
@CrossOrigin(origins = {
        "http://localhost:5173",
        "http://10.0.2.2:5173"
})
public class GeminiController {

    private final GeminiService geminiService;
    private final FoodRepository foodRepository;

    @PostMapping("/chat")
    public GeminiResponse chat(@RequestBody GeminiRequest request) {

        List<Food> foods = foodRepository.findAll();

        String foodList = foods.stream()
                .map(food -> String.format(
                        "- %s / %s / %s / %s / %s / %dkcal / 탄수화물 %sg / 단백질 %sg / 지방 %sg",
                        food.getName(),
                        food.getNation(),
                        food.getType(),
                        food.getIngredient(),
                        food.getTaste(),
                        food.getCalories() != null ? food.getCalories() : 0,
                        food.getCarbs() != null ? food.getCarbs().toString() : "0",
                        food.getProtein() != null ? food.getProtein().toString() : "0",
                        food.getFat() != null ? food.getFat().toString() : "0"
                ))
                .collect(Collectors.joining("\n"));

        String prompt = """
                너는 AlgoEat 앱의 음식 추천 AI이다.

                반드시 한국어로만 답변한다.
                반드시 아래 음식 목록 안에서만 추천한다.
                음식 목록에 없는 메뉴는 추천하지 않는다.
                사용자의 요청이 음식과 관련 없더라도, 자연스럽게 음식 추천으로 유도한다.

                중요:
                추천 메뉴 이름은 반드시 음식 목록에 있는 이름을 그대로 사용한다.
                예: '짬뽕', '마라탕', '돼지김치찌개'처럼 정확한 음식명을 포함한다.

                답변 형식:
                1. 추천 메뉴 2~3개
                2. 각 메뉴를 추천하는 이유
                3. 마지막에 "이 중 마음에 드는 메뉴를 선택해보세요."라고 말한다.

                [추천 가능한 음식 목록]
                %s

                [사용자 요청]
                %s
                """.formatted(foodList, request.getMessage());

        String answer = geminiService.askGemini(prompt);

        List<Food> matchedFoods = foods.stream()
                .filter(food -> answer.contains(food.getName()))
                .limit(3)
                .collect(Collectors.toList());

        return new GeminiResponse(answer, matchedFoods);
    }
}
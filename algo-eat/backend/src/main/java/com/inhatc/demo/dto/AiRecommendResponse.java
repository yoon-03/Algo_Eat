package com.inhatc.demo.dto;

import java.util.List;

public class AiRecommendResponse {

    private List<Recommendation> recommendations;

    public List<Recommendation> getRecommendations() {
        return recommendations;
    }

    public void setRecommendations(List<Recommendation> recommendations) {
        this.recommendations = recommendations;
    }

    public static class Recommendation {
        private Integer foodId;
        private String name;
        private Double score;
        private List<String> reasons;

        public Integer getFoodId() {
            return foodId;
        }

        public void setFoodId(Integer foodId) {
            this.foodId = foodId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Double getScore() {
            return score;
        }

        public void setScore(Double score) {
            this.score = score;
        }

        public List<String> getReasons() {
            return reasons;
        }

        public void setReasons(List<String> reasons) {
            this.reasons = reasons;
        }
    }
}
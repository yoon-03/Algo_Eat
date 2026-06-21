package com.inhatc.demo.dto;

import java.util.List;

public class AiRecommendRequest {

    private Integer foodId;
    private List<Integer> blackList;
    private String preference;

    public AiRecommendRequest(
            Integer foodId,
            List<Integer> blackList,
            String preference
    ) {
        this.foodId = foodId;
        this.blackList = blackList;
        this.preference = preference;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public List<Integer> getBlackList() {
        return blackList;
    }

    public String getPreference() {
        return preference;
    }
}
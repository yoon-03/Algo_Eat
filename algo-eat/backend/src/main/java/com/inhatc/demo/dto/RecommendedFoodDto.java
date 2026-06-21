package com.inhatc.demo.dto;

import java.math.BigDecimal;
import java.util.List;

public class RecommendedFoodDto {

    private Integer foodId;
    private String name;
    private String imageUrl;

    private String nation;
    private String type;
    private String ingredient;

    private Integer calories;
    private BigDecimal carbs;
    private BigDecimal protein;
    private BigDecimal fat;

    private List<String> reasons;

    public RecommendedFoodDto(
            Integer foodId,
            String name,
            String imageUrl,
            String nation,
            String type,
            String ingredient,
            Integer calories,
            BigDecimal carbs,
            BigDecimal protein,
            BigDecimal fat,
            List<String> reasons
    ) {
        this.foodId = foodId;
        this.name = name;
        this.imageUrl = imageUrl;
        this.nation = nation;
        this.type = type;
        this.ingredient = ingredient;
        this.calories = calories;
        this.carbs = carbs;
        this.protein = protein;
        this.fat = fat;
        this.reasons = reasons;
    }

    public Integer getFoodId() {
        return foodId;
    }

    public String getName() {
        return name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getNation() {
        return nation;
    }

    public String getType() {
        return type;
    }

    public String getIngredient() {
        return ingredient;
    }

    public Integer getCalories() {
        return calories;
    }

    public BigDecimal getCarbs() {
        return carbs;
    }

    public BigDecimal getProtein() {
        return protein;
    }

    public BigDecimal getFat() {
        return fat;
    }

    public List<String> getReasons() {
        return reasons;
    }
}
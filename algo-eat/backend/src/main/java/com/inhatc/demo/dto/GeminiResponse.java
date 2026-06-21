package com.inhatc.demo.dto;

import com.inhatc.demo.entity.Food;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class GeminiResponse {

    private String answer;
    private List<Food> foods;
}
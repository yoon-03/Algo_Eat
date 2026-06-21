package com.inhatc.demo.controller;

import com.inhatc.demo.dto.AiRecommendRequest;
import com.inhatc.demo.dto.AiRecommendResponse;
import com.inhatc.demo.dto.RecommendedFoodDto;
import com.inhatc.demo.entity.Food;
import com.inhatc.demo.entity.User;
import com.inhatc.demo.repository.FoodRepository;
import com.inhatc.demo.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = {
        "http://localhost:5173",
        "http://10.0.2.2:5173"
})
public class FoodController {

    @Autowired
    private FoodRepository foodRepository;

    @Autowired
    private UserRepository userRepository;

    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/foods")
    public List<Food> getAllFoods(
            @RequestParam(name = "userId", required = false) Integer userId
    ) {
        if (userId != null) {
            User user = userRepository.findById(userId).orElse(null);

            if (user != null && user.getBlackList() != null && !user.getBlackList().isBlank()) {
                return foodRepository.findByFoodIdNotIn(user.getBlacklistIds());
            }
        }

        return foodRepository.findAll();
    }

    @GetMapping("/foods/recommend-next")
    public List<RecommendedFoodDto> getNextRecommendations(
            @RequestParam(name = "userId", required = false) Integer userId,
            @RequestParam(name = "foodId") Integer foodId
    ) {
        List<Integer> blackList = new ArrayList<>();
        String preference = "{}";

        if (userId != null) {
            User user = userRepository.findById(userId).orElse(null);

            if (user != null) {
                if (user.getBlackList() != null && !user.getBlackList().isBlank()) {
                    blackList.addAll(user.getBlacklistIds());
                }

                if (user.getPreference() != null && !user.getPreference().isBlank()) {
                    preference = user.getPreference();
                }
            }
        }

        blackList.add(foodId);

        try {
            String flaskUrl = "http://localhost:5000/recommend";

            AiRecommendRequest request = new AiRecommendRequest(
                    foodId,
                    blackList,
                    preference
            );

            AiRecommendResponse response = restTemplate.postForObject(
                    flaskUrl,
                    request,
                    AiRecommendResponse.class
            );

            if (response == null || response.getRecommendations() == null) {
                return convertToDtoList(
                        getFallbackRecommendations(foodId, blackList),
                        List.of("기존 추천 로직 기반 추천")
                );
            }

            List<Integer> recommendedIds = response.getRecommendations()
                    .stream()
                    .map(AiRecommendResponse.Recommendation::getFoodId)
                    .collect(Collectors.toList());

            System.out.println("AI 추천 결과 ID: " + recommendedIds);

            if (recommendedIds.isEmpty()) {
                return convertToDtoList(
                        getFallbackRecommendations(foodId, blackList),
                        List.of("기존 추천 로직 기반 추천")
                );
            }

            List<Food> aiFoods = foodRepository.findByFoodIdIn(recommendedIds);

            List<RecommendedFoodDto> result = new ArrayList<>();

            for (AiRecommendResponse.Recommendation recommendation : response.getRecommendations()) {
                Food food = aiFoods.stream()
                        .filter(f -> f.getFoodId().equals(recommendation.getFoodId()))
                        .findFirst()
                        .orElse(null);

                if (food == null) {
                    continue;
                }
                result.add(
                new RecommendedFoodDto(
                	    food.getFoodId(),
                	    food.getName(),
                	    food.getImageUrl(),
                	    food.getNation(),
                	    food.getType(),
                	    food.getIngredient(),
                	    food.getCalories(),
                	    food.getCarbs(),
                	    food.getProtein(),
                	    food.getFat(),
                	    recommendation.getReasons()
                	));
            }

            return result;

        } catch (Exception e) {
            System.out.println("AI 추천 서버 호출 실패: " + e.getMessage());

            return convertToDtoList(
                    getFallbackRecommendations(foodId, blackList),
                    List.of("기존 추천 로직 기반 추천")
            );
        }
    }

    private List<RecommendedFoodDto> convertToDtoList(
            List<Food> foods,
            List<String> reasons
    ) {
        return foods.stream()
                .map(food -> new RecommendedFoodDto(
                        food.getFoodId(),
                        food.getName(),
                        food.getImageUrl(),
                        food.getNation(),
                        food.getType(),
                        food.getIngredient(),
                        food.getCalories(),
                        food.getCarbs(),
                        food.getProtein(),
                        food.getFat(),
                        reasons
                ))
                .collect(Collectors.toList());
    }

    private List<Food> getFallbackRecommendations(
            Integer foodId,
            List<Integer> excludeIds
    ) {
        Food selectedFood = foodRepository.findById(foodId)
                .orElseThrow(() -> new RuntimeException("음식을 찾을 수 없습니다."));

        List<Food> availableFoods = foodRepository.findByFoodIdNotIn(excludeIds);

        List<Food> similarFoods = availableFoods.stream()
                .filter(f ->
                        (f.getNation() != null && f.getNation().equals(selectedFood.getNation())) ||
                        (f.getType() != null && f.getType().equals(selectedFood.getType())) ||
                        (f.getIngredient() != null && f.getIngredient().equals(selectedFood.getIngredient()))
                )
                .collect(Collectors.toList());

        Collections.shuffle(similarFoods);

        List<Food> pickedSimilar = similarFoods.stream()
                .limit(2)
                .collect(Collectors.toList());

        List<Integer> pickedSimilarIds = pickedSimilar.stream()
                .map(Food::getFoodId)
                .collect(Collectors.toList());

        List<Food> randomPool = availableFoods.stream()
                .filter(f -> !pickedSimilarIds.contains(f.getFoodId()))
                .collect(Collectors.toList());

        Collections.shuffle(randomPool);

        int neededRandomCount = 4 - pickedSimilar.size();

        List<Food> pickedRandom = randomPool.stream()
                .limit(neededRandomCount)
                .collect(Collectors.toList());

        List<Food> result = new ArrayList<>();
        result.addAll(pickedSimilar);
        result.addAll(pickedRandom);

        return result;
    }
}
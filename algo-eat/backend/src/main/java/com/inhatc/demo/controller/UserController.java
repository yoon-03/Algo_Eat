package com.inhatc.demo.controller;

import com.inhatc.demo.entity.Food;

import com.inhatc.demo.entity.User;
import com.inhatc.demo.repository.FoodRepository;
import com.inhatc.demo.repository.UserRepository;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
@CrossOrigin(origins = "http://localhost:5173")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    // 블랙리스트 ID로 음식 정보를 찾아오기 위해 FoodRepository 추가
    @Autowired
    private FoodRepository foodRepository;

    @PostMapping("/signup")
    public String signUp(@RequestBody User user) {
        if (userRepository.findByEmail(user.getEmail()).isPresent()) {
            return "이미 존재하는 아이디입니다.";
        }
        userRepository.save(user);
        return "회원가입 성공! ID: " + user.getUserId();
    }

    @PostMapping("/login")
    public String login(@RequestBody User loginRequest) {
        Optional<User> user = userRepository.findByEmail(loginRequest.getEmail());
        
        if (user.isPresent() && user.get().getPassword().equals(loginRequest.getPassword())) {
            // 프론트엔드에서 split(",") 으로 처리할 수 있도록 응답
            return "로그인 성공!," + user.get().getUserId() + "," + user.get().getNickName();
        }
        return "아이디 또는 비밀번호가 틀렸습니다.";	
    }

    // ==========================================
    // ✅ 블랙리스트 관리용 API 엔드포인트 3개 추가
    // ==========================================

    // 1. 블랙리스트 음식 목록 가져오기 (마이페이지에서 사용)
    @GetMapping("/{userId}/blacklist-items")
    public List<Food> getBlacklistItems(@PathVariable(name = "userId") Integer userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        List<Integer> blacklistIds = user.getBlacklistIds();
        
        // 블랙리스트에 등록된 게 없으면 빈 배열 반환
        if (blacklistIds.isEmpty()) {
            return List.of();
        }
        
        // FoodRepository의 내장 메서드를 통해 ID 리스트에 해당하는 음식 정보들을 한 번에 가져옴
        return foodRepository.findAllById(blacklistIds);
    }

    // 2. 블랙리스트에 추가하기 (메인페이지에서 '이 메뉴 빼기' 클릭 시)
    @PostMapping("/{userId}/blacklist/{foodId}")
    public String addToBlacklist(@PathVariable(name = "userId") Integer userId, @PathVariable(name = "foodId") Integer foodId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        user.addBlacklistId(foodId);
        userRepository.save(user); // 쉼표가 추가된 상태로 DB에 업데이트됨
        return "블랙리스트 추가 완료";
    }

    // 3. 블랙리스트에서 해제하기 (마이페이지에서 'X' 버튼 클릭 시)
    @DeleteMapping("/{userId}/blacklist/{foodId}")
    public String removeFromBlacklist(@PathVariable(name = "userId") Integer userId, @PathVariable(name = "foodId") Integer foodId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        user.removeBlacklistId(foodId);
        userRepository.save(user); // 해당 ID가 빠진 상태로 DB에 업데이트됨
        return "블랙리스트 해제 완료";
    }
    
    @GetMapping("/{userId}/preference")
    public String getPreference(
            @PathVariable(name = "userId") Integer userId
    ) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        if (user.getPreference() == null || user.getPreference().isBlank()) {
            return "{}";
        }

        return user.getPreference();
    }
    
    @PostMapping("/{userId}/preference/{foodId}")
    public String updatePreference(
    		 @PathVariable(name = "userId") Integer userId,
    	        @PathVariable(name = "foodId") Integer foodId
    ) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("사용자를 찾을 수 없습니다."));

        Food food = foodRepository.findById(foodId)
                .orElseThrow(() -> new RuntimeException("음식을 찾을 수 없습니다."));

        ObjectMapper objectMapper = new ObjectMapper();

        Map<String, Map<String, Integer>> preferenceMap;

        try {
            if (user.getPreference() == null || user.getPreference().isBlank()) {
                preferenceMap = new HashMap<>();
            } else {
                preferenceMap = objectMapper.readValue(
                        user.getPreference(),
                        new TypeReference<Map<String, Map<String, Integer>>>() {}
                );
            }

            addPreferenceScore(preferenceMap, "nation", food.getNation());
            addPreferenceScore(preferenceMap, "type", food.getType());
            addPreferenceScore(preferenceMap, "ingredient", food.getIngredient());

            if (food.getTaste() != null && !food.getTaste().isBlank()) {
                List<String> tastes = objectMapper.readValue(
                        food.getTaste(),
                        new TypeReference<List<String>>() {}
                );

                for (String taste : tastes) {
                    addPreferenceScore(preferenceMap, "taste", taste);
                }
            }

            user.setPreference(objectMapper.writeValueAsString(preferenceMap));
            userRepository.save(user);

            return "preference update success";

        } catch (Exception e) {
            throw new RuntimeException("선호도 업데이트 실패: " + e.getMessage());
        }
    }
    private void addPreferenceScore(
            Map<String, Map<String, Integer>> preferenceMap,
            String category,
            String value
    ) {
        if (value == null || value.isBlank()) {
            return;
        }

        preferenceMap.putIfAbsent(category, new HashMap<>());

        Map<String, Integer> categoryMap = preferenceMap.get(category);

        categoryMap.put(
                value,
                categoryMap.getOrDefault(value, 0) + 1
        );
    }
}
package com.inhatc.demo.controller;

import com.inhatc.demo.entity.Food;
import com.inhatc.demo.entity.History;
import com.inhatc.demo.entity.User;
import com.inhatc.demo.repository.FoodRepository;
import com.inhatc.demo.repository.HistoryRepository;
import com.inhatc.demo.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/history")
@CrossOrigin(origins = {
        "http://localhost:5173",
        "http://10.0.2.2:5173"
})
public class HistoryController {

    @Autowired
    private HistoryRepository historyRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FoodRepository foodRepository;

    
    
    @PostMapping("/{userId}/{foodId}")
    public String saveHistory(
            @PathVariable(name = "userId") Integer userId,
            @PathVariable(name = "foodId") Integer foodId,
            @RequestParam(name = "mealType") History.MealType mealType,
            @RequestParam(name = "quantity", defaultValue = "1.0") BigDecimal quantity
    ) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("유저를 찾을 수 없습니다."));

        Food food = foodRepository.findById(foodId)
                .orElseThrow(() -> new RuntimeException("음식을 찾을 수 없습니다."));

        History history = new History();
        history.setUser(user);
        history.setFood(food);
        history.setMealType(mealType);
        history.setQuantity(quantity);

        historyRepository.save(history);

        return "식단 기록 저장 완료";
    }
    @PutMapping("/{historyId}")
    public String updateQuantity(
            @PathVariable(name = "historyId") Long historyId,
            @RequestParam(name = "quantity") BigDecimal quantity
    ) {
        History history = historyRepository.findById(historyId)
                .orElseThrow(() -> new RuntimeException("기록을 찾을 수 없습니다."));

        history.setQuantity(quantity);
        historyRepository.save(history);

        return "수량 수정 완료";
    }
    
    @GetMapping("/{userId}")
    public List<History> getHistoryByUser(
            @PathVariable(name = "userId") Integer userId
    ) {
        return historyRepository.findByUser_UserId(userId);
    }
    
    @DeleteMapping("/{historyId}")
    public String deleteHistory(
            @PathVariable(name = "historyId") Long historyId
    ) {
        historyRepository.deleteById(historyId);
        return "식단 기록 삭제 완료";
    }
}
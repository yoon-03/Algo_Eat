package com.inhatc.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.inhatc.demo.entity.Food;
import java.util.List;

public interface FoodRepository extends JpaRepository<Food, Integer> {
    
    // 기존 태그 검색 유지

    // ✅ 블랙리스트(제외할 ID 리스트)에 포함되지 않은 음식만 가져오는 메서드 추가
    List<Food> findByFoodIdNotIn(List<Integer> excludeIds);
    List<Food> findByFoodIdIn(List<Integer> foodIds);
}
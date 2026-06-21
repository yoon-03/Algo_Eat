package com.inhatc.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.inhatc.demo.entity.History;

import java.util.List;

public interface HistoryRepository extends JpaRepository<History, Long> {
    List<History> findByUser_UserId(Integer userId);
}
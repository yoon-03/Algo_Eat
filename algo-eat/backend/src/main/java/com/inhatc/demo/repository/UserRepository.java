package com.inhatc.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.inhatc.demo.entity.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
}
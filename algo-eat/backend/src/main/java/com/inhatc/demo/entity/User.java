package com.inhatc.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Getter
@Setter
@Table(name = "User")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "User_id")
    private Integer userId;

    @Column(name = "Email", nullable = false, unique = true)
    private String email;

    @Column(name = "Password", nullable = false)
    private String password;

    @Column(name = "Gender")
    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Column(name = "Age")
    private Integer age;

    @Column(name = "Height")
    private Double height;

    @Column(name = "Weight")
    private Double weight;

    @Column(name = "NickName")
    private String nickName;

    // 추천용 JSON
    @Column(name = "Preference", columnDefinition = "JSON")
    private String preference;

    // 기존 블랙리스트 방식
    @Column(name = "BlackList")
    private String blackList;

    public enum Gender {
        MALE,
        FEMALE
    }

    // ==========================================
    // 블랙리스트 편의 메서드
    // ==========================================

    public List<Integer> getBlacklistIds() {
        if (this.blackList == null || this.blackList.trim().isEmpty()) {
            return new ArrayList<>();
        }

        return Arrays.stream(this.blackList.split(","))
                .map(String::trim)
                .map(Integer::parseInt)
                .collect(Collectors.toList());
    }

    public void addBlacklistId(Integer foodId) {
        List<Integer> ids = getBlacklistIds();

        if (!ids.contains(foodId)) {
            ids.add(foodId);

            this.blackList = ids.stream()
                    .map(String::valueOf)
                    .collect(Collectors.joining(","));
        }
    }

    public void removeBlacklistId(Integer foodId) {
        List<Integer> ids = getBlacklistIds();

        if (ids.contains(foodId)) {
            ids.remove(foodId);

            this.blackList = ids.stream()
                    .map(String::valueOf)
                    .collect(Collectors.joining(","));
        }
    }
}
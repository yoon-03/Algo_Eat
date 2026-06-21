package com.inhatc.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "History")
public class History {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "History_id")
    private Long historyId;

    @Column(name = "EatDate")
    private LocalDateTime eatDate = LocalDateTime.now();

    @Column(name = "Quantity")
    private BigDecimal quantity;

    @ManyToOne
    @JoinColumn(name = "User_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "Food_id")
    private Food food;
    
    @Column(name = "MealType")
    @Enumerated(EnumType.STRING)
    private MealType mealType;

    public enum MealType {
        BREAKFAST, LUNCH, DINNER, SNACK
    }
}
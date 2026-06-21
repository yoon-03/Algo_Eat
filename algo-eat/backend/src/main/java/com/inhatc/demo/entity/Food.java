package com.inhatc.demo.entity;

import java.math.BigDecimal;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "Food")
public class Food {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Food_id")
    private Integer foodId;

    @Column(name = "Name", nullable = false, length = 50)
    private String name;

    @Column(name = "Calories")
    private Integer calories;

    @Column(name = "Carbs")
    private BigDecimal carbs;

    @Column(name = "Protein")
    private BigDecimal protein;

    @Column(name = "Fat")
    private BigDecimal fat;

    @Column(name = "Category")
    private String category;

    @Column(name = "Nation")
    private String nation;

    @Column(name = "Type")
    private String type;

    @Column(name = "Ingredient")
    private String ingredient;

    @Column(name = "Taste")
    private String taste;

    @Column(name = "Image_url", columnDefinition = "TEXT")
    private String imageUrl;
}
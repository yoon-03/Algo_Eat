package com.inhatc.demo.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

@Entity
@Getter @Setter
@Table(name = "ChoiceLogs")
public class ChoiceLogs {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Log_id")
    private Integer logId;

    @Enumerated(EnumType.STRING)
    @Column(name = "ActionType")
    private ActionType actionType;

    @Column(name = "Log_Date")
    private LocalDateTime logDate = LocalDateTime.now();

    @ManyToOne
    @JoinColumn(name = "User_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "Food_id")
    private Food food;

    public enum ActionType { Good, Bad }
}
package com.inhatc.demo.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class GeminiService {

    @Value("${gemini.api.key}")
    private String apiKey;

    public String askGemini(String prompt) {

        String url =
                "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key="
                        + apiKey;

        RestTemplate restTemplate = new RestTemplate();

        Map<String, Object> textPart = new HashMap<>();
        textPart.put("text", prompt);

        Map<String, Object> content = new HashMap<>();
        content.put("parts", List.of(textPart));

        Map<String, Object> body = new HashMap<>();
        body.put("contents", List.of(content));

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity =
                new HttpEntity<>(body, headers);

        try {
            ResponseEntity<Map> response =
                    restTemplate.postForEntity(url, entity, Map.class);

            List candidates =
                    (List) response.getBody().get("candidates");

            Map candidate = (Map) candidates.get(0);

            Map contentMap =
                    (Map) candidate.get("content");

            List parts =
                    (List) contentMap.get("parts");

            Map part =
                    (Map) parts.get(0);

            return part.get("text").toString();

        } catch (Exception e) {
            e.printStackTrace();
            return "Gemini 호출 중 오류가 발생했습니다. API 키, 모델명, 할당량을 확인해주세요.";
        }
    }
}
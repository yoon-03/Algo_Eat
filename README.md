# 🍽️ AlgoEat

AI 기반 개인 맞춤형 메뉴 추천 및 식단 관리 서비스

사용자의 음식 취향, 영양 정보, 위치 정보를 기반으로
개인 맞춤형 메뉴를 추천하고 식단을 관리할 수 있는 서비스입니다.

---

## 📌 프로젝트 소개

수업이 끝난 후 "오늘 뭐 먹지?"라는 고민을 해결하기 위해 개발한 서비스입니다.

- AI 기반 메뉴 추천
- 영양 정보 제공
- 음식점 위치 검색
- Gemini 기반 챗봇 상담
- 식단 기록 및 관리

---

## 🛠 Tech Stack

### Frontend
- ![React](https://img.shields.io/badge/React-61DAFB?logo=react)
- Tailwind CSS
- Axios
- React Router

### Backend
![SpringBoot](https://img.shields.io/badge/SpringBoot-6DB33F?logo=springboot)
- Spring Data JPA
- REST API

### AI Server
![Flask](https://img.shields.io/badge/Flask-000000?logo=flask)
- Gemini API

### Database
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql)


### Infra
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws)

---

## ✨ 핵심 기능

### 🤖 AI 메뉴 추천
사용자의 취향과 선호도를 기반으로 메뉴를 추천합니다.

### 🥗 영양 정보 제공
칼로리, 탄수화물, 단백질, 지방 정보를 제공합니다.

### 🗺️ 음식점 위치 검색
추천 메뉴를 판매하는 음식점을 지도에서 확인할 수 있습니다.

### 💬 AI 챗봇
Gemini 기반 챗봇을 통해 음식 및 영양 관련 질문이 가능합니다.

### 📊 식단 관리
사용자의 식사 기록을 저장하고 관리할 수 있습니다.

---

## 🏗️ 시스템 구조

![시스템 구조도](algo-eat/Image/시스템%20구조도.png)

---

## 📱 서비스 화면

### 로그인 화면

![로그인](algo-eat/Image/로그인.png)

### 메인 화면 (메뉴 추천)

![메인 화면](algo-eat/Image/메인화면.png)

### 지도 화면

![지도](algo-eat/Image/맵.png)

### 챗봇 화면

![챗봇](algo-eat/Image/챗봇.png)

### 마이페이지

![유저](algo-eat/Image/유저.png)

---

## 📂 프로젝트 구조

```text
AlgoEat
├── frontend      # React
├── backend       # Spring Boot
├── ai-server     # Flask + Gemini
└── Image

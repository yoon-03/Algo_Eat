# AlgoEat Backend

AlgoEat의 REST API 서버입니다.

Spring Boot와 JPA를 활용하여 사용자, 음식, 추천 기록 등의 데이터를 관리합니다.

## 주요 기능

- 회원가입 / 로그인
- 사용자 정보 관리
- 음식 데이터 조회
- 메뉴 추천 API
- 식단 기록 저장
- 즐겨찾기 관리

## Tech Stack

- Spring Boot
- Spring Data JPA
- MySQL
- Lombok

## 실행 방법

### application.properties

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/algoeat
spring.datasource.username=root
spring.datasource.password=비밀번호

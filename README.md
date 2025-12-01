# KGU Lost & Found - 실행 가이드

##  프로젝트 설명
KGU Lost & Found는 **경기대학교 학생들을 위한 분실물 찾기 서비스**입니다.  
학생들이 분실물과 습득물을 손쉽게 등록·조회할 수 있도록 개발된 JSP 기반 웹 프로젝트입니다.

---

##  개발환경
- IDE: **Eclipse**
- 언어/프레임워크: **JSP / Servlet**
- Server: **Apache Tomcat 10.1**
- Database: **MySQL 5.0**

---

##  주요 기능
- 회원가입 및 로그인
- 게시글 등록 / 삭제
- 댓글 등록 / 삭제
- 다국어 지원 (Korean / English)
- 세션 기반 로그인 유지

---

# 실행 가이드

이 문서는 KGU Lost & Found JSP 웹 프로젝트를 실행하기 위한 환경 설정 및 실행 방법을 안내합니다.

---

## 데이터베이스(MySQL) 설정

1. MySQL 실행  
2. 아래 명령어로 데이터베이스 생성:

```sql
CREATE DATABASE lostandfoundDB;
```

3. Eclipse Data Source Explorer에서 connection 생성
4. src/main/webapp/resources/sql 폴더의 SQL 파일을 아래 순서대로 실행
- Student.sql
- post.sql
- comment.sql
- PostImage.sql
5. dbconn.jsp에서 정보 수정

## 실행
Servers 탭에서 Tomcat 우클릭 → Start
http://localhost:8080/KyonggiLostAndFound/login.jsp 실행

# SPRING BOOT 를 사용한 학원관리 웹 포트폴리오

---

## 개요

1. 개발 동기
	- 학원에서 사용할 수 있는 학생 관리 시스템의 베이직 프로젝트를 만들어서 기본적인 틀 안에서 다양한 방면으로 활용이 가능할것 같아 시작하게 되었음.

2. 개발 환경
	- 개발 툴
		- STS-4.15.2
		- git version 2.35.0.windows.1
		- XAMPP Mysql version 10.4.24.MariaDB
		- SQLyog community 64
		- Maven 4.0.0
		- tomcat 9
		- chrome
		- codepen
	- 기술스택
		- jdbc4 version 1.16
		- jdk version 15.0.2
		- jquery 3.6.1
		- java version 17
		- jstl 1.2
		- lombok version 1.18.24
		- fullcalendar 
		- tailwind
		- ajax
		- javax.mail version 1.6.2
		- font-awesome 6.2.0
		- UNICONS 4.0.0
		- TOAST UI editor
	- 프레임 워크
		- spring boot starter web 2.7.5
		- mybatis version 2.2.2
		
- [깃허브 주소](https://github.com/casatoo/EducationManager)
	- https://github.com/casatoo/EducationManager

3. 구현기능
	- 주요 기능
	  1. 회원관리 기능 
			- 회원가입
			- 로그인
			- 로그아웃
			- 회원정보 수정
			- 회원탈퇴
			- 아이디 찾기
			- 비밀번호 찾기
			- 인증키 생성 이메일 전송
			- 구글, 네이버로 로그인 - 미구현
			- 개인정보 조회

	  2. 멀티 게시판 기능
			- 공지사항
			- 자유게시판
			- 갤러리 - 미구현
			- CRUD 기능 구현
			- CRUD 권한 부여
			- 키워드 검색 기능
			- 게시판 페이징
			- 첨부파일 등록 - 미구현
			- 사진업로드 기능 - 미구현
			- 댓글 작성 기능
			- 추천 기능

	  3. 교육일정 관리 기능
			- 캘린더 API
			- 날씨 API
			- 월간 일정 CRUD
			- 일별 일정 CRUD
			- 교육일정 조회
			- 출석체크 기능  - 미구현

	  5. 테이블 생성 출력 기능
			- 개인별 기록 테이블 생성 - 미구현
			- pdf 출력 - 미구현

	  6. 관리자 권한
			- 회원조회
			- 권한부여 - 미구현
			- 모든 게시글 권한 - 미구현
			- 교육일정 관리 권한 - 미구현

	   7. 세팅
			- 홈페이지 테마 설정

## 기술 설명


![](/run.png)

- 동작 과정

	1. client가 controller로 요청을 보낼때 interceptor 에서 rq 객체 불러오기, 로그인이 필요한 요청, 관리자 권한이 필요한 요청에 대해 먼저 작동합니다.
	
	2. interceptor 를 거쳐 도달한 요청은 controller 에서 접수되어 실행되거나 jsp 파일에 필요한 정보를 전달합니다.
	
	3. controller 에서 요청한 데이터는 내부 코드를 숨기기 위해 service단에서 ResultData 형식으로 전달됩니다.
	
	4. service 에서 필요한 데이터는 repository로 요청을 보내어 repository만 데이터베이스에 접근할 수 있도록 합니다.
	
	5. repository는 myBatis 를 사용해 XML 파일과 맵핑되어 값을 주고 받습니다.
	
	6. 계층간 데이터 교환은 VO에서 lombok 을 사용한 getter, setter, 생성자를 만들어줍니다.
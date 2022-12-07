# Education Manager Project DB File

DROP DATABASE IF EXISTS SB_EM;
CREATE DATABASE SB_EM;
USE SB_EM;

# 멤버 테이블 생성
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`(
id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
loginId VARCHAR(20) NOT NULL UNIQUE,
loginPw VARCHAR(100) NOT NULL,
birthDay DATE NOT NULL,
`authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (1=관리자 ,2=직원, 3=원생)',
`name` VARCHAR(20) NOT NULL,
englishName VARCHAR(20) NOT NULL,
cellphoneNum VARCHAR(20) NOT NULL,
email VARCHAR(50) NOT NULL,
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부 (0=탈퇴 전, 1= 탈퇴 후)',
delDate DATETIME COMMENT '탈퇴날짜'
);


# 테스트 데이터 입력
INSERT INTO `member`(regDate,updateDate,loginId,loginPw,birthDay,`authLevel`,`name`,englishName,cellphoneNum,email)VALUES
(NOW(),NOW(),'admin','admin',DATE(19970203),1,'관리자','kimminwoo','01012341234','casato6666@gmail.com'),
(NOW(),NOW(),'id1','pw1',DATE(19970203),1,'직원','user1','0101235678','a333d@gmail.com'),
(NOW(),NOW(),'id2','pw2',DATE(19991003),3,'사용자2','user2','01012345678','asddd@gmail.com'),
(NOW(),NOW(),'id3','pw3',DATE(20011103),3,'사용자3','user3','01056789012','a21233@gmail.com'),
(NOW(),NOW(),'id4','pw4',DATE(20011103),3,'사용자4','user4','01051234012','a212sdf3@gmail.com'),
(NOW(),NOW(),'id5','pw5',DATE(20011103),3,'사용자5','user5','01056344312','a2sd33@gmail.com'),
(NOW(),NOW(),'id6','pw6',DATE(20011103),3,'사용자6','user6','01052390122','a22313@gmail.com');

UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

# 교육과정 테이블
DROP TABLE IF EXISTS educationCourse;
CREATE TABLE educationCourse(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
startOfEducation DATE COMMENT '교육시작일',
endOfEducation DATE COMMENT '교육종료일',
title VARCHAR(50) COMMENT '교육과정명',
place VARCHAR(50) COMMENT '교육장소',
managerMemberId INT COMMENT '담당자',
`status` INT DEFAULT 0 COMMENT '0 = 진행중, 1 = 종료'
);

INSERT INTO educationCourse(regDate,updateDate,startOfEducation,endOfEducation,title,place,managerMemberId)VALUES
(NOW(),NOW(),DATE(20220101),DATE(20220130),'22-1기','1교육장',1),
(NOW(),NOW(),DATE(20220301),DATE(20220330),'22-2기','2교육장',2),
(NOW(),NOW(),DATE(20220501),DATE(20220530),'22-3기','3교육장',2),
(NOW(),NOW(),DATE(20220701),DATE(20220730),'22-4기','1교육장',1),
(NOW(),NOW(),DATE(20220901),DATE(20220930),'22-5기','2교육장',2),
(NOW(),NOW(),DATE(20221101),DATE(20221130),'22-6기','3교육장',2);

UPDATE educationCourse SET `status`=1 WHERE id=1;
UPDATE educationCourse SET `status`=1 WHERE id=2;
# 부가정보테이블
DROP TABLE IF EXISTS attr;
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNIQUE NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

#게시판테이블 생성
DROP TABLE IF EXISTS article;
CREATE TABLE article(
id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
memberId INT(10) NOT NULL,
boardId INT(10) UNSIGNED NOT NULL,
title VARCHAR(200) NOT NULL,
`body` TEXT NOT NULL,
hit INT(10) NOT NULL DEFAULT 0,
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=삭제 전, 1= 삭제 후)',
goodReactionPoint INT(10) NOT NULL DEFAULT 0,
badReactionPoint INT(10) NOT NULL DEFAULT 0
);

INSERT INTO article(regDate,updateDate,memberId,boardId,title,`body`)VALUES
(NOW(),NOW(),1,1,'공지사항1','내용1'),
(NOW(),NOW(),2,1,'공지사항2','내용2'),
(NOW(),NOW(),1,1,'공지사항3','내용3'),
(NOW(),NOW(),2,1,'공지사항4','내용4'),
(NOW(),NOW(),3,2,'제목3','내용3'),
(NOW(),NOW(),1,2,'제목4','내용4'),
(NOW(),NOW(),3,3,'제목5','내용6'),
(NOW(),NOW(),1,3,'제목5','내용6');

# 게시판 종류 테이블
DROP TABLE IF EXISTS board;
CREATE TABLE board(
id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
`code` VARCHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2), ...',
`name` VARCHAR(50) NOT NULL UNIQUE COMMENT '게시판이름',
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=삭제 전, 1= 삭제 후)',
delDate DATETIME COMMENT '삭제날짜'
);
INSERT INTO board(regDate,updateDate,`code`,`name`)VALUES
(NOW(),NOW(),'notice','공지사항'),
(NOW(),NOW(),'free','자유'),
(NOW(),NOW(),'Q&A','Q&A');

# 리엑션 테이블
DROP TABLE IF EXISTS reactionPoint;
CREATE TABLE reactionPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
	relId INT(10) NOT NULL COMMENT '관련 데이터  번호',
    `point` SMALLINT(2) NOT NULL COMMENT '좋아요 = 1, 싫어요= -1',
    FOREIGN KEY (relId) REFERENCES article(id) ON DELETE CASCADE
);

INSERT INTO reactionPoint (regDate,updateDate,memberId,relTypeCode,relId,`point`)VALUES
(NOW(),NOW(),1,'article',1,1),
(NOW(),NOW(),2,'article',1,1),
(NOW(),NOW(),3,'article',1,-1),
(NOW(),NOW(),1,'article',2,1),
(NOW(),NOW(),2,'article',2,1),
(NOW(),NOW(),3,'article',2,-1),
(NOW(),NOW(),1,'article',3,1),
(NOW(),NOW(),2,'article',3,1),
(NOW(),NOW(),3,'article',3,-1),
(NOW(),NOW(),1,'article',4,1),
(NOW(),NOW(),2,'article',4,1),
(NOW(),NOW(),3,'article',4,-1);

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`(
id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
memberId INT(10) NOT NULL,
relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
relId INT(10) NOT NULL,
`comment` VARCHAR(200) NOT NULL,
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부 (0=삭제 전, 1= 삭제 후)',
FOREIGN KEY (relId) REFERENCES article(id) ON DELETE CASCADE
);

INSERT INTO `comment`(regDate, updateDate, memberId,relTypeCode,relId,`comment`)VALUES
(NOW(),NOW(),2,'article',1,'댓글1'),
(NOW(),NOW(),2,'article',1,'댓글2'),
(NOW(),NOW(),3,'article',1,'댓글3'),
(NOW(),NOW(),3,'article',1,'댓글4'),
(NOW(),NOW(),1,'article',1,'댓글5');

# 수강신청 테이블생성
DROP TABLE IF EXISTS registeInfo;
CREATE TABLE registeInfo(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
courseId INT NOT NULL,
memberId INT NOT NULL,
`status` INT DEFAULT 0 COMMENT '0 = 미수료, 1 = 수료'
);

INSERT INTO registeInfo(regDate,updateDate,courseId,memberId)VALUES
(NOW(),NOW(),6,3),
(NOW(),NOW(),6,4),
(NOW(),NOW(),6,5),
(NOW(),NOW(),5,6),
(NOW(),NOW(),5,7);

# 연습 쿼리
SELECT * FROM attr;
SELECT * FROM `member`;
SELECT * FROM educationCourse;
SELECT * FROM article;
SELECT * FROM board;
SELECT * FROM registeInfo;

#        - 과목 명
#        - 과목 기간
#        - 진행 상황 %
#        - 수료 / 미수료
#        - 담당자 ( 담당자 전화번호 )
SELECT * FROM registeInfo WHERE memberId = 3;

SELECT R.* ,E.managerMemberId AS manager,E.startOfEducation AS `start`,E.endOfEducation AS `end`,E.title AS title
FROM registeInfo AS R 
INNER JOIN 
educationCourse AS E 
ON R.courseId = E.id
WHERE memberId = 3;

SELECT A.*,M.name AS extra__managerName, M.cellphoneNum AS extra__managerCellphoneNum FROM `member` AS M
INNER JOIN (SELECT R.* ,E.managerMemberId AS manager,E.startOfEducation AS `start`,E.endOfEducation AS `end`,E.title AS title
FROM registeInfo AS R 
INNER JOIN 
educationCourse AS E 
ON R.courseId = E.id
WHERE memberId = 3) AS A
ON M.id = A.manager;
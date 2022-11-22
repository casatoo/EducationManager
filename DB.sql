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
(NOW(),NOW(),DATE(20221021),DATE(20221120),'22-3기','1교육장',1),
(NOW(),NOW(),DATE(20220921),DATE(20221020),'22-2기','2교육장',2),
(NOW(),NOW(),DATE(20220821),DATE(20220920),'22-1기','3교육장',2);


# 연습 쿼리
DESC `member`;
SELECT * FROM `member`;
SELECT * FROM educationCourse;
SELECT E.*, M.name FROM educationCourse AS E INNER JOIN `member` AS M ON E.managerMemberId = M.id;

FROM article AS A
		INNER JOIN `member` AS M
		ON A.memberId
		= M.id
	SELECT * FROM `member` 
	WHERE `name` 
	LIKE '%3%'
	ORDER BY id DESC;

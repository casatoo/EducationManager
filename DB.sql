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
birthDay DATETIME NOT NULL,
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
(NOW(),NOW(),'admin','admin',DATE(1997-02-03),1,'관리자','kimminwoo','01012341234','asd@gmail.com'),
(NOW(),NOW(),'id1','pw1',DATE(1997-02-03),1,'직원','user1','0101235678','a333d@gmail.com'),
(NOW(),NOW(),'id2','pw2',DATE(1999-10-03),3,'사용자2','user2','01012345678','asddd@gmail.com'),
(NOW(),NOW(),'id3','pw3',DATE(2001-11-03),3,'사용자3','user3','01056789012','a21233@gmail.com'),
(NOW(),NOW(),'id4','pw4',DATE(2001-11-03),3,'사용자4','user4','01051234012','a212sdf3@gmail.com'),
(NOW(),NOW(),'id5','pw5',DATE(2001-11-03),3,'사용자5','user5','01056344312','a2sd33@gmail.com'),
(NOW(),NOW(),'id6','pw6',DATE(2001-11-03),3,'사용자6','user6','01052390122','a22313@gmail.com');


# 연습 쿼리
DESC `member`;
SELECT * FROM `member`;

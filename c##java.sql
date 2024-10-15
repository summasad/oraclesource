CREATE TABLE USERTBL(
	USERID VARCHAR2(20) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL,
	AGE NUMBER(3) NOT NULL,
	EMAIL VARCHAR2(20) NOT NULL
);

INSERT INTO USERTBL VALUES('hong123', '홍길동','hong123',25,'hong123@gmail.com');

--email 열 크기 50이로 변경
ALTER TABLE USERTBL MODIFY email VARCHAR2(50);

--userid(hong123) 와 password(hong123)가 일치하는 회원 조회
SELECT userid,name FROM USERTBL WHERE userid = 'hong123' AND password='hong123';

--회원 전체 조회
SELECT userid,name,age,EMAIL FROM USERTBL;

--비밀번호 변경
--아이디와 현재 비밀번호가 일치하면 새 비밀번호로 변경
UPDATE USERTBL SET PASSWORD = 'hong456' WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

SELECT * FROM USERTBL

--회원삭제
DELETE USERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

--booktbl
--code number(4) pk
--ti
CREATE TABLE booktbl(
	CODE NUMBER(4) PRIMARY KEY,
	TITLE VARCHAR2(50) NOT NULL,
	WRITER VARCHAR2(30) NOT NULL,
	PRICE NUMBER(10) NOT NULL
);

INSERT INTO BOOKTBL VALUES(1000, '자바의 정석','신용균',25000);
INSERT INTO BOOKTBL VALUES(1001, '자바의 신','강신용',29000);
INSERT INTO BOOKTBL VALUES(1002, '자바의 1000제','남궁성',32000);
INSERT INTO BOOKTBL VALUES(1003, '오라클','박응용',33000,null);
INSERT INTO BOOKTBL VALUES(1004, '점프투파이썬','신기성',35000,null);

--전체조회
SELECT * FROM BOOKTBL

--도서번호 1000번 조회(상세조회)
SELECT CODE,TITLE,WRITER,PRICE FROM BOOKTBL WHERE CODE = 1000;

--도서번호 1001번 도서 가격 수정
UPDATE BOOKTBL SET PRICE = 29000 WHERE CODE = 1001;

--도서번호 1001번 도서 가격 및 상세설명 수정
UPDATE BOOKTBL SET PRICE = 29000, DESCRIPTION = '' WHERE CODE = 1001;

--도서번호 1004번 도서 삭제
DELETE BOOKTBL WHERE CODE = 1004;

--도서명 '자바'키워드 들어있는 도서 조회
SELECT * FROM BOOKTBL WHERE TITLE LIKE '%자바%';

ALTER TABLE BOOKTBL ADD description varchar2(1000);












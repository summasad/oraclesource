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

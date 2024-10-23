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

CREATE TABLE MEMBERTBL(
	USERID VARCHAR2(20) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBERTBL VALUES('hong123', '홍길동','hong123');

SELECT * FROM MEMBERTBL 

--아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT USERID,NAME,PASSWORD FROM MEMBERTBL WHERE userid = 'hong123' AND password='hong123';

--중복 아이디 검사
SELECT * FROM MEMBERTBL WHERE userid = 'hong123';

--비밀번호 변경
UPDATE MEMBERTBL SET PASSWORD = 'hong456' WHERE USERID = 'hong123' AND PASSWORD = 'hong123';

CREATE TABLE BOARD(
	BNO NUMBER(8) PRIMARY KEY,
	NAME VARCHAR2(20) NOT NULL,
	PASSWORD VARCHAR2(20) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	content VARCHAR2(2000) NOT NULL,
	attach VARCHAR2(1000) NOT NULL,
	re_ref NUMBER(8) NOT NULL,
	re_lev NUMBER(8) NOT NULL,
	re_seq NUMBER(8) NOT NULL,
	readcnt NUMBER(8) DEFAULT '0',
	REGDATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE BOARD_SEQ;

--board attach not null ==> null 가능
ALTER TABLE BOARD MODIFY(attach NULL);

INSERT INTO BOARD(BNO,NAME,PASSWORD,title,content,re_ref,re_lev,re_seq)
values(BOARD_SEQ.nextval,'hong','12345','board 작성','board 작성',BOARD_SEQ.currval,0,0);

--수정
--bno와 password 일치 시 title, content 수정
UPDATE BOARD SET title = '제목', content='내용' WHERE BNO=1 AND PASSWORD =12345;

DELETE BOARD WHERE BNO = 1;

INSERT INTO BOARD(BNO,NAME,PASSWORD,title,content,re_ref,re_lev,re_seq) VALUES(board_seq.nextval,?,?,?,?,board_seq.currval,0,0)

UPDATE BOARD SET readcnt = READCNT + 1 WHERE BNO =3;

--더미 데이터
INSERT INTO BOARD(BNO,NAME,PASSWORD,title,content,re_ref,re_lev,re_seq)
(SELECT BOARD_SEQ.nextval,NAME,PASSWORD,title,content,board_seq.currval,re_lev,re_seq FROM BOARD);

SELECT count(*) FROM board;

--댓글처리
--가장 최신글에 댓글 달기
SELECT * FROM BOARD WHERE bno=(SELECT max(bno) FROM board);
--그룹 개념(re_ref)
--댓글 추가 인서트는 currval=>부모글의 re_ref 넣어주기
--re_lev : 부모글 re_lev + 1
--re_seq :부모글 re_seq + 1
INSERT INTO BOARD(BNO,NAME,PASSWORD,title,content,re_ref,re_lev,re_seq)
values(BOARD_SEQ.nextval,'hong','12345','board 작성','board 작성',514,1,1);

--UPDATE BOARD SET RE_LEV = 1, RE_SEQ = 1 WHERE bno=515;

--원본글과 댓글 함께 조회
SELECT * FROM BOARD WHERE re_ref = 514;

--두번째 댓글추가 (최신순 조회 : RE_SEQ)
--RE_SEQ 가 낮을 수록 최신글

--원본글
--ㄴ댓글2
--	ㄴ댓글2의 댓글
--ㄴ댓글1

-- 댓글2 추가
-- 먼저 들어간 댓글이 있다면 re_seq 값 +1 해야함
--UPDATE BOARD SET RE_SEQ =RE_SEQ +1 WHERE RE_REF = 514 AND RE_SEQ > 부모글 re_seq
UPDATE BOARD SET RE_SEQ =RE_SEQ +1 WHERE RE_REF = 514 AND RE_SEQ >0;

INSERT INTO BOARD(BNO,NAME,PASSWORD,title,content,re_ref,re_lev,re_seq)
values(BOARD_SEQ.nextval,'hong','12345','댓글 board 작성','댓글 board 작성',514,1,1);

SELECT * FROM BOARD WHERE RE_REF =514 ORDER BY RE_REF DESC, RE_SEQ ASC; 

--검색
--조건 title or content or name
--검색어
SELECT bno,name,title,readcnt,regdate,re_lev FROM BOARD WHERE title LIKE '%파일%' order by RE_REF DESC, RE_SEQ ASC;
SELECT bno,name,title,readcnt,regdate,re_lev FROM BOARD WHERE content LIKE '%답변%' order by RE_REF DESC, RE_SEQ ASC;
SELECT bno,name,title,readcnt,regdate,re_lev FROM BOARD WHERE name LIKE '%홍길동%' order by RE_REF DESC, RE_SEQ ASC;

--오라클 페이지 나누기
--정렬이 완료된 후 번호를 매겨서 일부분 추출
SELECT rownum, bno,name,title,readcnt,regdate,re_lev FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC; 

SELECT rownum, bno,name,title,readcnt,regdate,re_lev FROM BOARD ORDER BY bno DESC; 

SELECT rnum, bno,name,title,readcnt,regdate,re_lev
FROM (SELECT rownum rnum, bno,name,title,readcnt,regdate,re_lev
	  FROM (SELECT bno,name,title,readcnt,regdate,re_lev FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC)
	  WHERE rownum <= 20)
WHERE rnum > 10;

--1 page 요청 : rownum <= 10 rnum>0
--2 page 요청 : rownum <= 20 rnum>10
--3 page 요청 : rownum <= 30 rnum>20
--n page 요청 : rownum <= 10*n rnum>10*(n-1)


--memo 테이블 생성
--메모번호(mno), 메모내용(memo_text)

CREATE TABLE MEMO(
	MNO NUMBER(15) PRIMARY KEY,
	MEMO_TEXT VARCHAR2(200) NOT NULL	
);

CREATE SEQUENCE MEMO_SEQ;

DROP TABLE "MEMBER" ;
DROP SEQUENCE MEMO_SEQ;

INSERT INTO MEMO values(memo_seq.nextval, '오늘의 할일');

--회원, 팀
--회원은 단 하나의 팀에 소속된다.
--하나의 팀에는 여러 회원들이 소속된다.

--회원(아이디, 이름, 팀정보)
--팀(아이디, 팀명)

CREATE TABLE TEAM(
	TEAM_ID VARCHAR2(100) PRIMARY KEY,
	NAME VARCHAR2(100) NOT NULL
);

CREATE TABLE TEAM_MEMBER(
	MEMBER_ID VARCHAR2(100) PRIMARY KEY,
	USERNAME VARCHAR2(100) NOT NULL,
	TEAM_ID VARCHAR2(100) CONSTRAINT FK_MEMBER_TEAM REFERENCES TEAM(TEAM_ID)
);

INSERT INTO TEAM VALUES('TEAM1', '팀1');
INSERT INTO TEAM VALUES('TEAM2', '팀2');

INSERT INTO TEAM_MEMBER VALUES('USER1', '홍길동', 'TEAM1');

-- 홍길동이 소속된 팀의 이름 조회

SELECT TM.USERNAME, TM.MEMBER_ID, T.TEAM_ID, T.NAME FROM TEAM_MEMBER tm JOIN  TEAM t ON TM.TEAM_ID = T.TEAM_ID; 

--Hibernate 수식 : default는 외부조인(@ManyToOne)
SELECT
	m1_0.id,
	t1_0.id,
	t1_0.name,
	m1_0.user_name
FROM
	team_member m1_0
LEFT JOIN
        team t1_0 
            ON
	t1_0.id = m1_0.team_id
WHERE
	m1_0.id = 'user1';

--명시해주면 내부조인
SELECT
	m1_0.id,
	m1_0.team_id,
	m1_0.user_name
FROM
	team_member m1_0
JOIN
        team t1_0 
            ON
	t1_0.id = m1_0.team_id
WHERE
	t1_0.name =?

-- 회원 조회시 같은 팀에 소속된 회원 조회
-- 팀1

SELECT * FROM TEAM_MEMBER;

SELECT TM.USER_NAME, TM.ID, T.ID, T.NAME 
FROM TEAM t JOIN TEAM_MEMBER tm ON T.ID = TM.TEAM_ID WHERE T.NAME = '팀1';

UPDATE 	TEAM_MEMBER SET TEAM_ID = 'TEAM2'
WHERE TEAM_ID ='TEAM1';

--PARENT 삭제
--무결성 제약조건이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM PARENT p WHERE P.ID = 3;

--BOARD ID 기준으로 내림차순
SELECT * FROM BOARD b ORDER BY B.ID DESC;
SELECT * FROM BOARD b WHERE B.ID > 0 ORDER BY B.ID DESC;

-- 실행계획
--1) FULL
--2) RANGE SCAN : 처리할 정보량이 많을 때

--JpqlMember 와 Team 내부조인 : 팀명이 team2인 멤버 조회
SELECT * FROM JPQL_MEMBER jm JOIN JPQL_TEAM jt ON jm.TEAM_ID = jt.ID WHERE jt.NAME = 'team2';


SELECT * FROM BOARD b ;
--100번 게시물에 달린 댓글 가져오기
-- board 정보, reply 추출
SELECT b.*, r.* FROM BOARD b JOIN REPLY r ON b.bno= r.BOARD_BNO WHERE b.BNO =100;

SELECT count(ALL r.BOARD_BNO) FROM BOARD b JOIN REPLY r ON b.bno= r.BOARD_BNO WHERE b.BNO =30;
SELECT r.board_bno, COUNT(r.RNO) FROM REPLY r GROUP BY r.BOARD_BNO; 

SELECT b.bno, b.title, (SELECT COUNT(r.rno) FROM REPLY r WHERE b.bno= r.BOARD_BNO) AS r_cnt, b.WRITER_EMAIL, b.REGDATE FROM BOARD b; 
-- 게시물 , 작성자, 댓글개수 
SELECT b.bno, b.title, (SELECT COUNT(r.rno) FROM REPLY r WHERE b.bno= r.BOARD_BNO) AS r_cnt, b.WRITER_EMAIL, b.REGDATE, m.name 
FROM BOARD b JOIN member m ON b.WRITER_EMAIL = m.email; 

DELETE FROM BOARD b WHERE b.bno=4;
DELETE FROM REPLY r WHERE r.board_bno=4;

--booktbl + publisher+category
--카테고리명, 제목, 저자, 출판사명
SELECT
	b.title,
	b.writer,
	p.publisher_name,
	c.CATEGORY_NAME
FROM
	BOOKTBL b
JOIN PUBLISHER p ON b.PUBLISHER_PUBLISHER_ID = p.PUBLISHER_ID
JOIN CATEGORYTBL c ON b.CATEGORY_CATEGORY_ID = c.CATEGORY_ID;

--페이지 나누기 + 검색

SELECT *
FROM (SELECT rownum rn, b.* 
FROM (SELECT * FROM BOOKTBL ORDER BY BOOK_ID DESC) b
WHERE (title LIKE '%한글%' OR content LIKE '%나라%') 
AND rownum <= 20)
WHERE rn>10; 

SELECT t.book_id, t.title, t.writer, t.publisher_id, t.publisher_name, t.category_id, t.category_name
FROM 
(SELECT
	rownum rn,
	b1.*
FROM
	(
	SELECT
		*
	FROM
		BOOKTBL b
	JOIN PUBLISHER p ON
		b.PUBLISHER_PUBLISHER_ID = p.PUBLISHER_ID
	JOIN CATEGORYTBL c ON
		b.CATEGORY_CATEGORY_ID = c.CATEGORY_ID
	WHERE
		b.BOOK_ID > 0
	ORDER BY
		b.BOOK_ID DESC) b1
WHERE
	--(category_name LIKE '%소설%') AND 
	rownum <= 20) t
WHERE rn>10;








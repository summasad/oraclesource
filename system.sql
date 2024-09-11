--사용자 생성시 특정 문자열로 시작하는 user 생성을 안하겠음
--hr(c##hr)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--SCOTT에게 뷰 권한 부여
GRANT CREATE VIEW TO SCOTT;

--SCOTT에게 동의어 권한 부여
GRANT CREATE SYNONYM TO SCOTT;

--사용자 생성
--CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
--DEFAULT TABLESPACE 테이블스페이스명
--TEMPORARY TABLESPACE 테이블스페이스 그룹명
--QUOTA 테이블스페이스크기 ON 테이블스페이스명;

--공통 사용자 또는 롤 이름이 부적합합니다.
--오라클 버전 업데이트로 사용자 생성시 C## 붙여야함
CREATE USER C##TEST1 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

--권한 부여
GRANT CREATE SESSION TO C##TEST1;

--비밀번호 변경
ALTER USER C##TEST1 IDENTIFIED BY 54321;

--사용자 삭제
--CASCADE : 사용자에게 할당된 모든 객체를 삭제
DROP USER C##TEST1 CASCADE;

--권한 권리
--1) 시스템 권한
--	 사용자 생성, 수정, 삭제, 데이터베이스 접근, 오라클 데이터베이스 객체 생성 관리 권한 부여
--	 EX) 데이터베이스 접속 권한 : GRANT CREATE SESSION TO C##TEST1;
--2) 객체 권한
--	 특정 사용자가 생성한 테이블/인덱스/뷰/시퀀스 등과 관련된 권한
--	 EX) 데이터베이스 접속 권한 : GRANT SELECT,INSERT,DELETE ON BOARD TO C##TEST1;

-- 권한 취소
-- REVOKE CREATE TABLE FROM C##TEST1;
-- REVOKE SELECT,INSERT,DELETE ON BOARD FROM C##TEST1;

--C##TEST1 : 접속, 테이블 권한 부여 
GRANT CREATE SESSION, CREATE TABLE TO C##TEST1;

--롤 : 여러 개의 권한이 묶여서 정의되어 있음
--1) CONNECT : CREATE SESSION
--			   구 버전에 더 들어있었던 권한들이 빠졌음(CREATE TABLE, CREATE VIEW ...)
--2) RESOURCE 롤 : CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE 권한 들어 있음
--사용자 생성 후 CONNECT, RESOURCE 두개 부여
GRANT CONNECT, RESOURCE TO C##TEST1;



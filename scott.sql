-- SQL 쿼리문은 대소문자 구별하지 않음
-- 단, 비밀번호는 구별함
-- DML : 데이터 조작어(CRUD - Create / Read / Update / Delete) 작업 목적
-- 1) 조회
--SELECT 컬럼명 ----------⑤
--FROM 테이블명 -----------①
--WHERE 조건절 -----------②
--GROUP BY 컬럼명 --------③
--HAVING 집계함수 조건절 ----④
--ORDER BY 컬럼명... -----⑥ (양이 많으면 시간 오래 걸림, 잘 안씀)


-- EMP(employee - 사원)
-- DEPT(department - 부서 테이블)
-- SALGRADE (급여테이블)
-- 전체 조회
SELECT * FROM EMP e; --e는 별칭, 없어도 됨

-- 선택조회
-- 1) 컬럼 지정 조회
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;
	
-- 중복을 제거한 조회 : distinct

SELECT DISTINCT DEPTNO
FROM EMP e;

-- 별칭 붙여서 조회
SELECT EMPNO AS "사원번호"
FROM EMP e;

SELECT EMPNO "사원번호"
FROM EMP e;

SELECT EMPNO 사원번호 --중간에 공백 주고 싶으면 "" 필수
FROM EMP e;

SELECT EMPNO, ENAME, SAL,COMM, SAL*12+COMM AS "연봉" 
--AS 안붙이면 계산식 이름, 영어 기본, 한글 별칭
FROM EMP e;

-- 조회 후 정렬(오름차순-asc, 내림차순-desc)
-- sal 내림차순
-- 이름과 셀 조회
SELECT ENAME, SAL
FROM EMP e
ORDER BY sal DESC;

SELECT ENAME, SAL
FROM EMP e
ORDER BY SAL ASC; --ASC 생략 가능, 디폴트 어센딩

-- empno 내림차순
SELECT * FROM EMP e
ORDER BY EMPNO DESC;

--deptno 오름차순, sal 내림차순
SELECT * FROM EMP e
ORDER BY DEPTNO ASC, sal DESC; --ASC 생략 가능

-- emp 모든 열 출력
SELECT * FROM EMP

SELECT
	EMPNO AS "EMPLOYEE_NO",
	ENAME EMPLOYEE_NAME,
	MGR AS "MANAGER",
	SAL AS "SALARY",
	COMM AS "COMMISSION",
	DEPTNO AS "DEPARTMENT_NO"
FROM
	EMP e
ORDER BY
	EMPNO DESC,
	ENAME;

-- 선택조회
-- 2) 조건 지정 조회 
-- SELECT 컬럼나열,... FROM 테이블명 WHERE 조건 나열;
-- 부서번호가 30번인 사원을 전체조회
-- = : 같다, 동일하다
SELECT * FROM EMP e WHERE DEPTNO = 30;

-- 사원번호가 7839인 사원 조회
-- 사원번호는 중복되지 않음
-- WHERE 조건으로 중복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT * FROM EMP e WHERE EMPNO = 7839;

-- 결과가 단수인지 복수인지에 따라 자바에서 처리 방법 달라짐

--부서번호가 30이고(AND) 직책이 SALESMAN DLS 사원 조회 
-- 문자열은 홑따옴표만 사용
SELECT * FROM EMP e WHERE DEPTNO =30 AND JOB = 'SALESMAN';

-- 사원번호가 7698 부서번호가 30인 사원 조회
SELECT
	*
	FROM EMP e
WHERE
	EMPNO = 7698
	AND DEPTNO = 30;

--부서번호가 30 이거나 사원직책이 CLERK인 사원 조회
SELECT * FROM EMP e WHERE DEPTNO =30 OR JOB = 'CLERK';

--연봉이 36000인 사원조회
--SAL(월급)*12
SELECT * FROM EMP e WHERE SAL *12 = 36000;

--급여가 3000보다 큰 사원 조회
SELECT * FROM EMP e WHERE SAL>3000;
--급여가 3000이상인 사원 조회
SELECT * FROM EMP e WHERE SAL>=3000;

--ENAME이 F 이후의 문자열로 시작하는 사원 조회
SELECT * FROM EMP e WHERE E.ENAME >= 'F'; --문자도 숫자값 있음

--급여가 2500 이상이고 직업이 ANALYST 인 사원
SELECT * FROM EMP e WHERE SAL>=2500 AND JOB = 'ANALYST'
--직업이 MANAGER, SALESMAN, CLERK 인 사원 조회

SELECT * FROM EMP e WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN'OR JOB = 'CLERK';

--SAL 이 3000이 아닌 사원 조회 : != <> ^=
SELECT * FROM EMP e WHERE E.SAL != 3000;

SELECT * FROM EMP e WHERE E.SAL <> 3000;

SELECT * FROM EMP e WHERE E.SAL ^= 3000;

--IN / NOT IN
SELECT * FROM EMP e WHERE E.JOB IN ('MANAGER','SALESMAN','CLERK');

--직업이 MANAGER, SALESMAN, CLERK 이 아닌 사원 조회

SELECT * FROM EMP e WHERE JOB <> 'MANAGER' AND JOB ^= 'SALESMAN'AND JOB != 'CLERK';
SELECT * FROM EMP e WHERE E.JOB NOT IN ('MANAGER','SALESMAN','CLERK');

--부서번호가 10번이거나 20번인 조회
SELECT * FROM EMP e WHERE E.DEPTNO IN (10,20);

--BETWEEN A AND B : 일정 범위 데이터 조회
--급여가 2000이상 3000이하 인 직원 조회
SELECT * FROM EMP e WHERE E.SAL BETWEEN 2000 AND 3000;

--NOT BETWEEN A AND B : 해당 범위가 아닌 데이터 조회
SELECT * FROM EMP e WHERE E.SAL NOT BETWEEN 2000 AND 3000;

--LIKE 연산자와 와일드 카드(%,_ 두가지)
--ENAME = 'JONES' : 전체 일치
--ENAME 이 J 로 시작하는 OR A 가 들어간.. : 부분일치(LIKE 'A%')

--J% : J로 시작하면 그 뒤에 어떤 문자가 몇 개가 오던지 상관없음
SELECT * FROM EMP e WHERE ENAME LIKE 'J%';
--_J% : 어떤 문자로 시작해도 상관없으나 개수는 하나 / 두번째 문자는 J / %뒤는 뭐가 와도 상관없음
SELECT * FROM EMP e WHERE ENAME LIKE '_J%';
SELECT * FROM EMP e WHERE ENAME LIKE '__L%';

--사원명에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP e WHERE ENAME LIKE '%AM%';

SELECT * FROM EMP e WHERE ENAME NOT LIKE '%AM%';

--IS NULL (COMM = NULL는 안됨)
SELECT * FROM EMP e WHERE COMM IS NULL;
SELECT * FROM EMP e WHERE COMM IS NOT NULL;

--집합 연산자
--UNION : 합집합(결과 값의 중복 제거)
--UNION ALL : 합집합(결과 값의 중복 허용)
--MINUS : 차집합
--INTERSECT : 교집합

--UNION => 데이터가 많을 때 검색 속도가 빠른 질의문
--부서번호가 10번인 사원 조회(사번, 이름, 급여, 부서번호)
--부서번호가 20번인 사원 조회(사번, 이름, 급여)=> 합집합은 컬럼이 동일해야함, 오류
--합집합 컬럼은 타입 순서도 같아야함

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 10
UNION
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 20;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 10
UNION ALL
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 10;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e
MINUS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 10;

SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e
INTERSECT
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO
FROM EMP e WHERE E.DEPTNO = 10;
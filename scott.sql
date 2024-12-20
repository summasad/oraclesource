-- SQL 쿼리문은 대소문자 구별하지 않음 (데이터는 대소문자 구별)
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

-- ########################################
-- 함수
-- 1. 오라클 내장 함수
-- 2. 사용자 정의 함수 (PL/SQL)

-- 오라클 내장 함수
-- 1. 단일행 함수 : 데이터가 한 행씩 입력되고 입력된 한 행당 결과가 하나씩 나오는 함수
-- 2. 다중행 함수 : 여러 행 입력되고 결과는 하나의 행으로 반환되는 함수

-- 1) 문자함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫문자만 대문자, 나머지는 소문자로
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열 바이트 수
-- SUBSTR(문자열, 시작위치) / SUBSTR(문자열,시작위치,추출길이) : 문자열 일부 추출
-- INSTR(문자열, 찾으려는 문자) : 특정 문자나 문자열이 어디에 포함되어 있는지
-- INSTR(문자열, 찾으려는 문자, 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇 번째인지)
-- REPLACE(문자열, 찾는문자, 대체문자)
-- CONCAT(문자열1, 문자열2) : 문자열 연결 EX) CONCAT(EMPNO, ENAME). [ == || , EMPNO || ENAME]
-- TRIM / LTRIM / RTRIM : 특정 문자를 제거 (제거할 문자 특정하지 않으면 공백제거)
-- 버전마다 함수 다름, 회사마다 쓰는 버전 다름

-- 데이터는 대소문자 구분, 비교할때 하나로 통일해서 
SELECT E.ENAME, UPPER(E.ENAME), LOWER(E.ENAME), INITCAP(E.ENAME) 
FROM EMP e; 

SELECT * FROM EMP e;

-- smith
SELECT * 
FROM EMP e
WHERE UPPER(ENAME) = UPPER('smith'); --값과 같은 값 데이터 찾을때

SELECT * 
FROM EMP e
WHERE UPPER(ENAME) LIKE UPPER('%smith%'); --값을 포함하고 있는 데이터 찾을때  

--DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보기)
--LENGTH/LENGTHB 
--오라클 xe 21 버전에서 한글은 한글자에 3byte, 알파벳은 한글자에 1byte
SELECT LENGTH('한글'), LENGTHB('한글'), LENGTH('AB'), LENGTHB('AB')
FROM DUAL;

SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5)
FROM EMP e; 

-- '-' : 오른쪽 끝을 의미, 역순, -LENGTH(JOB) : 시작점
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)), SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB,5)
FROM EMP e; 

SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, 
	INSTR('HELLO, ORACLE!', 'L',5) AS INSTR_2, 
	INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_3 --2번째 문자부터 찾기 시작해서 찾은 값 중 두번째 L의 위치
FROM DUAL;

-- 사원 이름에 S가 있는 행 구하기
-- LIKE
SELECT *
FROM EMP e WHERE UPPER(E.ENAME) LIKE UPPER('%S%');

-- INSTR
SELECT *  
FROM EMP e WHERE INSTR(ENAME, 'S')>0; --값이 나오는 것만

-- REPLACE(문자열, 찾는문자, 대체문자)
-- 010-1234-1535
SELECT '010-1234-1535' AS REPLACE_BEFORE,
	REPLACE('010-1234-1535', '-', ' ') AS REPLACE_1,
	REPLACE('010-1234-1535', '-') AS REPLACE_2
FROM
	DUAL;

-- CONCAT(문자열1, 문자열2) : 문자열 연결
-- 인수 두개만 가질 수 있음, CONCAT 중첩해서 여러개 연결 CONCAT(A, CONCAT(':',B))
-- EMPNO, ENAME 연결
SELECT CONCAT(EMPNO, ENAME), CONCAT(EMPNO, CONCAT(':',ENAME))
FROM EMP e;

--|| == concat
SELECT EMPNO || ENAME, EMPNO||':'||ENAME
FROM EMP e;

SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS TRIM, --[_Oracle_]
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM, --[_Oracle_ ]
	'[' || LTRIM('<_Oracle_>','_<') || ']' AS LTRIM2, --[Oracle_>]
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM, --[ _Oracle_]
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2 --[<_Oracle]
FROM DUAL;

-- 2) 숫자 함수
-- ROUND(숫자,[반올림위치])
-- TRUNC(숫자,[버림위치])
-- CEIL(숫자) : 지정한 숫자와 가장 가까운 큰 정수 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자,나눌숫자) : 나머지 == %

SELECT ROUND(1234.5678) AS ROUND, --1235 
ROUND(1234.5678,0) AS ROUND_0, --1235
ROUND(1234.5678,1) AS ROUND_1, --1234.6
ROUND(1234.5678,2) AS ROUND_2, --1234.57
ROUND(1234.5678,-1) AS ROUND_MINUS1, --1230
ROUND(1234.5678,-2) AS ROUND_MINUS2 --1200
FROM DUAL;

SELECT TRUNC(1234.5678) AS TRUNC, --1234 
TRUNC(1234.5678,0) AS TRUNC_0, --1234
TRUNC(1234.5678,1) AS TRUNC_1, --1234.5
TRUNC(1234.5678,2) AS TRUNC_2, --1234.56
TRUNC(1234.5678,-1) AS TRUNC_MINUS1, --1230
TRUNC(1234.5678,-2) AS TRUNC_MINUS2 --1200
FROM DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15,6)
FROM DUAL;

-- 3) 날짜함수
-- SYSDATE : ORACLE 서버가 설치된 OS의 현재 날짜와 시간 사용
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일수 이후의 날짜
-- 날짜 데이터 - 날짜 데이터 : 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 오류, 안됨
-- ADD_MONTHS(날짜데이터, 더할 개월수) : 응용해서 연도도 더함
-- MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 두 날짜 데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜데이터, 요일문자) : 날짜 데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날짜 조회

SELECT SYSDATE FROM DUAL;

SELECT SYSDATE, SYSDATE-1, SYSDATE+1 FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL; --3개월 후

-- 입사 20주년 조회
SELECT E.EMPNO, E.ENAME, E.HIREDATE, ADD_MONTHS(HIREDATE, 240) 
FROM EMP e;

SELECT 
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE, 
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, 
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	EMP e;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE) FROM DUAL; 

-- 4) 형변환 함수
-- TO_CHAR(날짜데이터, '출력되길 원하는 문자형태')
-- TO_NUMBER(문자데이터, '인식되길 원하는 숫자형태')
-- TO_DATE(문자데이터, '인식되길 원하는 날짜형태')


-- NUMBER + '문자숫자' = 연산해줌, 타입 자동 형변환
-- 정해진 타입을 벗어나는 연산은 못함. NUMBER + 'ABC' = 오류
--오라클은 컬럼에 일관성 있는 데이터 유형 가져야함, 숫자 || '' =>문자화

SELECT E.EMPNO, E.ENAME, E.EMPNO+'500' 
FROM EMP e;

--수치가 부적합합니다
--SELECT E.EMPNO, E.ENAME, E.EMPNO+'ABCD' 
--FROM EMP e;

-- 날짜데이터 => 문자데이터
-- 자바는 월mm 분MM, 오라클은 월MM 분MI 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS 현재날짜
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MM') AS 현재월, TO_CHAR(SYSDATE, 'MON') AS 현재월2, TO_CHAR(SYSDATE, 'MONTH') AS 현재월3 -- 영어는 값차이있음
FROM DUAL;

--DD, DDD, DAY
SELECT TO_CHAR(SYSDATE, 'DD') AS 현재일, TO_CHAR(SYSDATE, 'DDD') AS 현재일2, TO_CHAR(SYSDATE, 'DAY') AS 현재일3 
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH:MI:SS') AS 현재시간,
	TO_CHAR(SYSDATE, 'HH12:MI:SS') AS 현재시간2,
	TO_CHAR(SYSDATE, 'HH24:MI:SS') AS 현재시간3,
	TO_CHAR(SYSDATE, 'HH24:MI:SS AM') AS 현재시간4
FROM
	DUAL;

--문자데이터 => 숫자데이터
SELECT 1300 -'1500', '1300' + 1500
FROM DUAL;

SELECT '1300' + '1500'
FROM DUAL;

-- 수치가 부적합합니다(, 가 포함되면 문자로 처리)
-- SELECT '1,300' + '1,500'
-- FROM DUAL;

--TO_NUMBER(문자데이터, '인식되길 원하는 숫자형태')
--9(숫자 한자리를 의미) OR 0(숫자 한자리:빈자리를 채움, 소수점할때 사용)
SELECT TO_NUMBER('1,300','999,999')  + TO_NUMBER('1,500','999,999')
FROM DUAL;

--문자데이터 => 날짜데이터
SELECT TO_DATE('2024-09-05', 'YYYY-MM-DD') AS TODATE1, TO_DATE('20240905', 'YYYY-MM-DD') AS TODATE2
FROM DUAL;

-- EMP 테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT * 
FROM EMP e WHERE E.HIREDATE > '1981-06-01';

SELECT * 
FROM EMP e WHERE E.HIREDATE > TO_DATE('1981-06-01','YYYY-MM-DD');

-- 날짜 데이터 + 날짜 데이터
SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02') --247, 일수
FROM DUAL;
--날짜와 날짜의 가산은 할 수 없습니다
--SELECT TO_DATE('2024-09-05') + TO_DATE('2024-01-02') 
--FROM DUAL;

--NULL 처리 함수
--NULL 과 산술연산이 안됨 => NULL을 다른 값으로 변경
--NVL(널값,대체할값)
--NVL2(널값, 널이 아닌경우 반환값, 널인 경우 반환값)
--IS NULL (SAL=NULL(X))

SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, E.SAL + E.COMM, E.SAL + NVL(E.COMM, 0)
FROM EMP e; 

SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, NVL2(E.COMM, '0', 'X')
FROM EMP e; 

--연봉구하기, 커미션 있을때와 없을때
--널이 아니면 SAL*12*COMM
--널이면 SAL*12
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, NVL2(E.COMM, SAL*12+COMM, SAL*12)
FROM EMP e; 

-- 5)DECODE 함수 / CASE 문
--DECODE(데이터,
--		조건1, 조건1을 만족할 때 해야할 것,
--		조건2, 조건2을 만족할 때 해야할 것,
--		) AS 별칭

--JOB이 MANAGER라면 SAL*1.1
--JOB이 SALESMAN 이라면 SAL*1.5
--JOB이 ANALYST라면 SAL
--		그 외 라면 SAL * 1.03

SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	DECODE(JOB, 
	'MANAGER', E.SAL*1.1,
	'SALESMAN', E.SAL*1.5,
	'ANALYST', E.SAL,
	E.SAL*1.03) AS UPSAL --그외 
FROM
	EMP e; 

SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	CASE
		JOB 
	WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL * 1.5
		WHEN 'ANALYST' THEN E.SAL
		ELSE E.SAL * 1.03
	END AS UPSAL
FROM
	EMP e;

--COMM 널일때 '해당사항없음'
--COMM = 0 일때 '수당없음'
--COMM > 0 일때 '수당 : COMM'
--서로 다른 조건은 CASE에 공동 조건 못적고 하나씩 나열
SELECT
	E.EMPNO,
	E.ENAME,
	E.COMM,
	CASE
		WHEN E.COMM IS NULL THEN '해당사항없음'
		WHEN COMM=0 THEN '수당없음'
		WHEN COMM>0 THEN '수당 : '||COMM
	END AS COMM_TEXT
FROM
	EMP e;
	
--EMP 테이블에서 사원들의 월평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 봤을 때
--사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다
--사번, 이름, SAL, DAY_PAY, TIME_PAY 출력
--단, 하루 급여는 소수점 셋째자리에서 버리고 시급은 두번째 소수점에서 반올림하기
SELECT E.EMPNO, E.ENAME, E.SAL, TRUNC(SAL/21.5,2) AS DAY_PAY, ROUND (SAL/(21.5*8),1) AS TIME_PAY
FROM EMP e;


--EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원들의
--정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력한다.
--사번,이름,고용일,R_JOB 출력
SELECT E.EMPNO, E.ENAME, E.HIREDATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), '월요일'), 'YYYY-MM-DD') AS R_JOB
FROM EMP e;

--+추가수당
--COMM이 없으면 'N/A', 있으면 COMM
--COMM 컬럼에 숫자와 문자 형식 통일하기
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE
		WHEN COMM IS NULL THEN 'N/A'
		WHEN COMM IS NOT NULL THEN COMM || ''
	END AS COMM
FROM
	EMP e;

SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL2(COMM,COMM || '','N/A') AS COMM --NVL(TO_CHAR(COMM),'N/A') AS COMM
FROM
	EMP e;

--EMP테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 변환해서 CHG_MGR에 출력 
--사번,이름,MGR,CHG_MGR 출력
--조건
--MGR이 널이면 '0000'/ MGR의 앞 두자리가 75이면 '5555'/76이면 '6666'/77이면 '7777'/78이면'8888' 출력/ 79 이면 MGR 그대로
SELECT E.EMPNO, E.ENAME, E.MGR, 
CASE 
	WHEN MGR IS NULL THEN '0000'	
	WHEN SUBSTR(MGR,0,2)='75' THEN '5555'
	WHEN SUBSTR(MGR,0,2)='76' THEN '6666'
	WHEN SUBSTR(MGR,0,2)='77' THEN '7777'
	WHEN SUBSTR(MGR,0,2)='78' THEN '8888'
	WHEN SUBSTR(MGR,0,2)='79' THEN MGR || ''
END AS CHG_MGR
FROM
	EMP e;

SELECT E.EMPNO, E.ENAME, E.MGR, 
CASE 
	WHEN MGR IS NULL THEN '0000'	
	WHEN MGR LIKE '75%' THEN '5555'
	WHEN MGR LIKE '76%' THEN '6666'
	WHEN MGR LIKE '77%' THEN '7777'
	WHEN MGR LIKE '78%' THEN '8888'
	ELSE MGR || ''
END AS CHG_MGR
FROM
	EMP e;

SELECT E.EMPNO, E.ENAME, E.MGR, 
	DECODE(SUBSTR(TO_CHAR(MGR),1,2),
	NULL,'0000',
	'75','5555',
	'76','6666',	
	'77','7777',
	'78','8888',		
	SUBSTR(TO_CHAR(MGR),1)
	)AS CHG_MGR
FROM
	EMP e;

-- 2.다중행 함수
-- SUM(합계를 낼 열) COUNT(), MAX(), MIN(), AVG()
-- DISTINCT : 중복제거

SELECT SUM(SAL), 
FROM EMP;

SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP;

SELECT COUNT(DISTINCT SAL), COUNT(ALL SAL), COUNT(SAL)
FROM EMP;

SELECT MAX(SAL), MIN(SAL) FROM EMP e; 

SELECT MAX(SAL), MIN(SAL) FROM EMP e WHERE E.DEPTNO = 10;

--부서번호가 20번인 사원의 최근 입사일 조회
SELECT MAX(HIREDATE) FROM EMP e WHERE DEPTNO =20;

SELECT MIN(HIREDATE) FROM EMP e WHERE DEPTNO =20;

SELECT AVG(DISTINCT SAL), AVG(ALL SAL), AVG(SAL)
FROM EMP;

--부서번호가 30번인 사원들의 평균 추가수당
SELECT AVG(COMM) FROM EMP e WHERE DEPTNO =30;

--GROUP BY 그룹화할 열: 결과값을 원하는 열로 묶어 출력
--각 부서별 평균 급여 출력
SELECT DEPTNO, AVG(SAL)
FROM EMP e
GROUP BY DEPTNO
ORDER BY DEPTNO;

--각 부서별, 직책별 평균 급여 출력

SELECT DEPTNO, JOB , AVG(SAL)
FROM EMP e
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--GROUP BY 절을 사용할 때에는 SELECT 절에 그룹화한 절만 넣어야 함
--SELECT 가능 : GROUP BY 절, 다중행함수
--SELECT ENAME, AVG(SAL)
--FROM EMP e
--GROUP BY DEPTNO;

-- GROUP BY ~ HAVING : 그룹바이 절에 조건을 줄 때 사용
-- 각 부서에 직책별 평균 급여(평균 급여가 2000 이상인 그룹만 조회)
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP e
GROUP BY DEPTNO, JOB
HAVING AVG(SAL)>= 2000
ORDER BY DEPTNO, JOB;

--WHERE 절에 그룹함수는 허가되지 않음
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP e
--WHERE AVG(SAL)>= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--부서별 평균급여, 최고급여, 최저급여, 사원 수 출력
--평균 급여 출력시 소수점 제외하고 출력
SELECT DEPTNO, FLOOR(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(DEPTNO)
FROM EMP e 
GROUP BY DEPTNO
ORDER BY DEPTNO;

--같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT E.JOB, COUNT(JOB)
FROM EMP e
GROUP BY JOB
HAVING COUNT(JOB)>=3;

--사원들의 입사년도를 기준으로 부서별로 몇 명의 입사인원이 있는지 출력
--1987 20 2
SELECT TO_CHAR(E.HIREDATE,'YYYY') AS HIRE_YEAR, DEPTNO, COUNT(*) AS CNT
FROM EMP e 
GROUP BY TO_CHAR(E.HIREDATE,'YYYY'), DEPTNO
ORDER BY HIRE_YEAR, DEPTNO;

-- JOIN(조인) : 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 출력
-- 여러 테이블 조인과 서브쿼리 필수
-- 테이블 잘게 쪼개서 조합해서 씀
-- 1)내부조인(inner join)
--	등가조인(*) : 가장 많이 씀, 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
--	비등가조인
-- 2)외부조인(outer join)
-- 왼쪽 외부조인(Left Outer Join) : 오른쪽 테이블에 +기호
-- 오른쪽 외부조인(Right Outer Join) : 왼쪽 테이블에 +기호
-- 전체 외부조인(Full Outer Join) : 잘 안사용함

--SELECT * FROM EMP, DEPT d; --12*4 나올 수 있는 모든 조합, 조건을 걸어야함

--1)내부조인
--등가조인 : EMP 테이블의 DEPTNO 와 DEPT 테이블의 DEPTNO 가 일치 시 연결, 앞 테이블 기준으로 추출
--필드명 중복될 때 별칭 찍어서 명확히 해야함
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO;

--+ sal 3000 이상인 사원 조회

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC, E.SAL 
FROM EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO AND sal>=3000;

-- 비등가조인 : 등가조인 이외의 방식
-- EMP/ SALGRADE 에 일치하는 컬럼명 없을때 조건 조인
SELECT *
FROM EMP e, SALGRADE s
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 자체조인 : 테이블내 항목 조인 - 중복 호출, 별칭
-- MGR의 이름 조회
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE E1.MGR = E2.EMPNO; 

--외부조인
--Left Outer Join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE E1.MGR = E2.EMPNO(+); 

--Right Outer Join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE E1.MGR(+) = E2.EMPNO; 

--개선된 쿼리문 : 명확하게 명시함
--내부조인 : join ~ on
--외부조인 : (left) outer join ~ on - left가 디폴트라 생략가능
--	(right) outer join ~ on

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP e JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO;

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC, E.SAL 
FROM EMP e JOIN DEPT d 
ON E.DEPTNO = D.DEPTNO WHERE sal>=3000;

SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1 LEFT OUTER JOIN EMP e2
ON E1.MGR = E2.EMPNO; 

SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1 RIGHT OUTER JOIN EMP e2
ON E1.MGR = E2.EMPNO; 

--TABLE 3개 조인
SELECT *
FROM EMP e1 JOIN EMP e2 ON e1.MGR = e2.EMPNO JOIN EMP e3 ON e1.MGR = e3.EMPNO;

--각 부서별 평균급여, 최대급여, 최소급여, 사원수를 조회
--부서번호, 부서명, 평균급여(AVG_SAL), 최대급여(MAX_SAL), 최소급여(MIN_SAL), 사원수(CNT)
SELECT e.DEPTNO, D.DNAME, AVG(e.SAL) AS AVG_SAL, MAX(E.SAL) AS MAX_SAL, MIN(E.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO
GROUP BY e.DEPTNO, D.DNAME 
ORDER BY e.DEPTNO; 

--모든 부서정보와 사원 정보를 조회
--부서번호, 부서명, 사원번호, 사원명, 직무(JOB), 급여

SELECT D.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL 
FROM DEPT d LEFT OUTER JOIN EMP e
ON D.DEPTNO= E.DEPTNO
ORDER BY D.DEPTNO, E.DEPTNO;

--서브쿼리 : 쿼리문 안에 또 다른 쿼리문 포함 (SELECT, INSERT, UPDATE, DELETE)
--SELECT 
--FROM 
--WHERE (SELECT FROM WHERE)

--SELECT 
--FROM (SELECT FROM WHERE)
--WHERE 

--SELECT (SELECT FROM WHERE)
--FROM 
--WHERE 

--JONES 보다 월급을 많이 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.SAL > (
	SELECT
		E2.SAL
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'JONES');
	
--연산자
--1)실행결과가 하나인 단일행 서브쿼리
-->, >=, =, <, <=, <>, !=,^=
	
--KING 보다 빠른 입사자
SELECT	* FROM	EMP e
WHERE E.HIREDATE < (SELECT E2.HIREDATE FROM EMP e2 WHERE E2.ENAME = 'KING');

--ALLEN 보다 추가수당 많이 받는 사원
SELECT	* FROM	EMP e
WHERE E.COMM > (SELECT E2.COMM FROM EMP e2 WHERE E2.ENAME = 'ALLEN');

--20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회
SELECT	* FROM	EMP e
WHERE E.DEPTNO=20 AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP e2);

--20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회
--부서명, 부서위치
SELECT	E.*, D.DNAME, D.LOC FROM EMP e JOIN DEPT d ON E.DEPTNO =D.DEPTNO 
WHERE E.DEPTNO=20 AND E.SAL > (SELECT AVG(E2.SAL) FROM EMP e2);

--2)실행 결과가 여러개 인 다중행 서브쿼리
--IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 TRUE 
--ANY(==SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
--ALL : 메인 쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 TRUE
--EXISTS : 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상인 경우) TRUE

--각 부서별 최고 급여와 동일하거나 큰 급여를 받는 사원 조회
--단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT *
FROM EMP e 
WHERE E.SAL IN (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2. DEPTNO);

--IN == =ANY
SELECT *
FROM EMP e 
WHERE E.SAL = ANY (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2. DEPTNO);

SELECT *
FROM EMP e 
WHERE E.SAL = SOME (SELECT MAX(E2.SAL) FROM EMP e2 GROUP BY E2. DEPTNO);

--30번 부서의 급여보다 적은 급여를 받는 사원 조회
--E.SAL 보다 큰 수가 서브쿼리에 하나만 있어도 TRUE = MAX(서브쿼리값)
--0번 부서의 최대 급여보다 적은 급여를 받는 사원 조회 결과와 같아짐
SELECT *
FROM EMP e 
WHERE E.SAL < ANY (SELECT E2.SAL FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;
--단일행 가능
SELECT *
FROM EMP e 
WHERE E.SAL < (SELECT MAX(E2.SAL) FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

--30번 부서의 급여보다 많은 급여를 받는 사원 조회
SELECT *
FROM EMP e 
WHERE E.SAL > ANY (SELECT E2.SAL FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

SELECT *
FROM EMP e 
WHERE E.SAL > (SELECT MIN(E2.SAL) FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

--30번 부서의 급여보다 적은 급여를 받는 사원 조회 = 최소급여보다 작은 값
--ALL
SELECT *
FROM EMP e 
WHERE E.SAL < ALL (SELECT E2.SAL FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

--ALL
SELECT *
FROM EMP e 
WHERE E.SAL < (SELECT MIN(E2.SAL) FROM EMP e2 WHERE E2.DEPTNO = 30)
ORDER BY E.SAL, E.EMPNO;

--EXISTS(잘 안씀, 서브쿼리가 존재만 한다면 TRUE)
SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 10);

SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 50);

--비교할 열이 여러 개인 다중열 서브쿼리 => 비교 항목 맞춰야함
SELECT *
FROM EMP E
WHERE(DEPTNO,SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP e2 GROUP BY DEPTNO);

--FROM 절에 작성하는 서브쿼리(==인라인뷰) 작성
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP e WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) d 
WHERE E10.DEPTNO = D.DEPTNO;

-- SELECT 절에 작성하는 서브쿼리(== 스칼라 서브쿼리), 대부분의 서비스
-- SELECT 절에 작성하는 서브쿼리는 단 하나의 결과만 반환해야 함
SELECT E.EMPNO, E.JOB, E.SAL, (SELECT GRADE FROM SALGRADE s WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE,
E.DEPTNO, (SELECT DNAME FROM DEPT d WHERE E.DEPTNO = D.DEPTNO) AS DNAME
FROM EMP E;

--INSERT(삽입)

--테이블 복사
CREATE TABLE dept_temp AS SELECT*FROM DEPT;

SELECT *FROM dept_temp;

--열 이름 나열 하는 부분은 생략 가능
--INSERT INTO 테이블명(열이름1, 열이름2...)
--VALUES(열 이름에 맞춰 값 나열)

INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES (50,'DATABASE','SEOUL');

INSERT INTO DEPT_TEMP
VALUES (60,'DATABASE','SEOUL');

INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES (70,'DATABASE',NULL);

INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES (80,'DATABASE');

CREATE TABLE EMP_temp AS SELECT*FROM EMP;
SELECT * FROM EMP_TEMP;

--전체 필드에 값을 추가할 때
--날짜 데이터 : - OR /
INSERT INTO EMP_TEMP VALUES (9999,'홍길동','PRESIDENT',NULL,'2001-01-01',5000,1000,10);

--부분적으로 값을 추가 시
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) 
VALUES (8888,'성춘향','SALESMAN',SYSDATE,3000,20);

--날짜 년/월/일 => 틀리면 날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) 
VALUES (7777,'이순신','SALESMAN',TO_DATE('07/08/2023','DD,MM,YYYY'),3000,20);

--테이블 제거
DROP TABLE EMP_TEMP;

--테이블 복사 시 테이블의 구조만 복사하고 데이터는 복사하지 않을 때
CREATE TABLE EMP_temp AS SELECT*FROM EMP WHERE 1<>1; --조건을 다 FALSE
SELECT * FROM EMP_TEMP;

--EMP 테이블과 SALGRADE 조인 후 급여 등급 1인 사원들만 EMP_TEMP에 삽입(서브쿼리)
--데이터가 추가되는 열 개수와 서브쿼리 열 개수 일치/ 자료형 일치
--VALUES 자리에 자료 추출 서브쿼리
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO 
FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE = 1; 

--UPDATE(수정)

--UPDATE 변경 테이블명
--SET 변경할 열=값, 변경할 열=값,...
--WHERE 변경할 대상 행 조건
SELECT * FROM DEPT_TEMP;

--모든 행의 LOC를 SEOUL로 변경
UPDATE DEPT_TEMP 
SET LOC='SEOUL';

CREATE TABLE DEPT_temp2 AS SELECT*FROM DEPT;
SELECT * FROM DEPT_TEMP2;

--40번 부서의 부서명 DATABASE, LOC는 SEOUL로 변경
UPDATE DEPT_TEMP2 SET DNAME = 'DATABASE', LOC = 'SEOUL'
WHERE DEPTNO = 40;

--EMP_TEMP 의 사원들 중에서 급여가 2500 이하인 사원들의 추가 수당을 50으로 수정
UPDATE EMP_TEMP SET COMM = 50 WHERE SAL<=2500;

SELECT * FROM EMP_TEMP;

--DEPT 테이블의 DEPTNO=40 부서의 DNAME,LOC를 추출해서 DEPT_TEMP2의 DNAME, LOC 수정(원복)
UPDATE
	DEPT_TEMP2
SET
	(DNAME,
	LOC) = (
	SELECT
		DNAME,
		LOC
	FROM
		DEPT
	WHERE
		DEPTNO = 40)
WHERE
	DEPTNO = 40;

--DELETE : 데이터 삭제
--1) DELETE 테이블명 WHERE 삭제할 조건
--2) DELETE FROM 테이블명 WHERE 삭제할 조건
--DELETE 테이블명; 전체 데이터 삭제

CREATE TABLE EMP_TEMP2 AS SELECT*FROM EMP;
SELECT * FROM EMP_TEMP2;

--JOB = 'MANAGER'인 사원 삭제
DELETE EMP_TEMP2 WHERE JOB = 'MANAGER';

--전체 삭제
DELETE FROM EMP_TEMP2;

--EMP 테이블 행 전부 추출 후에 삽입
INSERT INTO EMP_TEMP2(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO 
FROM EMP E;

--서브쿼리
--급여 등급이 3등급이고 부서번호가 30번인 사원 삭제

DELETE
FROM
	EMP_TEMP2
WHERE
	EMPNO IN(
	SELECT
		E.EMPNO
	FROM
		EMP_TEMP2 E
	JOIN SALGRADE s ON
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 3
		AND E.DEPTNO = 30);

--테이블 복사
--EMP,DEPT,SALGRADE 테이블 복사
--EXAM_EMP,EXAM_DEPT,EXAM_SALGRADE 로 생성
CREATE TABLE EXAM_EMP AS SELECT*FROM EMP WHERE 1<>1;
CREATE TABLE EXAM_DEPT AS SELECT*FROM DEPT WHERE 1<>1;
CREATE TABLE EXAM_SALGRADE AS SELECT*FROM SALGRADE WHERE 1<>1;
	
--INSERT
--EXAM_DEPT 테이블에 50,60,70,80, 부서 등록
--50:ORACLE, BUSAN / 60:SQL,ILSAN / 70: SELECT, INCHEON / 80:DML,BUNDANG
SELECT * FROM EXAM_DEPT;
INSERT INTO EXAM_DEPT
VALUES (50,'ORACLE','BUSAN');
INSERT INTO EXAM_DEPT
VALUES (60,'SQL','ILSAN');
INSERT INTO EXAM_DEPT
VALUES (70,'SELECT','INCHEON');
INSERT INTO EXAM_DEPT
VALUES (80,'DML','BUNDANG');

--EXAM_EMP 사원 등록
--7201, TEST_USER1, MANAGRE, 7788, 2016-01-02, 4500, NULL, 50
--7202, TEST_USER2, CLERK, 7201, 2016-02-21, 1800, NULL, 50
--7203, TEST_USER3, ANALYST, 7201, 2016-04-11, 3400, NULL, 60
--7204, TEST_USER4, SALESMAN, 7201, 2016-05-31, 2700, 300, 60	
--7205, TEST_USER5, CLERK, 7201, 2016-07-20, 2600, NULL, 70
--7206, TEST_USER6, CLERK, 7201, 2016-09-08, 2300, NULL, 70
--7207, TEST_USER7, LECTURER, 7201, 2016-10-28, 4500, NULL, 80
SELECT * FROM EXAM_EMP;
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES (7201, 'TEST_USER1', 'MANAGRE', 7788, '2016-01-02', 4500, NULL, 50);
INSERT INTO EXAM_EMP
VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50);
INSERT INTO EXAM_EMP
VALUES (7203, 'TEST_USER3', 'ANALYST', 7201,'2016-04-11', 3400, NULL, 60);
INSERT INTO EXAM_EMP
VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60);
INSERT INTO EXAM_EMP
VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO EXAM_EMP
VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2300, NULL, 70);
INSERT INTO EXAM_EMP
VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 4500, NULL, 80);

--UPDATE
--EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의평균 급여보다 많은 급여를 받고 있는 사원들을
--70번 부서로 변경
UPDATE EXAM_EMP
SET DEPTNO = 70
WHERE SAL> (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);  

--EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10%인상하고 80번 부서로 변경
UPDATE EXAM_EMP
SET SAL=SAL*1.1, DEPTNO=80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);

--DELETE
--EXAM_EMP에 속한 사원 중 급여 등급이 5인 사원 삭제
DELETE
FROM
	EXAM_EMP
WHERE
	EMPNO IN(
	SELECT
		E.EMPNO
	FROM
		EXAM_EMP E
	JOIN SALGRADE s ON
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 5);

SELECT * FROM EXAM_EMP;

--트랜잭션 : 최소수행단위
--		 EX) 은행계좌이체
--		 COMMIT(반영), ROLLBACK(취소)
--INSERT, DELETE, UPDATE => 데이터 변화


--AUTO-COMMIT : 자동 반영
--NONE

--취소 불가한 트랜잭션 시작
CREATE TABLE DEPT_TCL AS SELECT*FROM DEPT;
--트랜잭션 종료

--트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT*FROM DEPT_TCL;
--트랜젝션 종료

--트랜잭션 취소
ROLLBACK;
SELECT*FROM DEPT_TCL;
--취소 불가한 트랜잭션 이후로 진행된 트랜잭션 취소

--트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT*FROM DEPT_TCL;

--트랜잭션 반영
COMMIT;
--최종 반영. 트랜잭션 종료.

--AUTO-COMMIT 해제한 상황에서 ROLLBACK~COMMIT 사이의 트랜잭션은 한 그룹, 같이 반영
SELECT*FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
COMMIT;

UPDATE DEPT_TCL SET LOC = 'SEOUL' WHERE DEPTNO=30;
COMMIT;

--DDL(데이터 정의어)
--데이터베이스 데이터를 보관하고 관리하기 위해 제공되는 여러 객체의 생성/변경/삭제 관련 기능
--CREATE(생성) / ALTER(생성된 객체 변경) / DROP(생성된 객체 삭제)

--1. 테이블 정의어
--CREATE TABLE 테이블이름(
--	열이름1 자료형,
--	열이름2 자료형,
--	열이름3 자료형,
--	열이름4 자료형,
--)

--1)테이블 이름 작성 규칙
--문자로 시작(한글 가능하지만 사용안함), 숫자로 시작 못함
--테이블 이름은 길이의 제한이 있음(30바이트)
--같은 소유자 소유의 테이블 이름은 중복이 불가능함
--SQL 키워드는 사용 불가

--2)열이름 생성 규칙
--문자로 시작, 숫자로 시작못함
--길이의 제한 있음(30바이트)
--한 테이블에 열 이름 중복 불가
--열 이름은 영문자, 숫자, 특수문자 사용 가능
--SQL 키워드는 사용 불가

--3)자료형
--문자 : VARCHAR2(길이), NVARCHAR2(길이), CHAR(길이), NCHAR(길이)
--		VAR: 가변, EX)NAME VARCHAR2(10) : 홍길동 => 실제 사용된 만큼만 사용, 9바이트
--					NAME CHAR(10) : 홍길동 (10BYTE), 고정길이
--		DB 버전에 따라 한글 문자 하나당 2BYTE할당 OR 3바이트 할당
--		NAME VARCHAR2(10) : '홍길동전' => 오류, 용량초과
--		NVARCHAR2(10), NCHAR() : 10이 바이트 개념이 아니라 문자 길이 자체를 의미
--숫자 : NUMBER(전체 자리수, 소수점 자리수)
--날짜 : DATE
--BLOB : 대용량 이진테이터 저장
--CLOB : 대용량 텍스트데이터 저장

--CREATE : 생성
CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4,0),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0)
)
--테이블 복사해서 생성
CREATE TABLE DEPT_DDL AS SELECT*FROM DEPT;
--값은 비우고 열구조 복사한 테이블 복사 생성
CREATE TABLE DEPT_DDL2 AS SELECT*FROM DEPT WHERE 1<>1;

--ALTER : 변경
-- 새로운 열 추가 / 열 이름 변경 / 열 삭제 / 열 자료형 변경
-- EMP_DDL에 새로운 열(HP : 010-1211-5637) 추가 (자주 사용 안함)
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
SELECT * FROM EMP_DDL ed; 

--컬럼명 변경 HP=>TEL
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

--타입 변경 EMPNO NUMBER(5)로 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

--컬럼 삭제 TEL 삭제
ALTER TABLE EMP_DDL DROP COLUMN TEL; 

--테이블 이름 변경
RENAME EMP_DDL TO EMP_RENAME;

--테이블 삭제
DROP TABLE EMP_RENAME;
--DROP은 롤백 없음, 취소불가

--MEMBER 테이블 작성
CREATE TABLE MEMBERTBL(
	ID CHAR(8),
	NAME VARCHAR2(10),
	ADDR VARCHAR2(50),
	NATION CHAR(4),
	EMAIL VARCHAR2(50),
	AGE NUMBER(7,2)
)

ALTER TABLE MEMBERTBL ADD BIGO VARCHAR2(20);

ALTER TABLE MEMBERTBL MODIFY BIGO VARCHAR2(30);

ALTER TABLE MEMBERTBL RENAME COLUMN BIGO TO REMARK;

ALTER TABLE MEMBERTBL DROP COLUMN REMARK;


ALTER TABLE MEMBERTBL MODIFY ID NCHAR(8);
ALTER TABLE MEMBERTBL MODIFY NAME NVARCHAR2(10);
ALTER TABLE MEMBERTBL MODIFY NATION NCHAR(4);

--데이터 삽입
INSERT INTO MEMBERTBL VALUES ('hong1234','홍길동','서울시 구로구 개봉동','대한민국','hong123@naver.com',25);
INSERT INTO MEMBERTBL VALUES ('hong1235','이승기','서울시 강서구 화곡동','대한민국','lee89@naver.com',26);
INSERT INTO MEMBERTBL VALUES ('hong1236','강호동','서울시 마포구 상수동','대한민국','kang56@naver.com',42);
INSERT INTO MEMBERTBL VALUES ('hong1237','이수근','경기도 부천시','대한민국','leesu@naver.com',42);
INSERT INTO MEMBERTBL VALUES ('hong1238','서장훈','서울시 강남구 대치동','대한민국','seo568@google.com',36);
INSERT INTO MEMBERTBL VALUES ('hong1239','김영철','서울시 도봉구 도봉동','대한민국','young@naver.com',41);
INSERT INTO MEMBERTBL VALUES ('hong1210','김장훈','서울시 노원구 노원1동','대한민국','kim@naver.com',48);
INSERT INTO MEMBERTBL VALUES ('hong1211','임창정','서울시 양천구 신월동','대한민국','limchang@naver.com',45);
INSERT INTO MEMBERTBL VALUES ('hong1212','김종국','서울시 강남구 도곡동','대한민국','kimjong@naver.com',44);
INSERT INTO MEMBERTBL VALUES ('hong1213','김범수','경기도 일산동구 일산동','대한민국','kim77@naver.com',36);
INSERT INTO MEMBERTBL VALUES ('hong1214','김경호','인천시 서구 가좌동','대한민국','ho789@naver.com',26);
INSERT INTO MEMBERTBL VALUES ('hong1215','민경훈','경기도 수원시 수원1동','대한민국','min@naver.com',35);
INSERT INTO MEMBERTBL VALUES ('hong1216','바이브','경기도 용인시 기흥구','대한민국','vibe@naver.com',33);

SELECT * FROM MEMBERTBL;

--2. 오라클 객체
--인덱스, 뷰, *시퀀스, 동의어

--1) 인덱스 : 빠른 검색
	-- 자동 생성 : 기본키를 설정시 인덱스 자동 설정
	-- 직접 인덱스 생성 : create
--CREATE INDEX 인덱스명 ON 테이블명(열이름 ASC OR DESC, 열이름2 ASC OR DESC....) (디폴트 어센딩)

--EMP 테이블의 SAL 칼럼을 인덱스로 지정
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);
DROP INDEX IDX_EMP_SAL;	

--2) 뷰 : 가상테이블
	--편리성 : 복잡한 SELECT 문의 복잡도를 완화하기 위해 
	--		 자주 활용하는 SELECT 문을 뷰로 저장해 놓은 후 다른 SQL 구문에서 활용(==CONSOLE)
	--보안성 : 노출되면 안되는 컬럼을 제외하여 접근 허용
	--권한이 불충분합니다, 뷰를 생성할 수 있는 권한 먼저 부여받기(ADMIN에게서)
--CREATE [OR REPLACE] VIEW 뷰이름(열이름1, 열이름2...) AS (SELEC 구문); //REPLACE는 필수 아님

--EMP 테이블의 20부서에 해당하는 사원들의 뷰 생성
CREATE VIEW VW_EMP_20 AS (SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 20);
DROP VIEW VW_EMP_20;
CREATE VIEW VW_EMP_20 AS (SELECT * FROM EMP WHERE DEPTNO = 20);

--뷰에 데이터 삽입 시 원본 테이블에 삽입이 일어남
INSERT INTO VW_EMP_20 VALUES(6666,'홍길동','MANAGER',7899,'2012-08-01',1200,0,20);
SELECT * FROM EMP e ;
--VIEW는 원본에 연결되어 있음

--SELECT만 가능하도록 제한을 둔 VIEW
CREATE VIEW VW_EMP_30 AS (SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 30) WITH READ ONLY;

--ROWNUM : 오라클에서 제공한 특수 컬럼(조회된 순서대로 일련번호 부여)
--ORDER BY 기준이 PK(기본키)가 아니면 번호 순차되지 않음
SELECT ROWNUM, E.*
FROM EMP e
ORDER BY SAL DESC;

SELECT ROWNUM, E.*
FROM EMP e;

--정렬이 기준이 PK가 아니라면 인라인 뷰에서 정렬 후
--ROWNUM 번호를 부여 해야 함
SELECT ROWNUM, E.*
FROM (SELECT* FROM EMP ORDER BY SAL DESC) E;

--급여 높은 순으로 TOP-N 추출, ROWNUM 제한
SELECT ROWNUM, E.*
FROM (SELECT* FROM EMP ORDER BY SAL DESC) E
WHERE ROWNUM <= 3;
 
--3) 시퀀스 : 규칙에 따라 순번을 생성 EX)게시판 글번호
--CREATE SEQUENCE 시퀀스명;
CREATE SEQUENCE DEPT_SEQ;
--CREATE SEQUENCE SCOTT.DEPT_SEQ 
--INCREMENT BY 1 //기본값은 1 - 증가를 얼마씩 할 것인가?
--MINVALUE 1 //시퀀스에서 생성할 최소값 - 1부터 시작
--MAXVALUE 9999999999999999999999999999 // 시퀀스에서 생성할 최대값
--NOCYCLE //최대값에 도달후 시작값으로 돌아갈지 여부
--CACHE 20 //시퀀스에서 생성할 번호를 메모리에 미리 할당해 놓은 수
--NOORDER; 

CREATE TABLE DEPT_SEQUENCE AS SELECT*FROM DEPT WHERE 1<>1;

SELECT *FROM DEPT_SEQUENCE;
INSERT INTO DEPT_SEQUENCE(DEPTNO,DNAME,LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'DATABASE','SEOUL');

INSERT INTO DEPT_SEQUENCE(DEPTNO,DNAME,LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'NETWORK','BUSAN');

-- 가장 마지막으로 생성된 시퀀스 확인
SELECT DEPT_SEQ.CURRVAL
FROM DUAL;

DROP SEQUENCE DEPT_SEQ;

CREATE SEQUENCE DEPT_SEQ 
INCREMENT BY 10
START WITH 10
MINVALUE 0
MAXVALUE 90
NOCYCLE 
CACHE 2; 

DELETE FROM DEPT_SEQUENCE;

SELECT *FROM DEPT_SEQUENCE ORDER BY DEPTNO;
INSERT INTO DEPT_SEQUENCE(DEPTNO,DNAME,LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'DATABASE','SEOUL');
--시퀀스 MAXVALUE 를 넘어가는 실행을 하는 경우
--시퀀스 DEPT_SEQ.NEXTVAL exceeds MAXVALUE 위반

--시퀀스 수정
ALTER SEQUENCE DEPT_SEQ
INCREMENT BY 3
MAXVALUE 99
CYCLE;

INSERT INTO DEPT_SEQUENCE(DEPTNO,DNAME,LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'DATABASE','SEOUL');

--3) 동의어 : 테이블, 뷰, 시퀀스 와 같은 객체에 대신 사용할 수 있는 이름 부여
--CREATE SYNONYM 동의어이름 FROM 객체(EX 테이블명)

--EMP 테이블 동의어 지정
CREATE SYNONYM E FOR EMP;

SELECT *FROM E;

DROP SYNONYM E;

--3.제약조건 : 특정 열에 지정
--1) NOT NULL : 지정한 열에 NULL을 허용하지 않음 //EX) ID, PW, 필수 입력칸
--2) UNIQUE : 지정한 열이 유일한 값을 가져야 함
--3) PRIMARY KEY : 지정한 열이 유일한 값이면서 NULL 허용하지 않음( 테이블당 하나만 지정 가능)
--4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력
--5) CHECK : 설정한 조건식을 만족하는 데이터만 입력 가능

--1)NOT NULL
--EX) ID, PW, 필수 입력칸

CREATE TABLE TABLE_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

--NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO TABLE_NOTNULL VALUES ('TEST_ID_01', 'TEST_PWD_01',NULL);
SELECT *FROM TABLE_NOTNULL;

UPDATE TABLE_NOTNULL 
SET LOGIN_PWD =NULL
WHERE LOGIN_ID ='TEST_ID_01';

--테이블 정의하면서 제약조건에 이름 부여(안붙이면 오라클이 임의의 이름 붙임)
CREATE TABLE TABLE_NOTNULL2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LGNPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);

UPDATE TABLE_NOTNULL 
SET TEL = '010-5678-9123'
WHERE LOGIN_ID = 'TEST_ID_01';

--기존 테이블에 제약조건 추가(TABLE_NOTNULL TELL 컬럼에 NOT NULL 제약조건 추가)
--데이터 값에 
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL); 

ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL); 

--생성한 제약조건 이름 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN_TEL_NN TO TBLNN2_TEL_NN; 

--제약조건 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN_TEL_NN; 

--2) UNIQUE : 데이터 중복을 허용하지 않음
--ID, 이메일, 전화번호 등

CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_UNIQUE VALUES ('TEST_ID_01', 'TEST_PWD_01', '010-1234-5678');
SELECT * FROM TABLE_UNIQUE;

--무결성 제약 조건(SCOTT.SYS_C008362)에 위배됩니다
--무결성 : 데이터 정확성과 일관성

--UNIQUE는 중복여부만 확인할 뿐이지 NULL 값을 확인하지는 않음
INSERT INTO TABLE_UNIQUE VALUES (NULL, 'TEST_PWD_01', '010-1234-5678');

CREATE TABLE TABLE_UNIQUE2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLUNQ2_LGN_UNQ UNIQUE,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLUNQ2_LGNPW_NN NOT NULL,
	TEL VARCHAR2(20)
);

UPDATE TABLE_UNIQUE 
SET TEL = '010-5678-9123'
WHERE LOGIN_ID = 'TEST_ID_01';

ALTER TABLE TABLE_UNIQUE MODIFY(TEL UNIQUE);

--제약조건 이름(TBLUNQ_TEL_UNQ) 부여
ALTER TABLE TABLE_UNIQUE2 MODIFY(TEL CONSTRAINT TBLUNQ_TEL_UNQ UNIQUE);

--제약조건 이름 변경 TBLUNQ_TEL_UNQ -> TBLUNQ2_TEL_UNQ
ALTER TABLE TABLE_UNIQUE2 RENAME CONSTRAINT TBLUNQ_TEL_UNQ TO TBLUNQ2_TEL_UNQ; 

--제약조건 삭제
ALTER TABLE TABLE_UNIQUE2 DROP CONSTRAINT TBLUNQ2_TEL_UNQ;

--3) PK (PRIMARY KEY-기본키) : NOT NULL + UNIQUE
--기본키 : 주민등록번호, 사원번호, 아이디
--테이블에서 하나의 컬럼에만 지정 가능, 기준

CREATE TABLE TABLE_PK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_PK VALUES ('TEST_ID_01', 'TEST_PW_01', '010-1234-5678');

--제약 조건을 테이블 닫는 괄호 앞쪽에 선언하는 방법
CREATE TABLE TABLE_PK2(
	LOGIN_ID VARCHAR2(20),
	LOGIN_PWD VARCHAR2(20),
	TEL VARCHAR2(20),
	PRIMARY KEY(LOGIN_ID),	
	CONSTRAINT TBL_UNQ UNIQUE(LOGIN_PWD)
);

--4)FOREIGN KEY(FK - 외래 키)
--존재하는 값에 연결해서 새로운 값을 추가
--EX) USER와 장바구니
--FK 있으면 JOIN 수월

--무결성 제약조건(SCOTT.FK_DEPTNO)이 위배되었습니다- 부모 키가 없습니다
--DEPT 테이블의 DEPTNO의 값을 기반으로 EMP 테이블의 DEPTNO 값 삽입 가능
INSERT INTO EMP 
VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);

--외래키 제약조건 테이블 생성
--부모 테이블 생성
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK(
	EMPNO NUMBER(4,0) PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO DEPT_FK VALUES(10,'NETWORK','BUSAN');
INSERT INTO EMP_FK VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);

--제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM DEPT_FK WHERE DEPTNO =50;

DELETE FROM EMP_FK WHERE EMPNO =9999;

--외래키 제약조건이 걸린 테이블 규칙
--1)삽입 시 부모부터 데이터 삽입
--2)삭제 시 자식 데이터부터 삭제
--ON DELETE CASCADE : 부모 삭제시 자식 데이터 같이 삭제(ALTER로 추가 불가, 생성시에만 정의)
--ON DELETE SET NULL : 부모 삭제시 자식 데이터의 값을 NULL로 변경(ALTER로 추가 불가, 생성시에만 정의)

CREATE TABLE EMP_FK2(
	EMPNO NUMBER(4,0) PRIMARY KEY,	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK2_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);

INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO EMP_FK2 VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);
DELETE FROM DEPT_FK WHERE DEPTNO =50;
SELECT * FROM EMP_FK2;

CREATE TABLE EMP_FK3(
	EMPNO NUMBER(4,0) PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4,0),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2,0) CONSTRAINT EMPFK3_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

INSERT INTO DEPT_FK VALUES(50,'DATABASE','SEOUL');
INSERT INTO EMP_FK3 VALUES(9999,'테스트','CLERK','7788','2017-04-30',1200,NULL,50);
DELETE FROM DEPT_FK WHERE DEPTNO =50;
SELECT * FROM EMP_FK3;

--5) CHECK : 값의 범위 또는 패턴 정의

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD)>=3), --길이가 3 이상이어야 함
	TEL VARCHAR2(20)
);

--체크 제약조건(SCOTT.TBLCK_LOGINPW_CK)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('TEST_ID_01','12',NULL);

--6) DEFAULT : 기본값 정의

CREATE TABLE TABLE_DEFAULT(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('TEST_ID_01',NULL,NULL);
INSERT INTO TABLE_DEFAULT(LOGIN_ID,TEL) VALUES('TEST_ID_02',NULL);
SELECT * FROM TABLE_DEFAULT;

--BOARD 테이블 정의
--BNO(숫자), NAME, PASSWORD, TITLE, CONTENT, READCNT(숫자-DEFAULT 0), REGDATE(날짜-DEFAULT 현재날짜)
--기본키 : BNO
--NOT NULL : NAME, PASSWORD, TITLE, CONTENT 

CREATE TABLE BOARD(
	BNO NUMBER(3) PRIMARY KEY, 
	NAME VARCHAR2(20) NOT NULL, 
	PASSWORD VARCHAR2(20) NOT NULL,
	TITLE VARCHAR2(20) NOT NULL,
	CONTENT VARCHAR2(20) NOT NULL,
	READCNT NUMBER(3) DEFAULT '0', 
	REGDATE DATE DEFAULT SYSDATE	
);

--시퀀스 생성 : 1씩 증가 BOARD_SEQ
CREATE SEQUENCE BOARD_SEQ
INCREMENT BY 1
MINVALUE 0
MAXVALUE 90
NOCYCLE 
CACHE 2;

INSERT INTO BOARD(BNO, NAME, PASSWORD, TITLE, CONTENT)
VALUES(BOARD_SEQ.NEXTVAL,'HONG','1111','게시판','게시판 작성');
SELECT * FROM BOARD;


--SCOTT는 오라클에서 만들어 놓은 연습용 계정





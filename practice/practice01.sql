-- 문제 1
SELECT FIRST_NAME || ' ' || LAST_NAME AS 이름, EMAIL AS 이메일, PHONE_NUMBER AS 전화번호
FROM EMPLOYEES
ORDER BY HIRE_DATE ASC;

-- 문제 2
SELECT JOB_TITLE AS 업무이름, MAX_SALARY AS 최고임금
FROM JOBS
ORDER BY MAX_SALARY DESC;

-- 문제 3 
SELECT COUNT(*)
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 문제 4 : 2번과 같음
SELECT JOB_TITLE AS 업무이름
FROM JOBS
ORDER BY MAX_SALARY DESC;

-- 문제 5
SELECT COUNT(*)
FROM DEPARTMENTS;

-- 문제 6 
SELECT DEPARTMENT_NAME AS 부서이름 
FROM DEPARTMENTS
ORDER BY LENGTH(DEPARTMENT_NAME) DESC;

-- 문제 7
SELECT COUNT(*)
FROM DEPARTMENTS
WHERE MANAGER_ID IS NULL;

-- 문제 8 
SELECT UPPER(COUNTRY_NAME)
FROM COUNTRIES
ORDER BY COUNTRY_NAME ASC;

-- 문제 9 
SELECT COUNT(REGION_NAME) AS 관리하는지역수
FROM REGIONS;

SELECT REGION_NAME AS 지역이름
FROM REGIONS
ORDER BY LENGTH(REGION_NAME) ASC;

-- 문제 10 
SELECT DISTINCT LOWER(CITY) AS 도시이름
FROM LOCATIONS
ORDER BY 도시이름 ASC;




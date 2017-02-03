--문제1

SELECT MAX(max_salary) as 최고임금, MIN(min_salary) as 최저임금,
		MAX(max_salary)-MIN(min_salary) as "최고임금-최저임금"
FROM jobs;


--문제2

SELECT TO_CHAR(MAX(start_date),	'YYYY"년 "MM"월 " DD"일"') AS 마지막신입사원입사일
FROM job_history;


--문제3 : 부서id별로 평균임금, 최고임금, 최저임금을 출력 내림차순
SELECT department_id AS 부서, 
		AVG(salary) AS 평균임금, MAX(salary) AS 최고임금, MIN(salary) AS 최저임금
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) DESC, MAX(salary) DESC, MIN(salary) DESC;

-- 문제4 
SELECT job_id AS 업무,
		AVG(salary) AS 평균임금, MAX(salary) AS 최고임금, MIN(salary) AS 최저임금
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC, MAX(salary) DESC, MIN(salary) DESC;

-- 문제5 

SELECT TO_CHAR(MIN(start_date), 'YYYY"년 "MM"월 "DD"년"') AS 가장오래근속입사일
FROM job_history;

-- 문제6 

SELECT department_id, AVG(salary) AS 평균임금, MIN(salary) AS 최저임금, 
		AVG(salary)-MIN(salary) AS "평균임금-최저임금"
FROM employees
GROUP BY department_id
HAVING AVG(salary)-MIN(salary) < 2000
ORDER BY 평균임금-최저임금 DESC;

-- 문제7-1)업무별로 최고임금과 최저임금의 차이를 출력 -> 개인적으로 오름차순좋아함
SELECT job_id, MAX(salary)-MIN(salary) AS "최고임금-최저임금"
FROM employees
GROUP BY job_id
ORDER BY job_id asc;


-- 문제7-2) 문제7-1)에서 가장 큰 차이와 그 업무는 ? 
-- 인라인 뷰를 이용
SELECT *
FROM 
	(SELECT job_id, MAX(salary)-MIN(salary) AS "최고임금-최저임금"
	FROM employees
	GROUP BY job_id
	ORDER BY MAX(salary)-MIN(salary) DESC)
WHERE ROWNUM=1;



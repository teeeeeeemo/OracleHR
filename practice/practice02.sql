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

-- 문제7 업무별로 최고임금, 최저임금, 최고임금과 최저임금의 가장 큰 차이 projection
SELECT * 
FROM 
	(SELECT job_id,  MAX(salary) 최고임금, MIN(salary) 최저임금,
			MAX(salary)-MIN(salary) "최고임금-최저임금"
	FROM employees
	GROUP BY job_id
	ORDER BY "최고임금-최저임금" DESC)
WHERE ROWNUM=1;

-- 문제7 업무명, 최고임금, 최저임금, 최고임금-최저임금을 join해서 
SELECT * 
FROM 
	(SELECT j.job_title 업무명, MAX(e.salary) 최고임금, MIN(e.salary) 최저임금,
			MAX(e.salary)-MIN(e.salary) "최고임금-최저임금"
	FROM employees e, jobs j
	WHERE e.job_id = j.job_id
	GROUP BY j.job_title
	ORDER BY "최고임금-최저임금" DESC)
WHERE ROWNUM=1;

-- *****sub query 문제7 다시해보기 
-- 문제7 : 업무별로 최고임금과 최저임금의 차이와 가장 큰 차이 ? 그 업무 ? 
-- >> 업무명 | 최고임금-최저임금

-- step 1 : job_id, maxSalary, minSalary, diffSalary 구하기 
SELECT job_id,  MAX(salary) max, MIN(salary) min,
			MAX(salary)-MIN(salary) diff_sal
	FROM employees
	GROUP BY job_id;

-- step 2 : diffSalary중 MAX value 구하기
SELECT MAX(diff_sal)
FROM (SELECT job_id,  MAX(salary) max, MIN(salary) min,
			MAX(salary)-MIN(salary) diff_sal
	FROM employees
	GROUP BY job_id);

-- step3 : 완성
SELECT j.job_title 업무명, a.max_sal 최고임금, a.min_sal 최저임금, a.diff_sal "최저임금-최저임금"
FROM jobs j, (SELECT job_id, MAX(salary) max_sal, MIN(salary) min_sal, MAX(salary)-MIN(salary) diff_sal
	FROM employees 
	GROUP BY job_id) a
WHERE j.job_id = a.job_id
	AND a.diff_sal = ( SELECT MAX(diff_sal)
			FROM (SELECT job_id,  
			MAX(salary)-MIN(salary) diff_sal
			FROM employees
	GROUP BY job_id)
	);


-- 집계함수 170203 쉅시간

SELECT AVG(salary) 평균연봉
FROM employees;

SELECT job_id
FROM employees;

SELECT AVG(salary) 
FROM employees
WHERE job_id = 'AC_MGR';

-- 집계함수를 사용하면 다른 칼럼들은 SELECT 절에 올 수 없다 -> GROUP BY clause 사용하기 ! 

SELECT job_id, AVG(salary) 평균연봉
FROM employees
WHERE job_id = 'AC_MGR'
GROUP BY job_id;

SELECT job_id, AVG(salary) 평균연봉
FROM employees
GROUP BY job_id;

SELECT job_id, AVG(salary) 평균연봉 
FROM employees
GROUP BY job_id
ORDER BY job_id ASC;

SELECT job_id, AVG(salary) 평균연봉 
FROM employees
GROUP BY job_id
ORDER BY 평균연봉 DESC;

SELECT job_id, AVG(salary) 평균연봉 
FROM employees
WHERE job_id != 'AC_ACCOUNT'
GROUP BY job_id
ORDER BY AVG(salary) DESC;

-- 최종 결과 임시 테이블에 대한 조건은 HAVING clause 사용 ! 
SELECT job_id, AVG(salary) 평균연봉
FROM employees
WHERE job_id != 'AD_VP'
GROUP BY job_id
HAVING AVG(salary) > 10000
ORDER BY 평균연봉 DESC;





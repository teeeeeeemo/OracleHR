-- practice04 SUB QUERY

-- ***** 문제 1 : 평균 연봉보다 적은 월급을 받는 직원은 몇 명 ? ? ?

-- step 1 : 평균 연봉 구하기 -> 6,461.83

SELECT AVG (salary) avg_salary FROM employees;

-- step 2 : COUNT하기 전 평균미만의 급여를 받는지 확인하기 위 출력해 보기.

SELECT e.salary
  FROM employees e, (SELECT AVG (salary) avg_salary FROM employees) a
 WHERE e.salary < a.avg_salary;

-- step 3 : 56명 !

SELECT COUNT (*) "직원 수"
  FROM employees e, (SELECT AVG (salary) avg_salary FROM employees) a
 WHERE e.salary < a.avg_salary;


-- ***** 문제 2 : 각 부서별로 최고의 급여를 받는 사원의 사번(employee_id), 성(last_name)과
--				연봉(salary)을 조회하세요 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 함.
--			>>부서이름, 사번, 성, 연봉 (ORDER BY 연봉 DESC)
-- step 1 : 부서아이디별로 그루핑 후 최고급여 구해보기 -> 부서가 없는아이 1명 포함해서 12명 나옴.

  SELECT department_id, MAX (salary) max_sal
    FROM employees
GROUP BY department_id;

-- step 2 : Correlated Sub Query - Outer Query 이용하여 Inner Query 수행

  SELECT department_id,
         employee_id,
         last_name,
         salary
    FROM employees out_e
   WHERE out_e.salary = (SELECT MAX (in_e.salary)
                           FROM employees in_e
                          WHERE in_e.department_id = out_e.department_id)
ORDER BY salary DESC;

-- step 3 : step2에서처럼 굳이 부여한 alias 제거, 부서이름별로 출력하고싶다. 완성

  SELECT d.department_name,
         a.employee_id,
         a.last_name,
         a.salary
    FROM departments d,
         (SELECT department_id,
                 employee_id,
                 last_name,
                 salary
            FROM employees e
           WHERE e.salary = (SELECT MAX (salary)
                               FROM employees
                              WHERE department_id = e.department_id)) a
   WHERE d.department_id = a.department_id
ORDER BY salary DESC;

--step 4 : 조인걸어서 해보고싶어. step 1 에서 구한 query 이용하기

  SELECT e.department_id,
         employee_id,
         last_name,
         salary
    FROM employees e,
         (  SELECT department_id, MAX (salary) max_sal
              FROM employees
          GROUP BY department_id) a
   WHERE e.department_id = a.department_id AND e.salary = a.max_sal
ORDER BY salary DESC;

-- 바로 위 쿼리를 부서이름으로 보기. 문제2 끝 .

SELECT department_name 부서명,
       employee_id 사번,
       last_name 성,
       salary 연봉
  FROM departments d,
       (SELECT e.department_id,
               employee_id,
               last_name,
               salary
          FROM employees e,
               (  SELECT department_id, MAX (salary) max_sal
                    FROM employees
                GROUP BY department_id) a
         WHERE e.department_id = a.department_id AND e.salary = a.max_sal) a
 WHERE d.department_id = a.department_id;


-- ***** 문제 3 : 각 업무(job) 별로 연봉(salary)의 총합을 구하고자.
--				연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하기.
--       >> 업무명, 연봉 총합 (ORDER BY sum(salary) desc )

-- step 1 : 업무 아이디 별로 grouping 해서 sum_salary 구하기

  SELECT job_id, SUM (salary) sum_salary
    FROM employees
GROUP BY job_id;

-- step 2 :

  SELECT job_title, sum_salary
    FROM jobs j,
         (  SELECT job_id, SUM (salary) sum_salary
              FROM employees
          GROUP BY job_id) a
   WHERE j.job_id = a.job_id
ORDER BY sum_salary DESC;

-- ***** 문제 4 : 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번(employee_id),
--				성(last_name)과 연봉(salary)을 조회하세요.
-- 		>> 사번, 성, 연봉 ... ORDER BY 는 그래 바로 성 ASC !

-- step 1 : 부서별 평균 급여 구하기 -> 역시나 부서없는 아이 포함하여 12 columns

  SELECT department_id, AVG (salary) avg_sal
    FROM employees
GROUP BY department_id
ORDER BY department_id ASC;

-- step 2 : suq query 로 JOIN, 부서id같고 salary 조건 WHERE clause에 주기. 완성 ! 
SELECT e.employee_id 사번, e.last_name 성, e.salary 연봉, a.avg_sal 부서평균연봉
FROM employees e,
  		(SELECT department_id, AVG(salary) avg_sal
		FROM employees
		GROUP BY department_id ) a
WHERE e.department_id = a.department_id
	AND e.salary > a.avg_sal
ORDER BY last_name ASC;

-- 이 아이는 확인용, step1의 부서별 평균과 함께 확인 용도
SELECT employee_id, department_id, salary FROM employees;


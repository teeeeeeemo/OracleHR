-- practice05 혼합 (마지막) 

-- ***** 문제 1 : 가장 늦게 입사한 직원(first_name last_name)의 이름과 연봉(salary), 근무하는
--				부서 이름(department_name)은? 
--				>> first_name || ' ' || lastname | salary | department_name (ORDER BY 이름 ASC 로하장) 

-- 2008년 4월 21일 2명 
SELECT first_name, salary, hire_date from employees; 

-- step 1 : 가장 늦게 입사한 직원의 입사일 구하기
SELECT TO_CHAR(MAX(hire_date), 'YYYY"년 "MM"월 "DD"일"') last_hire_date
FROM employees;

-- step 2 : 풀네임, 연봉, 부서이름, 입사일(확인용) - 완성 ! 
SELECT first_name||' '||last_name 이름, salary 연봉, d.department_name 부서명, 
		TO_CHAR(hire_date, 'YYYY"년 "MM"월 "DD"일"') 입사일
FROM employees e, departments d,
	(SELECT MAX(hire_date) last_hire_date
	 FROM employees) hd
WHERE e.hire_date = hd.last_hire_date
	AND e.department_id = d.department_id;
	 
-- ***** 문제 2 : 자신의 부서 평균 급여보다 연봉이 많은 사원의 사번(employee_id), 성(last_name)과 연봉(salary)을 조회하세요
-- practice04 4번문제와 동일 그래도 다시한번 ! 
-- 		>> 사번 | 성 | 연봉 (ORDER BY 연봉 DESC) !!! 

-- step 1 : 부서별 평균 급여 구하기
SELECT department_id, AVG(salary) 
FROM employees
GROUP BY department_id;

-- step 2 : 완성 .... 
-- 오라클 예약어 유의하기 ... ㅠ.ㅠ 

SELECT employee_id 사번, last_name 성, salary 연봉
FROM employees e,
	( SELECT department_id, AVG(salary) avg_sal
		FROM employees
		GROUP BY department_id) a
WHERE e.department_id = a.department_id
	AND e.salary > a.avg_sal
ORDER BY salary DESC;

-- ***** 문제 3 : 평균연봉(salary)이 가장 높은 부서 사원들의 사번(employee_id), 이름(firt_name), 성(last_name)과  
--				업무(job), 연봉(salary)을 조회.
--		>> 사번 | 풀네임 | 업무(job_title) | 연봉

-- step 1 : 부서별 평균연봉 구하기 - 19,333.33 으로 id90 부서가 최고임

SELECT department_id, AVG(salary) avg_sal
FROM employees 
GROUP BY department_id;

-- step 2 : 평균연봉이 가장 높은 부서 구하기 -> step1 에서 구한 테이블 a에서 최대값 구하기 
SELECT department_id, avg_sal 
FROM ( SELECT department_id, AVG(salary) avg_sal
		FROM employees 
		GROUP BY department_id) a
WHERE a.avg_sal = ( SELECT MAX(avg_sal) 
					FROM ( SELECT department_id, AVG(salary) avg_sal
							FROM employees 
							GROUP BY department_id ));

-- step 3 : id 90 부서의 사원 3명의 사번, 이름, 연봉 구하기
SELECT employee_id, first_name, salary, e.department_id, job_id
FROM employees e, 
	( SELECT department_id, avg_sal 
	FROM ( SELECT department_id, AVG(salary) avg_sal
			FROM employees 
			GROUP BY department_id) a
	WHERE a.avg_sal = ( SELECT MAX(avg_sal) 
						FROM ( SELECT department_id, AVG(salary) avg_sal
								FROM employees 
								GROUP BY department_id ))) a 
WHERE e.department_id = a.department_id;

-- step 4 : step3에서는 확인차 first_name만 SELECT 했기때문에 풀네임 구하려
--			요기서 sub query시 last_name SELECT해줘야... 암튼 완성 ! ! 
SELECT a.employee_id 사번, a.first_name||' '||a.last_name 이름, j.job_title 업무, a.salary 연봉
FROM jobs j,
	( SELECT employee_id, first_name, last_name, salary, e.department_id, job_id
		FROM employees e, 
			( SELECT department_id, avg_sal 
			FROM ( SELECT department_id, AVG(salary) avg_sal
					FROM employees 
					GROUP BY department_id) a
			WHERE a.avg_sal = ( SELECT MAX(avg_sal) 
								FROM ( SELECT department_id, AVG(salary) avg_sal
										FROM employees 
										GROUP BY department_id ))) a 
		WHERE e.department_id = a.department_id ) a
WHERE j.job_id = a.job_id;

-- ***** 문제 4 : 평균 연봉이 가장 높은 부서 ? (문제3이네) 
--			>> 부서명 

-- step 1 : 부서별 평균연봉 구하기 
SELECT department_id, AVG(salary) avg_sal
FROM employees
GROUP BY department_id;

-- step 2 : 부서별 평균연봉중 MAX 값 구하기
SELECT department_id, avg_sal
FROM ( SELECT department_id, AVG(salary) avg_sal
		FROM employees
		GROUP BY department_id ) a
WHERE a.avg_sal = ( SELECT MAX(avg_sal)
					FROM ( SELECT department_id, AVG(salary) avg_sal
							FROM employees
							GROUP BY department_id ) );
-- step 3 : 부서명만 보여주고 싶다. 완성 !!!
SELECT department_name 부서명
FROM departments d, 
	( SELECT department_id, avg_sal
		FROM ( SELECT department_id, AVG(salary) avg_sal
				FROM employees
				GROUP BY department_id ) a
		WHERE a.avg_sal = ( SELECT MAX(avg_sal)
							FROM ( SELECT department_id, AVG(salary) avg_sal
									FROM employees
									GROUP BY department_id ))) a
WHERE d.department_id = a.department_id;


-- ***** 문제 5 : 평균연봉이 가장 높은 지역 ? ( 문제 4에서 JOIN을 몇차례 더 걸어주면 될듯 )
--		>> 지역명 

-- step 1 : MAX(평균연봉) 부서구하기 - 한번에 1쿼리로 날려보자 
SELECT department_id, avg_sal
FROM (SELECT department_id, AVG(salary) avg_sal
		FROM employees
		GROUP BY department_id ) a
WHERE a.avg_sal = ( SELECT MAX(avg_sal) 
					FROM ( SELECT department_id, AVG(salary) avg_sal
							FROM employees
							GROUP BY department_id ));

-- step 2 : JOIN 걸자 모두 ! 
SELECT region_name 지역명
FROM regions r, countries c, locations l, departments d,
	( SELECT department_id, avg_sal
		FROM (SELECT department_id, AVG(salary) avg_sal
				FROM employees
				GROUP BY department_id ) a
		WHERE a.avg_sal = ( SELECT MAX(avg_sal) 
							FROM ( SELECT department_id, AVG(salary) avg_sal
									FROM employees
									GROUP BY department_id ))) a
WHERE a.department_id = d.department_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id;
	

-- ***** 문제 6 : 평균 연봉이 가장 높은 업무 ? 
--			>> 업무명 

-- step 1 : 업무별 평균연봉 MAX값 구하기
SELECT job_id, a.avg_sal 
FROM ( SELECT job_id, AVG(salary) avg_sal 
		FROM employees
		GROUP BY job_id ) a
WHERE a.avg_sal =  ( SELECT MAX(avg_sal) 
					 FROM ( SELECT job_id, AVG(salary) avg_sal 
					 		FROM employees
							GROUP BY job_id ) );

-- step 2 : jobs랑 조인 걸어서 업무명. 완성						
SELECT job_title
FROM jobs j, 
	( SELECT job_id, a.avg_sal 
		FROM ( SELECT job_id, AVG(salary) avg_sal 
				FROM employees
				GROUP BY job_id ) a
		WHERE a.avg_sal =  ( SELECT MAX(avg_sal) 
							 FROM ( SELECT job_id, AVG(salary) avg_sal 
									FROM employees
									GROUP BY job_id ) ) ) a
WHERE j.job_id = a.job_id;


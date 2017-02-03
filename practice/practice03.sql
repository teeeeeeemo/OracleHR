--practice03 : 테이블간 조인


--문제 1

SELECT  e_a.employee_id 사번, e_a.first_name AS 이름, d.department_name 부서명, e_b.first_name 매니저
FROM employees e_a, employees e_b, departments d
	WHERE e_a.manager_id = e_b.employee_id
		AND e_a.department_id = d.department_id
	ORDER BY 이름;
	
  
-- 문제 2 : 지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name) 출력, 
-- 		지역이름, 나라이름 순서대로 내림차순으로 정렬 ???
-- 질문 ㅁ ? 둘다 내림차순으로 정렬 ? ? ? ? ? 요 앞 practice에도 비슷한 궁금함있었음 같이해결하기

SELECT r.region_name, c.country_name
FROM regions r, countries c
WHERE r.region_id = c.region_id
ORDER BY r.region_name DESC, c.country_name DESC;


-- 문제 3 : 각 부서(department)에 대해서 부서번호(department_id), 이름(department_name), 
-- 			매니저 이름(first_name), 위치(locations)한 도시(city), 
--	나라(countries)의 이름(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 
-- 부서번호, 부서이름, 매니저이름, 위치한도시, 나라이름, 지역이름 <-- 요렇게 출력
-- 부서이름 오름차순으로 출력해보았다.

SELECT d.department_id 부서번호, d.department_name 부서이름, e.first_name 매니저, 
		l.city 위치한도시, c.country_name 나라이름, r.region_name 지역이름
FROM departments d, employees e, locations l, countries c, regions r
WHERE e.employee_id = d.manager_id
	AND d.location_id = l.location_id
	AND l.country_id = c.country_id
	AND c.region_id = r.region_id;
	

-- 문제4 : ‘Public Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 
-- 			이름을 출력. (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 
--			고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 : 2명 나와야
-- 		>> 사번, 이름

SELECT * FROM jobs;
SELECT * FROM job_history;

SELECT e.employee_id 사번, e.first_name || ' ' || e.last_name 이름 
FROM employees e, job_history jh, jobs j
WHERE e.employee_id = jh.employee_id
AND jh.job_id = j.job_id
AND j.job_title = 'Public Accountant';


-- 문제5 : 같은 성(last_name)을 가진 직원들의 사번(employee_id), 이름(firt_name), 
--			성(last_name)과 부서 이름을 조회하여 성(last_name)순서로 정렬하세요
-- 		>> 사번, 이름, 성, 부서이름 -> ORDER BY 성


-- step 1 : 같은 성 찾기
SELECT last_name, COUNT(*)
FROM employees 
GROUP BY last_name
HAVING COUNT(*) > 1;

-- setp 2 : 같은 성의 사번, FULL NAME, 성 출력
SELECT e.employee_id 사번, e.first_name || ' ' || e.last_name FULL이름, 
		e.last_name 성
FROM employees e, 
	(SELECT last_name, COUNT(*)
	FROM employees 
	GROUP BY last_name	
	HAVING COUNT(*) > 1) a
WHERE e.last_name= a.last_name;

-- step 3 : 같은 성의 사번, FULL NAME, 성, 부서 출력 -> Outter JOIN 필요
SELECT e.employee_id 사번, e.first_name || ' ' || e.last_name FULL이름, 
		e.last_name 성, d.department_name 부서이름
FROM employees e, departments d,
	(SELECT last_name, COUNT(*)
	FROM employees 
	GROUP BY last_name	
	HAVING COUNT(*) > 1) a
WHERE e.last_name= a.last_name
	AND e.department_id = d.department_id
ORDER BY e.last_name ASC;

-- step 4 : Outter JOIN, 완성 ! 
SELECT e.employee_id 사번, e.first_name || ' ' || e.last_name FULL이름, 
		e.last_name 성, NVL(d.department_name, '부서없음') 부서이름
FROM employees e 
	LEFT JOIN departments d
	ON e.department_id = d.department_id,
	(SELECT last_name, COUNT(*)
	FROM employees 
	GROUP BY last_name	
	HAVING COUNT(*) > 1) a
WHERE e.last_name= a.last_name
ORDER BY e.last_name ASC;

--문제 5를 모든 직원으로 변경해서 풀어보기 
SELECT e.employee_id 사번, e.first_name || ' ' || e.last_name FULL이름, 
		e.last_name 성, NVL(d.department_name, '부서없음') 부서이름
FROM employees e 
	LEFT JOIN departments d
	ON e.department_id = d.department_id
ORDER BY e.last_name ASC;

-- 문제 6 : 자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 
--			성(last_name)과 채용일(hire_date)을 조회
-- 		>> 사번, 성, 채용일 (37명)

SELECT emp.employee_id 사번, emp.last_name 이름, m.last_name 매니저,
		TO_CHAR(emp.hire_date, 'YYYY"년 "MM"월 " DD"일"') 채용일,
		TO_CHAR(m.hire_date, 'YYYY"년 "MM"월 " DD"일"') 매니저채용일
FROM employees emp, employees m
WHERE emp.manager_id = m.employee_id
AND emp.hire_date < m.hire_date;







  
  

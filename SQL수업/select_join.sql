-- JOIN 쉅 170203

-- Inner JOIN (Equi JOIN)
SELECT count(*) 
FROM employees e, departments d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id --JOIN 조건(n-1)개 
	AND d.department_name like 'P%'; -- ROW 

-- Inner JOIN (Equi JOIN, Self Join)
SELECT e_a.first_name 사원이름, e_b.first_name 매니저이름
FROM employees e_a, employees e_b
WHERE e_a.manager_id = e_b.manager_id;	


SELECT e_a.first_name 사원이름, e_b.first_name 매니저이름
FROM employees e_a, employees e_b
WHERE e_a.manager_id = e_b.manager_id;	


-- Outter JOIN 
SELECT * 
FROM employees e, departments d
WHERE e.department_id (+)= d.department_id;

SELECT count( *) 
FROM employees e, departments d
WHERE e.department_id (+)= d.department_id;

SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id (+)= d.department_id;

SELECT nvl(e.first_name, '소속직원 없음') 이름, d.department_name
FROM employees e, departments d
WHERE e.department_id (+)= d.department_id;

SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE d.department_id (+)= e.department_id;

SELECT e.first_name, nvl(d.department_name, '부서 없음')
FROM employees e, departments d
WHERE d.department_id (+)= e.department_id;	


	
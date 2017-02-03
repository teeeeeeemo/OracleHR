-- ANSI JOIN SQL문 (1999 syntax) 

-- Natural JOIN : Inner JOIN, TABLE Column 이름 같으면 자동으로 조인이 걸린다.
-- JOIN 대상 테이블에 같은 칼럼이 있는 경우, 여러개 있으면 의도치않게 다걸린다.

SELECT *
FROM employees e 
NATURAL JOIN departments d;

SELECT * 
FROM employees e
JOIN departments d
USING (department_id);


-- Inner JOIN 표준 SQL문 ( = Equi JOIN 의 표준 SQL문 )
SELECT * 
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

SELECT *
FROM employees e, departments d 
WHERE e.department_id = d.department_id;

-- Outter JOIN : 표준으로 쓰자 ! Mysql, Oracle 모두 적용 가능 
SELECT NVL(e.first_name, '소속직원 없음') 이름, d.department_name
FROM employees e
	RIGHT JOIN departments d
	ON e.department_id = d.department_id;
	
SELECT e.first_name, NVL(d.department_name, '부서 없음') 부서
FROM employees e
	LEFT JOIN departments d
	ON e.department_id = d.department_id;
	
SELECT NVL(e.first_name, '소속직원 없음'), NVL(d.department_name, '부서 없음') 부서
FROM employees e
	FULL JOIN departments d
	ON e.department_id = d.department_id;
	

	
	




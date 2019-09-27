CREATE TABLE "Employees" (
    "emp_no" INT NOT NULL,
    "birth_date" VARCHAR(30) NOT NULL,
    "first_name" VARCHAR(30) NOT NULL,
    "last_name" VARCHAR(30) NOT NULL,
    "gender" VARCHAR(10) NOT NULL,
    "hire_date" VARCHAR(30) NOT NULL,
    CONSTRAINT "Emp_pk" PRIMARY KEY (
        "emp_no")
);

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(4) NOT NULL,
    "dept_name" VARCHAR(30) NOT NULL,
    CONSTRAINT "Dept_pk" PRIMARY KEY (
        "dept_no")
);

CREATE TABLE "Dept_emp" (
    "emp_no" INT NOT NULL,
    "dept_no" VARCHAR(10) NOT NULL,
    "from_date" VARCHAR(30) NOT NULL,
    "to_date" VARCHAR(30) NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR(10) NOT NULL,
    "emp_no" INT NOT NULL,
    "from_date" VARCHAR(30) NOT NULL,
    "to_date" VARCHAR(30) NOT NULL
);

CREATE TABLE "Salaries" (
    "emp_no" INT NOT NULL,
    "salary" INT NOT NULL,
    "from_date" VARCHAR(30) NOT NULL,
    "to_date" VARCHAR(30) NOT NULL
);

CREATE TABLE "Titles" (
    "emp_no" INT NOT NULL,
    "title" VARCHAR(30) NOT NULL,
    "from_date" VARCHAR(30) NOT NULL,
    "to_date" VARCHAR(30) NOT NULL
);

ALTER TABLE "Dept_emp" 
	ADD CONSTRAINT Dept_no_en_fk FOREIGN KEY (emp_no) 
		REFERENCES "Employees" (emp_no);
	
ALTER TABLE "Dept_emp"
	ADD CONSTRAINT Dept_no_dn_fk FOREIGN KEY (dept_no) 
		REFERENCES "Departments" (dept_no);

ALTER TABLE "Dept_manager"
	ADD CONSTRAINT Dept_man_en_fk FOREIGN KEY (emp_no)
		REFERENCES "Employees" (emp_no);

ALTER TABLE "Dept_manager"
	ADD CONSTRAINT Dept_man_dn_fk FOREIGN KEY (dept_no)
		REFERENCES "Departments" (dept_no);

ALTER TABLE "Salaries"
	ADD CONSTRAINT Salaries_en_fk FOREIGN KEY (emp_no)
		REFERENCES "Employees" (emp_no);

ALTER TABLE "Titles"
	ADD CONSTRAINT Titles_en_fk FOREIGN KEY (emp_no)
		REFERENCES "Employees" (emp_no);
		
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM "Salaries" AS s
INNER JOIN "Employees" AS e ON
e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
SELECT * FROM "Employees" WHERE hire_date LIKE '1986%';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, start date and end employment dates.
SELECT e.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date, d.dept_name, d.dept_no
FROM "Dept_manager" AS dm
INNER JOIN "Employees" AS e ON
e.emp_no = dm.emp_no
JOIN "Departments" AS d ON
d.dept_no = dm.dept_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM "Dept_emp" AS de
INNER JOIN "Employees" AS e ON
e.emp_no = de.emp_no
JOIN "Departments" AS d ON
d.dept_no = de.dept_no

-- 5. List all the employees whose first names are Hercules and last names begin with 'B'.
SELECT * FROM "Employees" WHERE (first_name LIKE 'Hercules' and last_name LIKE 'B%' )

-- 6. List all the employees in the sales department including their employee number, last name, first name and department name.
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM "Dept_emp" AS de
INNER JOIN "Employees" AS e ON
e.emp_no = de.emp_no
JOIN "Departments" AS d ON
d.dept_no = de.dept_no
WHERE d.dept_name LIKE 'Sales%'

-- 7. List all employees in the sales and developments departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM "Dept_emp" AS de
INNER JOIN "Employees" AS e ON
e.emp_no = de.emp_no
JOIN "Departments" AS d ON
d.dept_no = de.dept_no
WHERE d.dept_name LIKE 'Sales%' OR d.dept_name LIKE 'Development%';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT (last_name) AS FREQUENCY
FROM "Employees"
GROUP BY last_name
ORDER BY
COUNT (last_name) DESC
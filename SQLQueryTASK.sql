CREATE TABLE EMPLOYEE (
    SSN INT PRIMARY KEY,
    FNAME VARCHAR(50),
    MINIT CHAR(1),
    LNAME VARCHAR(50),
    BDATE DATE,
    ADDRESS VARCHAR(100),
    SEX CHAR(1),
    SALARY DECIMAL(10, 2),
    SUPERSSN INT FOREIGN KEY REFERENCES EMPLOYEE(SSN),
    DNO INT
);

CREATE TABLE DEPARTMENT (
    DNUMBER INT PRIMARY KEY,
    DNAME VARCHAR(50),
    MGRSSN INT FOREIGN KEY REFERENCES EMPLOYEE(SSN),
    MGRSTARTDATE DATE,
);

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT FK_EMPLOYEE_DEPARTMENT
FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNUMBER);


CREATE TABLE DEPT_LOCATIONS (
    DNUMBER INT FOREIGN KEY REFERENCES DEPARTMENT(DNUMBER),
    DLOCATION VARCHAR(50),
    PRIMARY KEY (DNUMBER, DLOCATION)
);

CREATE TABLE PROJECT (
    PNUMBER INT PRIMARY KEY,
    PNAME VARCHAR(50),
    PLOCATION VARCHAR(50),
    DNUM INT FOREIGN KEY REFERENCES DEPARTMENT(DNUMBER)
);

CREATE TABLE WORKS_ON (
    ESSN INT FOREIGN KEY REFERENCES EMPLOYEE(SSN),
    PNO INT FOREIGN KEY REFERENCES PROJECT(PNUMBER),
    HOURS DECIMAL(5, 2),
    PRIMARY KEY (ESSN, PNO)
);

CREATE TABLE DEPENDENT (
    ESSN INT FOREIGN KEY REFERENCES EMPLOYEE(SSN),
    DEPENDENT_NAME VARCHAR(50),
    SEX CHAR(1),
    BDATE DATE,
    RELATIONSHIP VARCHAR(50),
    PRIMARY KEY (ESSN, DEPENDENT_NAME)
);


INSERT INTO DEPARTMENT VALUES (1, 'IT', null, '2020-01-01'),(2, 'HR', NULL, '2021-03-15');

INSERT INTO EMPLOYEE VALUES (101, 'John', 'A', 'Smith', '1980-05-15', '123 Elm St', 'M', 3000.00, NULL, 1);
INSERT INTO EMPLOYEE VALUES (102, 'Jane', 'B', 'Doe', '1985-08-22', '456 Oak St', 'F', 2500.00, 101, 2);

INSERT INTO DEPT_LOCATIONS VALUES (1, 'New York'), (1, 'Los Angeles'), (2, 'Chicago');

INSERT INTO PROJECT VALUES (201, 'Project A', 'New York', 1),(202, 'Project B', 'Chicago', 2);

INSERT INTO WORKS_ON VALUES (101, 201, 20), (102, 202, 15);

INSERT INTO DEPENDENT VALUES (101, 'Alice', 'F', '2010-06-15', 'Daughter'), (102, 'Bob', 'M', '2012-09-20', 'Son');



--1: Display all employee data.

SELECT * FROM EMPLOYEE;

--2: Display the employee first name, last name, salary, and department number.

SELECT FNAME, LNAME, SALARY, DNO FROM EMPLOYEE;

--3: Display all project names, locations, and the department responsible for them.

SELECT PNAME, PLOCATION, DNUM FROM PROJECT;

--4: Display each employee's full name and annual commission (10% of annual salary).

SELECT CONCAT(FNAME, ' ', LNAME) AS Full_Name, 
       (SALARY * 12 * 0.1) AS ANNUAL_COMM
FROM EMPLOYEE;

--Query 5: Display the IDs and names of employees earning more than 1000 LE monthly.

SELECT SSN, CONCAT(FNAME, ' ', LNAME) AS Full_Name
FROM EMPLOYEE
WHERE SALARY > 1000;

--6: Display the IDs and names of employees earning more than 10000 LE annually.

SELECT SSN, CONCAT(FNAME, ' ', LNAME) AS Full_Name
FROM EMPLOYEE
WHERE SALARY * 12 > 10000;

--7: Display the names and salaries of female employees.

SELECT CONCAT(FNAME, ' ', LNAME) AS Full_Name, SALARY
FROM EMPLOYEE
WHERE SEX = 'F';

--8: Display department ID and name managed by a specific manager.
UPDATE DEPARTMENT SET MGRSSN = 101 WHERE DNUMBER=1;
UPDATE DEPARTMENT SET MGRSSN = 102 WHERE DNUMBER=2;

SELECT DNUMBER, DNAME
FROM DEPARTMENT
WHERE MGRSSN = 101;

--9: Display project IDs, names, and locations controlled by department 1.

SELECT PNUMBER, PNAME, PLOCATION
FROM PROJECT
WHERE DNUM = 1;
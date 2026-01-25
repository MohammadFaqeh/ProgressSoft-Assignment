
CREATE DATABASE ProgressSoft_DB;
USE ProgressSoft_DB;

CREATE TABLE Gender (Gender_ID INT PRIMARY KEY, GenderName VARCHAR(20) NOT NULL);
CREATE TABLE University ( ID INT PRIMARY KEY,  UnivName VARCHAR(100) NOT NULL);
CREATE TABLE MyDepartment( Dept_ID INT PRIMARY KEY, DeptName VARCHAR(100) NOT NULL);

CREATE TABLE MyEmployee (  ID_Number INT PRIMARY KEY,  USERID INT UNIQUE NOT NULL, FIRST_NAME VARCHAR(100) NOT NULL, 
  LAST_NAME VARCHAR(100) NOT NULL, HIRE_DATE DATE,  SALARY DECIMAL(10, 2),  DEPT_ID INT, Gender_ID INT,  University_ID INT,EMP_IMAGE BLOB,
    FOREIGN KEY (DEPT_ID) REFERENCES MyDepartment(DEPT_ID),
    FOREIGN KEY (Gender_ID) REFERENCES Gender(Gender_ID),
    FOREIGN KEY (University_ID) REFERENCES University(ID));
SELECT 
    CONCAT(e.FIRST_NAME, '  ', e.LAST_NAME) AS "Employee Name", 
    e.SALARY AS "Salary", d.DeptName AS "Department Name", 
    CONCAT(m.FIRST_NAME, ' ', m.LAST_NAME) AS "Manager", 
    g.GenderName AS "Gender Name",   u.UnivName AS "Employee University"
FROM MyEmployee e 
INNER JOIN MyDepartment d ON e.DEPT_ID = d.Dept_ID 
INNER JOIN Gender g ON e.Gender_ID = g.Gender_ID 
INNER JOIN University u ON e.University_ID = u.ID 
LEFT JOIN MyEmployee m ON e.MANAGER_USERID = m.USERID;

INSERT INTO Gender  VALUES (1, 'Male'), (2, 'Female');
INSERT INTO University  VALUES (1, 'JU'), (2, 'JUST'), (3, ' PSUT');
INSERT INTO MyDepartment VALUES (1, 'Software Development'), (2, 'Human Resources');
INSERT INTO MyEmployee VALUES (990011, 'Ahmad', 'Hassan', 100 ,  '2020-01-10', 3000, 1, 1, 2, NULL , NULL);
INSERT INTO MyEmployee VALUES (990022, 'Layla', 'Omar', 200 , '2019-05-15', 3300, 2, 2, 1, NULL , NULL);
INSERT INTO VALUES (990033, 'Sami', 'Zaid', 101 , '2022-12-18', 1000, 1, 1, 3, NULL , 100);
INSERT INTO MyEmployee VALUES (990044, 'Noor', 'Salem', 201 , '2023-02-08', 1400, 2, 2, 1,NULL ,  200);

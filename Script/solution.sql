
CREATE DATABASE ProgressSoft_DB;
USE ProgressSoft_DB;

CREATE TABLE Gender (Gender_ID INT PRIMARY KEY, GenderName VARCHAR(20) NOT NULL);
CREATE TABLE University ( ID INT PRIMARY KEY,  UnivName VARCHAR(100) NOT NULL);
CREATE TABLE MyDepartment( Dept_ID INT PRIMARY KEY, DeptName VARCHAR(100) NOT NULL);
CREATE TABLE JobTitles ( Job_ID INT PRIMARY KEY, JobName VARCHAR(50) NOT NULL);
CREATE TABLE MyEmployee (  ID_Number INT PRIMARY KEY,  USERID INT UNIQUE NOT NULL, FIRST_NAME VARCHAR(100) NOT NULL, 
  LAST_NAME VARCHAR(100) NOT NULL, HIRE_DATE DATE,  SALARY DECIMAL(10, 2),  DEPT_ID INT, Gender_ID INT, Job_ID INT , University_ID INT,EMP_IMAGE BLOB,
    FOREIGN KEY (DEPT_ID) REFERENCES MyDepartment(DEPT_ID),
    FOREIGN KEY (Gender_ID) REFERENCES Gender(Gender_ID),
    FOREIGN KEY (University_ID) REFERENCES University(ID)
    FOREIGN KEY (Job_ID) REFERENCES JobTitles(Job_ID));

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
INSERT INTO JobTitles VALUES (1, 'Developer'), (2, 'Sales'), (3, 'HR'); (4,'Manager');

INSERT INTO MyEmployee VALUES (990011, 'Ahmad', 'Hassan', 100 ,  '2020-01-10', 3000, 1, 1, 4, 2, NULL , NULL);
INSERT INTO MyEmployee VALUES (990022, 'Layla', 'Omar', 200 , '2019-05-15', 3300, 2, 2,4, 1, NULL , NULL);
INSERT INTO MyEmployee VALUES (990033, 'Sami', 'Zaid', 101 , '2022-12-18', 2500, 1, 1,3, 3, NULL , 100);
INSERT INTO MyEmployee VALUES (990044, 'Noor', 'Salem', 201 , '2023-02-08', 1400, 2, 2,3, 1,NULL ,  200);
INSERT INTO MyEmployee VALUES (1001, 'SCOTT', 'Tiger',500 ,'1987-09-09', 3000, 1, 1, 1,NULL , NULL ,4);
INSERT INTO MyEmployee VALUES (1002, 'Ahmad', 'Omar',501 ,'1980-10-10', 2500, 1, 1,2,NULL , 500 ,1);
INSERT INTO MyEmployee VALUES (1003, 'Rami', 'Sami',502 ,'1986-05-24',2200, 2, 1,3 ,NULL , 500 ,2);
INSERT INTO MyEmployee VALUES (1004, 'Zaid', 'Hassan',503 ,'2024-01-01',1800, 1, 1,2 ,NULL , 500 ,2);


SELECT j.JobName, SUM(e.SALARY) AS Total_Payroll
FROM MyEmployee e
JOIN JobTitles j ON e.Job_ID = j.Job_ID
WHERE j.JobName <> 'Sales'
GROUP BY j.JobName
HAVING SUM(e.SALARY) > 2500;

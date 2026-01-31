
CREATE TABLE Gender (Gender_ID INT PRIMARY KEY, GenderName VARCHAR(20) NOT NULL);
CREATE TABLE University ( ID INT PRIMARY KEY,  UnivName VARCHAR(100) NOT NULL);
CREATE TABLE MyDepartment( Dept_ID INT PRIMARY KEY, DeptName VARCHAR(100) NOT NULL);
CREATE TABLE JobTitles ( Job_ID INT PRIMARY KEY, JobName VARCHAR(50) NOT NULL);
CREATE TABLE MyEmployee (  ID_Number INT PRIMARY KEY, FIRST_NAME VARCHAR(100) NOT NULL, LAST_NAME VARCHAR(100) NOT NULL,  USERID INT UNIQUE NOT NULL, HIRE_DATE DATE,  SALARY DECIMAL(10, 2), DEPT_ID INT, Gender_ID INT , University_ID INT,EMP_IMAGE BLOB,MANAGER_USERID INT , Job_ID INT,
    FOREIGN KEY (DEPT_ID) REFERENCES MyDepartment(DEPT_ID),
    FOREIGN KEY (Gender_ID) REFERENCES Gender(Gender_ID),
    FOREIGN KEY (University_ID) REFERENCES University(ID),
    FOREIGN KEY (MANAGER_USERID) REFERENCES MyEmployee(USERID) ,
    FOREIGN KEY (Job_ID) REFERENCES JobTitles(Job_ID));

INSERT INTO Gender  VALUES (1, 'Male');
INSERT INTO Gender  VALUES (2, 'Female');
INSERT INTO University  VALUES (1, 'JU');
INSERT INTO University  VALUES (2, 'JUST');
INSERT INTO University  VALUES (3, ' PSUT');
INSERT INTO MyDepartment VALUES (1, 'Software Development'); 
INSERT INTO MyDepartment VALUES (2, 'Human Resources');
INSERT INTO JobTitles VALUES (1, 'Developer');
INSERT INTO JobTitles VALUES (2, 'Sales');
INSERT INTO JobTitles VALUES (3, 'HR');
INSERT INTO JobTitles VALUES(4,'Manager');

INSERT INTO MyEmployee VALUES (990011, 'Ahmad', 'Hassan', 100 ,  TO_DATE('2020-01-10','YYYY-MM-DD'), 3000, 1, 1, 2, NULL,NULL , 4);
INSERT INTO MyEmployee VALUES (990022, 'Layla', 'Omar', 200 , TO_DATE('2019-05-15','YYYY-MM-DD'), 3300, 2, 2,2, NULL , NULL , 4);
INSERT INTO MyEmployee VALUES (990033, 'Sami', 'Zaid', 101 , TO_DATE('2022-12-18','YYYY-MM-DD'), 2500, 1, 1,3, NULL , 100 , 1);
INSERT INTO MyEmployee VALUES (990044, 'Noor', 'Salem', 201 , TO_DATE('2023-02-08','YYYY-MM-DD'), 1400, 2, 2,3, NULL , 200 , 2 );
INSERT INTO MyEmployee VALUES (1001, 'SCOTT', 'Tiger',500 ,TO_DATE('1987-09-09','YYYY-MM-DD'), 3000, 1, 1, 1,NULL , NULL ,4);
INSERT INTO MyEmployee VALUES (1002, 'Ahmad', 'Omar',501 ,TO_DATE('1980-10-10','YYYY-MM-DD'), 2500, 1, 1,2,NULL , 500 ,1);
INSERT INTO MyEmployee VALUES (1003, 'Rami', 'Sami',502 ,TO_DATE('1986-05-24','YYYY-MM-DD'),2200, 2, 1,3 ,NULL , 500 ,2);
INSERT INTO MyEmployee VALUES (1004, 'Zaid', 'Hassan',503 ,TO_DATE('2024-01-01','YYYY-MM-DD'),1800, 1, 1,2 ,NULL , 500 ,2);

SELECT 
    e.FIRST_NAME || '  ' || e.LAST_NAME AS "Employee Name", 
    e.SALARY AS "Salary", d.DeptName AS "Department Name", 
    m.FIRST_NAME || ' ' || m.LAST_NAME AS "Manager", 
    g.GenderName AS "Gender Name",   u.UnivName AS "Employee University"
FROM MyEmployee e 
INNER JOIN MyDepartment d ON e.DEPT_ID = d.Dept_ID 
INNER JOIN Gender g ON e.Gender_ID = g.Gender_ID 
INNER JOIN University u ON e.University_ID = u.ID 
LEFT JOIN MyEmployee m ON e.MANAGER_USERID = m.USERID;

SELECT j.JobName, SUM(e.SALARY) AS Total_Payroll
FROM MyEmployee e
JOIN JobTitles j ON e.Job_ID = j.Job_ID
WHERE j.JobName <> 'Sales'
GROUP BY j.JobName
HAVING SUM(e.SALARY) > 2500;

---SQL (Q6):
-- Create the destination table with the same schema as the source
CREATE TABLE MyEmployee_update AS SELECT * FROM MyEmployee WHERE 1=0;

-- Define the P_COPY_EMPLOYEE procedure for automated data migration
CREATE OR REPLACE PROCEDURE P_COPY_EMPLOYEE IS
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MyEmployee_update';
    INSERT INTO MyEmployee_update 
    SELECT * FROM MyEmployee;
    COMMIT;
END;
/
  -- Execute the procedure within a PL/SQL anonymous block
BEGIN
    P_COPY_EMPLOYEE;
END;
/
  -- Verify that the data has been successfully copied
SELECT * FROM MyEmployee_update;

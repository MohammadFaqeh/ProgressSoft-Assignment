# ProgressSoft Internship Assignment
## Introduction
This project focuses on the implementation and management of essential IT tools and technologies required for modern application deployment. The goal is to demonstrate a foundational understanding and practical experience in the following areas:
- Operating Systems: Linux administration and shell scripting.
- Databases: Relational database management using SQL and PL/SQL.
- Application Servers: Configuration and automation of Apache Tomcat.
- Modern Infrastructure: Containerization with Docker and orchestration with Kubernetes.
- Automation: Infrastructure as Code (IaC) using Vagrant and provisioning scripts.

## Environment Setup
 To ensure a consistent and isolated testing environment, the following setup was utilized:
- Virtualization: Oracle VM VirtualBox / VMware.
- Operating System: Ubuntu 22.04.3 LTS .
- Kernel Version: 5.15.0-116-generic.
- Architecture: x86_64.
- Hardware Allocation: 2GB RAM and 1 CPU Core.

 ## Project Sections:

 ---
 
 ## 1. Linux Administration
### System Information Script (Task 1)
The implementation phase began with the establishment of a centralized system monitoring framework. To achieve this, a modular Bash script was developed to automate the extraction of critical system metrics. The methodology focused on capturing real-time data including hostname configurations, network addressing (both internal and public IPs), and OS architecture details. This approach ensures that any system administrator can perform an immediate health check of the server with a single command, streamlining the diagnostic process and reducing human error in resource tracking.
* **Source Code:** [Source Code](./Script/sys_info.sh)

**Execution Output:**
![System Info Output](Screenshots/output_script.jpg)
---

### User and Access Management (Tasks 2 & 3 )
Following the initial setup, the methodology shifted toward securing the environment through a structured access control policy. This involved the provisioning of specific administrative groups, `PSgroup` and `dba`, to facilitate role-based access control. A new administrative user, `PS`, was then integrated into these groups, ensuring that all database-related operations are handled by an account with the appropriate permissions. To finalize the hardening process, a rigorous security policy was applied to the root account, enforcing strong authentication standards to protect the system's core integrity from unauthorized access.


**Verification (Users & Groups):**

![Create User Proof](Screenshots/Create_User.jpg)


![Users Proof](Screenshots/Root_Password.jpg)
---

### Service Installation & Network Security (Task 4 & 5)
The next stage of the deployment focused on preparing the server for production-ready services. This involved the orchestrated installation of `mysql-server` for data management and `haproxy` for load balancing capabilities. To protect these services, a "Deny-by-Default" firewall policy was implemented using UFW. The methodology here was to minimize the server's attack surface by explicitly filtering all traffic and only permitting ingress communication on port `3306`, ensuring that database services are accessible only through secured and intended channels.
To install the required database engine and load balancer, the following commands were executed:
* `sudo apt update` 
*  `sudo apt install mysql-server -y`  
* `sudo apt install haproxy -y`

![Install_Services](Screenshots/Install_mySql.jpg)
![Install_Services](Screenshots/Install_haproxy.jpg)

**Network Security:**
The firewall (UFW) was configured to strictly allow traffic on port **3306** (TCP/UDP) as per the assignment requirements.
* `sudo ufw allow 3306/tcp`
* `sudo ufw allow 3306/udp`

![Firewall](Screenshots/Firewall_Config.jpg)
---

### File Transfer Protocols (Task 6)
The methodology for transferring data between the Windows host and the Linux environment was designed with a "Security-First" approach. To facilitate the transfer, a temporary communication channel was established using NAT-based `Port Forwarding` (mapping host port 2222 to guest port 22). The firewall policy was temporarily modified to permit SSH traffic on port 22 to allow the `scp` operation. Once the file `task6.txt` was successfully synchronized and verified in the guest's home directory, the port 22 access was immediately revoked using a deny rule to eliminate any potential security vulnerabilities. This practice of dynamic port management demonstrates a commitment to maintaining a minimal attack surface throughout the administrative workflow.


![File Transfer on Linux](Screenshots/linux.jpg)

![File Transfer Command on Windows](Screenshots/Windows.jpg)

---

## 2. SQL & Relational Databases
### Database Schema Design Methodology (Q1)

To automate the environment setup, a comprehensive script named `Complete_Solution.sql` has been provided. This script sequentially handles database creation, schema definition, data population, and the generation of the final analytical report. It can be executed via the Linux terminal using the following command: `mysql -u root -p < Complete_Solution.sql`

* **Source Code:** [solution.sql](./Script/solution.sql)

The methodology adopted for the database design centered on achieving a high level of Data Normalization while maintaining strict Referential Integrity. To minimize data redundancy, the architecture was decomposed into four interconnected entities: `MyEmployee, MyDepartment, University, and Gender`. The design process involved careful selection of data types to ensure system precision; for instance, the `SALARY` field utilizes `DECIMAL(10, 2)` for financial accuracy, while the `EMP_IMAGE` field was implemented using the `BLOB` (Binary Large Object) type to allow the direct storage of employee portraits as binary data within the database. A unique aspect of this methodology is the implementation of a `Self-Referencing Relationship` via the `MANAGER_USERID` column. This design choice allows the system to represent the organizational hierarchy within a single table by linking an employee’s record to their manager’s `USERID`, thereby ensuring that the reporting structure is maintained through a robust foreign key constraint.

`show tables;`

![File Transfer on Linux](Screenshots/Tables.PNG)

`describe (TableName);`


![File Transfer on Linux](Screenshots/MyEmployee.PNG)
![File Transfer on Linux](Screenshots/Gender.PNG)
![File Transfer on Linux](Screenshots/DepartmentUniversity.PNG)
---

### Data Retrieval (Q2) 
The primary goal of this phase was to transform the normalized database into a readable report that fulfills the assignment requirements. To achieve this, I followed a structured query approach centered on the use of Table Joins. I utilized `INNER JOINs` to link the main `MyEmployee` table with the `MyDepartment, Gender, and University tables`, ensuring that each record correctly pulls the descriptive names instead of just the ID numbers.

For the organizational hierarchy, I implemented a `Self-Join` by linking the table to itself via the `MANAGER_USERID` field. In this step, I specifically chose a `LEFT JOIN` to ensure data completeness; this allows the report to include all employees, even those at the top of the hierarchy who do not have a supervisor. To improve the final output's presentation, I used the `CONCAT()` function to combine first and last names into a single column. Finally, I applied Table Aliasing (using e, m, d, etc.) to keep the SQL code organized and avoid any errors related to duplicate column names.
---

### Data Manipulation and Maintenance (Q3)

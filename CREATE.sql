CREATE TABLE REGION(
    REGION_ID VARCHAR2(8) PRIMARY KEY,
    REGION_NAME VARCHAR2(20) NOT NULL
);

CREATE TABLE SKILL_COLLECTION(
    SKILL_ID VARCHAR2(8) PRIMARY KEY,
    SKILL_DESCRIPTION VARCHAR2(25) NOT NULL,
    --No skill rate in the PDF, I don't know what to insert which is why it does not have NOT NULL constraint
    SKILL_RATE NUMBER(10)
);

CREATE TABLE EMPLOYEE(
    EMP_ID VARCHAR2(8) PRIMARY KEY,
    EMP_FNAME VARCHAR2(15) NOT NULL,
    EMP_MINITIAL VARCHAR2(15),
    EMP_LNAME VARCHAR2(15) NOT NULL,
    REGION_ID VARCHAR2(8) NOT NULL,
    DATE_OF_HIRE DATE NOT NULL,
    CONSTRAINT REGION_ID_EMPLOYEE_FK FOREIGN KEY (REGION_ID) REFERENCES REGION (REGION_ID)
);

CREATE TABLE EMPLOYEE_SKILL(
    EMP_ID VARCHAR2(8) NOT NULL,
    SKILL_ID VARCHAR2(8) NOT NULL,
    CONSTRAINT EMPLOYEE_SKILL_PK PRIMARY KEY (SKILL_ID, EMP_ID),
    CONSTRAINT SKILL_ID_SKILL_FK FOREIGN KEY (SKILL_ID) REFERENCES SKILL_COLLECTION (SKILL_ID),
    CONSTRAINT EMP_ID_SKILL_FK FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID)
);

CREATE TABLE CUSTOMER(
    CUST_ID VARCHAR2(8) PRIMARY KEY,
    CUST_FNAME VARCHAR2(15) NOT NULL,
    CUST_LNAME VARCHAR2(15) NOT NULL,
    CUST_PHONE NUMBER(15) NOT NULL,
    REGION_ID VARCHAR2(10) NOT NULL,
    CONSTRAINT REGION_ID_CUSTOMER_FK FOREIGN KEY (REGION_ID) REFERENCES REGION (REGION_ID)
);

CREATE TABLE MANAGER(
    MANAGER_ID VARCHAR2(8) PRIMARY KEY,
    EMP_ID VARCHAR2(8) NOT NULL,
    CONSTRAINT EMP_ID_MANAGER_FK FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID)
);

CREATE TABLE PROJECT(
    PROJ_ID VARCHAR2(8) PRIMARY KEY,
    CUST_ID VARCHAR2(8) NOT NULL,
    MANAGER_ID VARCHAR2(8) NOT NULL,
    PRJ_DESCRIPTION VARCHAR2(30),
    PRJ_CONTRACT_DATE DATE NOT NULL,
    EST_PRJ_START_DATE DATE NOT NULL,
    EST_PRJ_END_DATE DATE NOT NULL,
    EST_PROJECT_BUDGET NUMBER(15,2) NOT NULL,
    --RECORDS PROJECT WITHOUT FINAL DATE THAT IS WHY THERE IS NOT NOT NULL FOR ACTUAL DATES BELOW
    --The actual cost of the project is updated each Friday by adding that week’s cost to the actual cost.
    --The week’s cost is computed by multiplying the hours each employee worked by the rate of pay for that skill.
    ACTUAL_START_DATE DATE,
    ACTUAL_END_DATE DATE,
    ACTUAL_COST NUMBER(15,2) NOT NULL,
    CONSTRAINT CUST_ID_PROJECT_FK FOREIGN KEY (CUST_ID) REFERENCES CUSTOMER (CUST_ID),
    CONSTRAINT MANAGER_ID_PROJECT_FK FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER (MANAGER_ID)
    --CHECK FOR REGION BUT HOW
);

CREATE TABLE TASK(
    TASK_ID VARCHAR2(8) PRIMARY KEY,
    TASK_DESCRIPTION VARCHAR2(50) NOT NULL,
    TASK_START_DATE DATE NOT NULL,
    TASK_END_DATE DATE NOT NULL,
    SKILL_ID VARCHAR2(8) NOT NULL,
    --WE CAN USE A GROUP BY TO COUNT AND CHECK THE QUANTITY?
    QTY_NEEDED NUMBER(5) NOT NULL,
    PROJ_ID VARCHAR2(8) NOT NULL,
    CONSTRAINT SKILL_ID_TASK_FK FOREIGN KEY (SKILL_ID) REFERENCES SKILL_COLLECTION(SKILL_ID),
    CONSTRAINT PROJ_ID_TASK_FK FOREIGN KEY (PROJ_ID) REFERENCES PROJECT (PROJ_ID)
);

CREATE TABLE PROJECT_SCHEDULE(
    SCHEDULE_ID VARCHAR2(8) PRIMARY KEY,
    PROJ_ID VARCHAR2(8) NOT NULL,
    MANAGER_ID VARCHAR2(8) NOT NULL,
    REGION_ID VARCHAR2(8) NOT NULL,
    TASK_ID VARCHAR2(8) NOT NULL,
    CONSTRAINT PRJ_ID_PROJECT_SCHEDULE_FK FOREIGN KEY (PROJ_ID) REFERENCES PROJECT (PROJ_ID),
    CONSTRAINT MANAGER_ID_PROJECT_SCHEDULE_FK FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER (MANAGER_ID),
    CONSTRAINT REGION_ID_PROJECT_SCHEDULE_FK FOREIGN KEY (REGION_ID) REFERENCES REGION (REGION_ID),
    CONSTRAINT TASK_ID_PROJECT_SCHEDULE_FK FOREIGN KEY (TASK_ID) REFERENCES TASK (TASK_ID)
);

CREATE TABLE ASSIGNMENT(
    ASSIGN_ID VARCHAR2(8) PRIMARY KEY,
    TASK_ID VARCHAR2(8) NOT NULL,
    --ASSIGN START AND END SHOULD BE EQUAL TO TASK TABLE'S TASK_START_DATE AND TASK_END_DATE
    ASSIGN_START DATE NOT NULL,
    ASSIGN_END DATE NOT NULL,
    EMP_ID VARCHAR(8) NOT NULL,
    CONSTRAINT TASK_ID_ASSIGNMENT_FK FOREIGN KEY (TASK_ID) REFERENCES TASK (TASK_ID),
    CONSTRAINT EMP_ID_ASSIGNMENT_FK FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (EMP_ID)
);

CREATE TABLE WORK_LOG(
    WORK_LOG_ID VARCHAR2(8) PRIMARY KEY,
    ASSIGN_ID VARCHAR(8) NOT NULL,
    TOTAL_HOURS_WORKED NUMBER(8) NOT NULL,
    CONSTRAINT ASSIGN_ID_WORK_LOG_FK FOREIGN KEY (ASSIGN_ID) REFERENCES ASSIGNMENT (ASSIGN_ID)
);

CREATE TABLE BILL(
    BILL_ID VARCHAR2(8) PRIMARY KEY,
    WORK_LOG_ID VARCHAR2(8) NOT NULL,
    CONSTRAINT WORK_LOG_ID_BILL_FK FOREIGN KEY (WORK_LOG_ID) REFERENCES WORK_LOG (WORK_LOG_ID)
);
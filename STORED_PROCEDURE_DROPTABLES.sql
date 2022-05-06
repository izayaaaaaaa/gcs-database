CREATE PROCEDURE DROP_TABLES
AS
BEGIN
    DROP TABLE REGION;
    DROP TABLE SKILL_COLLECTION;
    DROP TABLE EMPLOYEE;
    DROP TABLE EMPLOYEE_SKILL;
    DROP TABLE CUSTOMER;
    DROP TABLE MANAGER;
    DROP TABLE PROJECT;
    DROP TABLE TASK;
    DROP TABLE PROJECT_SCHEDULE;
    DROP TABLE ASSIGNMENT;
    DROP TABLE BILL;
    DROP TABLE WORK_LOG;
END;
CREATE OR REPLACE VIEW Employee_View AS
SELECT EMPLOYEE.EMP_ID, EMPLOYEE.EMP_FNAME, EMPLOYEE.EMP_MINITIAL, EMPLOYEE.EMP_LNAME, EMPLOYEE_SKILL.SKILL_ID, SKILL_DESCRIPTION,
EMPLOYEE.REGION_ID, EMPLOYEE.DATE_OF_HIRE, REGION_NAME

FROM EMPLOYEE
JOIN EMPLOYEE_SKILL ON EMPLOYEE.EMP_ID=EMPLOYEE_SKILL.EMP_ID
JOIN SKILL_COLLECTION ON EMPLOYEE_SKILL.SKILL_ID=SKILL_COLLECTION.SKILL_ID
JOIN REGION ON EMPLOYEE.REGION_ID=REGION.REGION_ID

ORDER BY LENGTH (EMP_ID), EMP_ID ASC;
SELECT * FROM Employee_View

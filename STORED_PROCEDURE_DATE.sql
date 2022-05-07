CREATE OR REPLACE PROCEDURE current_date  AS
BEGIN
-- display the current system date in long format
  DBMS_OUTPUT.PUT_LINE( 'The day and date for today is ' || TO_CHAR(SYSDATE, 'DL') );
END current_date;

BEGIN
  current_date (); 
END;
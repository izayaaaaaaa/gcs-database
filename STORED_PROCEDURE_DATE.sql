CREATE OR REPLACE PROCEDURE table_creation AS
BEGIN
-- display the current system date in long format
  DBMS_OUTPUT.PUT_LINE( 'Table creation ' || TO_CHAR(SYSDATE, 'DL') );
END table_creation;

BEGIN
  table_creation(); 
END;
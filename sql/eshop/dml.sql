--
-- Testing
-- 

USE eshop;
Delete from plocklista;
delete from bestallning;
SELECT * FROM plocklista;
SELECT * FROM bestallning;
call show_order();
call get_customer(1);
call show_a_order(4);
call get_kund_id(4);
	
SELECT * FROM lagerhylla;



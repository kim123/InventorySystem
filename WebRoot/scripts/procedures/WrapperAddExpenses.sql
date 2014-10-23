DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddExpenses`(in p_result varchar(50),
										in p_expense varchar(50),
										in p_amount decimal(22,2),
										in p_createdby varchar(50))
BEGIN
	SET p_result = 'initialwrapper';
	
	INSERT INTO other_expenses(name,amount,created_date,created_by)
		VALUES(p_expense,p_amount,CURRENT_TIMESTAMP,p_createdby);
	COMMIT;
	
	SET p_result = 'success';
END$$
DELIMITER ;

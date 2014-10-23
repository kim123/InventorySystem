DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddExpenses`(in p_expense varchar(50),
								in p_amount decimal(22,2),
								in p_createdby varchar(50))
BEGIN
	DECLARE v_result varchar(50);

	SET v_result = 'initial';

	CALL WrapperAddExpenses(@v_result,p_expense,p_amount,p_createdby);

	SELECT @v_result;
END$$
DELIMITER ;

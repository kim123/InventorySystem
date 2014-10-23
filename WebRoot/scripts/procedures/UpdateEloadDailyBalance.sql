DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEloadDailyBalance`(in p_eloadDailyBalanceId int(11),
												in p_additionalBalance decimal(22,2),
												in p_eloadType varchar(10),
												in p_updatedBy varchar(50))
BEGIN
	DECLARE v_result varchar(50);

	SET v_result = 'initial';
	CALL WrapperUpdateEloadDailyBalance(@v_result,p_eloadDailyBalanceId,p_additionalBalance,
											p_eloadType,p_updatedBy);
	
	SELECT @v_result;

END$$
DELIMITER ;

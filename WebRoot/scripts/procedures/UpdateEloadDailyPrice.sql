DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEloadDailyPrice`(in p_priceId int(11),
																		in p_enableStatus int(3),
																		in p_updateby varchar(50))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(3);

	SET v_result = 'initial';
	
	SELECT count(1) into v_count from eload_daily_prices where prize_id=p_priceId;
	IF (v_count = 0) THEN
		SET v_result = 'price.id.does.not.exist';
	ELSE
		CALL WrapperUpdateEloadDailyPrice(@v_result,p_priceId,p_enableStatus,p_updateby);
	END IF;	

	SELECT @v_result;
END$$
DELIMITER ;

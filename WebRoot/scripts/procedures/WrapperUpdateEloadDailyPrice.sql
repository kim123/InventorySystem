DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperUpdateEloadDailyPrice`(in p_result varchar(50),
																			in p_priceId int(11),
																			in p_enableStatus int(3),
																			in p_updateby varchar(50))
BEGIN
	SET p_result = 'initialwrapper';
	
	update eload_daily_prices set enable_status=p_enableStatus,
									created_by=p_updateby,
									created_date=CURRENT_TIMESTAMP
		where prize_id=p_priceId;
	COMMIT;

	SET p_result = 'success';
END$$
DELIMITER ;

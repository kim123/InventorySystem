DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperCheckIn`(out p_result varchar(50),
									in p_userid varchar(50),
									in p_startingcash decimal(22,2),
									in p_startingglobeeload decimal(22,2),
									in p_startingsmarteload decimal(22,2),
									in p_startingsuneload decimal(22,2))
BEGIN
	set p_result = 'initialwrapper';
	
	INSERT INTO on_duty(login_date,user_id,starting_cash,ending_cash,duty_status)
		VALUES(CURRENT_TIMESTAMP,p_userid,p_startingcash,p_startingcash,'0');
	COMMIT;

	INSERT INTO eload_daily_balances(created_date,created_by,starting_eload_smart,starting_eload_globe,starting_eload_sun,
										total_eload_smart,total_eload_globe,total_eload_sun)
		VALUES(CURRENT_TIMESTAMP,p_userid,p_startingsmarteload,p_startingglobeeload,p_startingsuneload,
										p_startingsmarteload,p_startingglobeeload,p_startingsuneload);
	COMMIT;

	set p_result = 'success';
END$$
DELIMITER ;

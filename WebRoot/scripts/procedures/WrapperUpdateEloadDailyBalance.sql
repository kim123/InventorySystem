DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperUpdateEloadDailyBalance`(out p_result varchar(50),
													in p_eloadDailyBalanceId int(11),
													in p_additionalBalance decimal(22,2),
													in p_eloadType varchar(10),
													in p_updatedBy varchar(50))
BEGIN
	DECLARE v_beginningbal decimal(22,2);
	DECLARE v_totalLoad decimal(22,2);
	
	set p_result = 'initialwrapper';

	if (p_eloadType='smart') then
		select total_eload_smart into v_beginningbal
			from eload_daily_balances where daily_balance_id=p_eloadDailyBalanceId;

		set v_totalLoad = v_beginningbal+p_additionalBalance;
		
		UPDATE eload_daily_balances SET additional_balance_smart=p_additionalBalance,	
									total_eload_smart=v_totalLoad,
									updated_date_smart=CURRENT_TIMESTAMP
			WHERE daily_balance_id=p_eloadDailyBalanceId;		
		COMMIT;

	ELSEIF (p_eloadType='globe') then
		select total_eload_globe into v_beginningbal
			from eload_daily_balances where daily_balance_id=p_eloadDailyBalanceId;

		set v_totalLoad = v_beginningbal+p_additionalBalance;
		
		UPDATE eload_daily_balances SET additional_balance_globe=p_additionalBalance,	
									total_eload_globe=v_totalLoad,
									updated_date_globe=CURRENT_TIMESTAMP
			WHERE daily_balance_id=p_eloadDailyBalanceId;		
		COMMIT;

	ELSEIF (p_eloadType='sun') then
		select total_eload_sun into v_beginningbal
			from eload_daily_balances where daily_balance_id=p_eloadDailyBalanceId;

		set v_totalLoad = v_beginningbal+p_additionalBalance;
		
		UPDATE eload_daily_balances SET additional_balance_sun=p_additionalBalance,	
									total_eload_sun=v_totalLoad,
									updated_date_sun=CURRENT_TIMESTAMP
			WHERE daily_balance_id=p_eloadDailyBalanceId;		
		COMMIT;

	end if;

	set p_result = 'success';
END$$
DELIMITER ;

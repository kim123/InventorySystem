DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperCheckOut`(out p_result varchar(50),
									in p_onduty_id int(11),
									in p_eloadDailyBalanceid int(11),
									in p_userid int(11),
									in p_totalcash decimal(22,2),
									in p_handovercash decimal(22,2),
									in p_endingbalglobe decimal(22,2),
									in p_endingbalsmart decimal(22,2),
									in p_endingbalsun decimal(22,2),
									in p_journalentry varchar(300))
BEGIN
	DECLARE v_cashending decimal(22,2);
	DECLARE v_beginningbalsmart decimal(22,2);
	DECLARE v_beginningbalglobe decimal(22,2);
	DECLARE v_beginningbalsun decimal(22,2);
	DECLARE v_loadsoldsmart decimal(22,2);
	DECLARE v_loadsoldglobe decimal(22,2);
	DECLARE v_loadsoldsun decimal(22,2);

	set p_result = 'initialwrapper';
	set v_cashending = p_totalcash-p_handovercash;
	
	select total_eload_smart,total_eload_globe,total_eload_sun
			into v_beginningbalsmart,v_beginningbalglobe,v_beginningbalsun
	from eload_daily_balances where daily_balance_id=p_eloadDailyBalanceid;

	set v_loadsoldsmart = v_beginningbalsmart-p_endingbalsmart;
	set v_loadsoldglobe = v_beginningbalglobe-p_endingbalglobe;
	set v_loadsoldsun = v_beginningbalsun-p_endingbalsun;

	update on_duty set total_cash=p_totalcash,
						cash_hand_over=p_handovercash,
						ending_cash=v_cashending,
						logout_date=CURRENT_TIMESTAMP,
						journal_entry=p_journalentry
		where on_duty_id=p_onduty_id;
	COMMIT;
	
	update eload_daily_balances set ending_balance_smart=p_endingbalsmart,
									ending_balance_globe=p_endingbalglobe,
									ending_balance_sun=p_endingbalsun,
									actual_sold_out_smart=v_loadsoldsmart,
									actual_sold_out_globe=v_loadsoldglobe,
									actual_sold_out_sun=v_loadsoldsun,
									updated_date=CURRENT_TIMESTAMP
		where daily_balance_id=p_eloadDailyBalanceid;
	COMMIT;

	set p_result = 'success';
END$$
DELIMITER ;

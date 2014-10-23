DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddEloadDailySales`(out p_result varchar(50),
																	in p_eloadproductid int(11),
																	in p_priceid int(11),
																	in p_quantity int(11),
																	in p_updatedBy varchar(50),
																	in p_eloadtype varchar(20))
BEGIN
	DECLARE v_price decimal(22,2);
 	DECLARE v_total decimal(22,2);
	#automatic computation for the ending balance
	DECLARE v_dailyBalanceId INT(11);
	DECLARE v_beginningBalance DECIMAL(22,2);
	DECLARE v_endingBalance DECIMAL(22,2);
	DECLARE v_totalSales DECIMAL(22,2);
	DECLARE v_totalMarkup DECIMAL(22,2);
	DECLARE v_soldLoad DECIMAL(22,2);
	DECLARE hay VARCHAR(2);
	
	set p_result = 'initialwrapper';

	SELECT price into v_price from eload_daily_prices where prize_id=p_priceid;
	SET v_total = p_quantity * v_price;

	INSERT INTO eload_daily_sales(eload_product_id,price_id,quantity,total,created_by,created_date)
		VALUES(p_eloadproductid,p_priceid,p_quantity,v_total,p_updatedBy,CURRENT_TIMESTAMP);
	COMMIT;

	#automatic computation for the ending balance
	set p_result = 'start.autocompute.ending.balance';

	select SUM(b.total) totalsales, c.totalMarkup
	into v_totalSales, v_totalMarkup
	from eload_daily_sales b
	join (
		select a.eload_product_id,sum(a.subMarkupTotal) totalMarkup
		from (
			select s.eload_product_id,(p.markup_price*s.quantity) subMarkupTotal
			from eload_daily_sales s
			join eload_daily_prices p on p.prize_id=s.price_id
			where s.eload_product_id=p_eloadproductid and date(s.created_date)=CURDATE()
		) a
	) c on b.eload_product_id=c.eload_product_id;

	set p_result = p_eloadType;
	if (p_eloadtype LIKE 'globe') THEN
		select total_eload_globe,daily_balance_id into v_beginningBalance,v_dailyBalanceId
			from eload_daily_balances
			where date(created_date)=CURDATE();
	ELSEIF (p_eloadtype LIKE 'smart') THEN
		select total_eload_smart,daily_balance_id into v_beginningBalance,v_dailyBalanceId
			from eload_daily_balances
			where date(created_date)=CURDATE();
	ELSEIF (p_eloadtype LIKE 'sun') THEN
		select total_eload_sun,daily_balance_id into v_beginningBalance,v_dailyBalanceId
			from eload_daily_balances
			where date(created_date)=CURDATE();
	END IF;
	
	SET v_soldLoad = v_totalSales+v_totalMarkup;
	SET v_endingBalance = v_beginningBalance-v_soldLoad;

	if (p_eloadtype='globe') THEN
		update eload_daily_balances 
			set ending_balance_globe = v_endingBalance, actual_sold_out_globe = v_soldLoad
			where daily_balance_id=v_dailyBalanceId;
		COMMIT;
	ELSEIF (p_eloadtype='smart') THEN
		update eload_daily_balances 
			set ending_balance_smart = v_endingBalance, actual_sold_out_smart = v_soldLoad
			where daily_balance_id=v_dailyBalanceId;
		COMMIT;
	ELSEIF (p_eloadtype='sun') THEN
		update eload_daily_balances 
			set ending_balance_sun = v_endingBalance, actual_sold_out_sun = v_soldLoad
			where daily_balance_id=v_dailyBalanceId;
		COMMIT;
	END IF;

	set p_result = 'success';
END$$
DELIMITER ;

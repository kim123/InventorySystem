DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddEloadDailyPrice`(in p_result varchar(50),
												in p_eloadproductid int(11),
												in p_price decimal(22,2),
												in p_markupprice decimal(22,2),
												in p_retailprice decimal(22,2),
												in p_created_by varchar(50))
BEGIN
	DECLARE v_count INT(3);
	
	set p_result = 'initialwrapper';
	
	SELECT count(1) into v_count from eload_daily_prices 
		where eload_product_id=p_eloadproductid and price=p_price and enable_status=0;
	IF (v_count > 0) THEN
		set p_result = CONCAT('Eload has existing price of ',p_price,'.');
	ELSE
		INSERT INTO eload_daily_prices(eload_product_id,price,retail_price,markup_price,enable_status,created_by,created_date)
			VALUES (p_eloadproductid,p_price,p_retailprice,p_markupprice,'0',p_created_by,CURRENT_TIMESTAMP);
		COMMIT;
		set p_result = 'success';
	END IF;

	
END$$
DELIMITER ;

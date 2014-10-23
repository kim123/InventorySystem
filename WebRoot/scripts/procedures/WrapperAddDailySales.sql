DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddDailySales`(in p_result varchar(50),
											in p_onhandid int(11),
											in p_productid int(11),
											in p_quantity int(11),
											in p_amount decimal(22,2),
											in p_createdby varchar(45))
BEGIN
	DECLARE v_beforequantity INT(11);
	DECLARE v_newendingquantity INT(11);
	SET p_result = 'initialwrapper';
	
	select ending_quantity INTO v_beforequantity from daily_on_hand_products where daily_on_hand_id='4';
	SET v_newendingquantity = v_beforequantity-p_quantity;
	
	INSERT INTO daily_sales (daily_on_hand_id,daily_sales_product_id,before_quantity_sold,quantity_sold,amount,after_quantity_sold,created_date,created_by)
		VALUES(p_onhandid,p_productid,v_beforequantity,p_quantity,p_amount,v_newendingquantity,CURRENT_TIMESTAMP,p_createdby);
	COMMIT;

	UPDATE daily_on_hand_products SET ending_quantity=v_newendingquantity WHERE daily_on_hand_id=p_onhandid;
	COMMIT;
	
	set p_result = 'success';
END$$
DELIMITER ;

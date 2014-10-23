DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddStocksInventory`(in p_result varchar(50),
												in p_productId int(11),
												in p_quantity int(5),
												in p_createdBy varchar(45))
BEGIN
	DECLARE v_sum int (5);
	DECLARE v_total int(5);
	set p_result = 'initialwrapper';
	
	select sum(quantity) into v_sum from inventory where inventory_product_id=p_productId;
	if (v_sum IS NULL) then
		set v_sum = 0;
	end if;
	set v_total = v_sum+p_quantity;

	insert into inventory (inventory_product_id,quantity,total,created_date,created_by)
		values(p_productId,p_quantity,v_total,CURRENT_TIMESTAMP,p_createdBy);
	COMMIT;

	set p_result = 'success';
END$$
DELIMITER ;

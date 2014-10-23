DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStocksInventory`(in p_productId int(11),
										in p_quantity int(5),
										in p_createdBy varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);
	
	SET v_result = 'initial';
	select count(1) into v_count from product where product_id=p_productId;
	if (v_count=0) then
		SET v_result = 'product.id.does.not.exist';
	else 
		CALL WrapperAddStocksInventory(@v_result,p_productId,p_quantity,p_createdBy);
	end if;

	SELECT @v_result;

END$$
DELIMITER ;

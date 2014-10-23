-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddDailySales`(in p_onhandid int(11),
									in p_productid int(11),
									in p_quantity int(11),
									in p_amount decimal(22,2),
									in p_createdby varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);
	
	SET v_result = 'initial';
	select count(1) into v_count from product where product_id=p_productid;
	if (v_count=0) then
		SET v_result = 'product.id.does.not.exist';
	else 
		CALL WrapperAddDailySales(@v_result,p_onhandid,p_productid,p_quantity,p_amount,p_createdBy);
	end if;

	SELECT @v_result;
END
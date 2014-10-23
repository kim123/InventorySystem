DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePrices`(in p_productid int(11),
									in p_retailprice decimal(22,2),
									in p_sellingmaxprice decimal(22,2),
									in p_sellingMinPrice decimal(22,2),
									in p_updatedby varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	SET v_result = 'initial';
	select count(1) into v_count from product where product_id=p_productid;
	if (v_count=0) then
		SET v_result = 'product.id.does.not.exist';
	else 
		CALL WrapperUpdatePrices(@v_result,p_productid,p_retailprice,p_sellingmaxprice,p_sellingMinPrice,p_updatedby);
	end if;
	
	SELECT @v_result;
END$$
DELIMITER ;

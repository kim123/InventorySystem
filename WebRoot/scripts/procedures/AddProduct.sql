DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduct`(in p_productname varchar(45),
								in p_category int(11),
								in p_createdby varchar(45),
								in p_retailprice decimal(22,2),
								in p_sellingmaxprice decimal(22,2),
								in p_sellingminprice decimal(22,2))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	SET v_result = 'initial';
	select count(1) into v_count from product where product_name=p_productname;
	if (v_count > 0) then
		set v_result = 'product.name.already.exists';
	else 
		CALL WrapperAddProduct(@v_result,p_productname,p_category,p_createdby,p_retailprice,p_sellingmaxprice,p_sellingminprice);
	end if;

	SELECT @v_result;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddProduct`(out p_result varchar(50),
										in p_productname varchar(45),
										in p_category int(11),
										in p_createdby varchar(45),
										in p_retailprice decimal(22,2),
										in p_sellingmaxprice decimal(22,2),
										in p_sellingminprice decimal(22,2))
BEGIN
	DECLARE v_productid INT(11);

	SET p_result = 'initialwrapper';
	INSERT INTO product(product_name,category_id,created_date,created_by)
		values(p_productname,p_category,CURRENT_TIMESTAMP,p_createdby);
	COMMIT;
	SET p_result = 'success.insert.product';

	SELECT product_id INTO v_productid FROM product WHERE product_name=p_productname;
	INSERT INTO price(price_product_id,retail_price,selling_max_price,selling_min_price,created_date,created_by)
		values(v_productid,p_retailprice,p_sellingmaxprice,p_sellingminprice,CURRENT_TIMESTAMP,p_createdby);
	COMMIT;
	SET p_result = 'success';

END$$
DELIMITER ;

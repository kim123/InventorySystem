DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperUpdatePrices`(out p_result varchar(50),
										in p_productid int(11),
										in p_retailprice decimal(22,2),
										in p_sellingmaxprice decimal(22,2),
										in p_sellingMinPrice decimal(22,2),
										in p_updatedby varchar(45))
BEGIN
	
	SET p_result = 'initialwrapper';
	UPDATE price SET retail_price=p_retailprice,
						selling_max_price=p_sellingmaxprice,
						selling_min_price=p_sellingMinPrice,
						created_by=p_updatedby
		WHERE price_product_id=p_productid;
	COMMIT;
	SET p_result = 'success';

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEloadDailyPrice`(in p_eloadproductid int(11),
										in p_price decimal(22,2),
										in p_markupprice decimal(22,2),
										in p_retailprice decimal(22,2),
										in p_created_by varchar(50))
BEGIN
	DECLARE v_result varchar(50);

	set v_result = 'initial';

	CALL WrapperAddEloadDailyPrice(@v_result,p_eloadproductid,p_price,p_markupprice,p_retailprice,p_created_by);

	SELECT @v_result;
END$$
DELIMITER ;

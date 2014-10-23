DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEloadDailySales`(in p_eloadproductid int(11),
																	in p_priceid int(11),
																	in p_quantity int(11),
																	in p_updatedBy varchar(50),
																	in p_eloadtype varchar(20))
BEGIN
	DECLARE v_result varchar(50);

	SET v_result = 'initial';
	#p_salesvalue -> priceid-quantity;
	CALL WrapperAddEloadDailySales(@v_result,p_eloadproductid,p_priceid,p_quantity,p_updatedBy,p_eloadtype);
	
	SELECT @v_result;
END$$
DELIMITER ;

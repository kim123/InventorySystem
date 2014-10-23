DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArchiveProduct`(in p_productid int(11),
									in p_status int(2),
									in p_updatedby varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);
	
	SET v_result = 'initial';
	select count(1) into v_count from product where product_id=p_productid;
	if (v_count=0) then
		SET v_result = 'product.id.does.not.exist';
	else 
		CALL WrapperArchiveProduct(@v_result,p_productid,p_status,p_updatedby);
	end if;

	SELECT @v_result;
END$$
DELIMITER ;

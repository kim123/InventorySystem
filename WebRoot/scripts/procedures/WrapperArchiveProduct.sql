DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperArchiveProduct`(out p_result varchar(50),
											in p_productid int(11),
											in p_status int(2),
											in p_updatedby varchar(45))
BEGIN

	SET p_result = 'initialwrapper';
	UPDATE product SET is_history=p_status,
						created_by=p_updatedby
		WHERE product_id=p_productid;
	COMMIT;
	SET p_result = 'success';

END$$
DELIMITER ;

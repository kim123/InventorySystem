DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifyRole`(in p_userid varchar(45),
								in p_rankId int(3),
								in p_updatedBy varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(3);

	set v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set v_result = 'user.does.not.exist';
	else
		CALL WrapperModifyRole(@v_result,p_userid,p_rankId,p_updatedBy);
	end if;
	
	SELECT @v_result;

END$$
DELIMITER ;

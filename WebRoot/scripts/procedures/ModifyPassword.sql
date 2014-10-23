DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifyPassword`(in p_userId int(11),
									in p_newPassword varchar(100),
									in p_updatedBy varchar(50))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(3);

	set v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set v_result = 'user.does.not.exist';
	else
		CALL WrapperModifyPassword(@v_result,p_userId,p_newPassword,p_updatedBy);
	end if;
	
	select @v_result;	

END$$
DELIMITER ;

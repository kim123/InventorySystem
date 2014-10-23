DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifyOwnPassword`(in p_userId int(11),
										in p_oldPassword varchar(100),
										in p_newPassword varchar(100),
										in p_createdBy varchar(50))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_oldPassword varchar(100);
	DECLARE v_count int(3);

	set v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set v_result = 'user.does.not.exist';
	else
		select pasword into v_oldPassword from user where user_id=p_userId;
		if (strcmp(v_oldPassword,p_oldPassword)!=0) then
			set v_result = 'oldpassword.is.not.equal';
		else
			call WrapperModifyPassword(@v_result,p_userId,p_newPassword,p_createdBy);
		end if;
	end if;

	select @v_result;

END$$
DELIMITER ;

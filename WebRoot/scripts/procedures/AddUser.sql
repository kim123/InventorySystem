DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUser`(in p_username varchar(45),
								in p_fullname varchar(45),
								in p_password varchar(100),
								in p_rankid int(2),
								in p_createdby varchar(50),
								in p_bankaccountnum varchar(70))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	set v_result = 'initial';
	select count(1) into v_count from user where user_name=p_username;
	if (v_count > 0) then
		set v_result = 'username.already.exists';
	ELSE
		CALL WrapperAddUser(@v_result,p_username,p_fullname,p_password,p_rankid,p_createdby,p_bankaccountnum);
	end if;
	
	SELECT @v_result;
	
END$$
DELIMITER ;

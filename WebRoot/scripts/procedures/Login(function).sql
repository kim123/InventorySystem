-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` FUNCTION `Login`(p_username varchar(45),
							p_password varchar(100)) RETURNS varchar(50) CHARSET utf8
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_countexisting int(2);
	DECLARE v_userstatus int(2);
	DECLARE v_username varchar(45);
	DECLARE v_password varchar(100);   

	set v_result = 'success';

	select count(1) into v_countexisting from user where user_name collate utf8_bin = p_username;
	select status into v_userstatus from user where user_name collate utf8_bin = p_username;
	select pasword into v_password from user where user_name collate utf8_bin = p_username;
	if (v_countexisting=0) then
		set v_result = 'user.not.existing';
	elseif (v_userstatus=1) then
		set v_result = 'account.disabled';
	elseif (strcmp(v_password,p_password)!=0) then
		set v_result = 'incorrect.password';
	end if;

RETURN v_result;
END
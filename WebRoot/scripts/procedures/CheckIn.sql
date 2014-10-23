DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckIn`(in p_userid varchar(50),
								in p_startingcash decimal(22,2),
								in p_startingglobeeload decimal(22,2),
								in p_startingsmarteload decimal(22,2),
								in p_startingsuneload decimal(22,2))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);
	
	set @v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set @v_result = 'user.does.not.exist';
	else
		CALL WrapperCheckIn(@v_result,p_userid,p_startingcash,p_startingglobeeload,p_startingsmarteload,p_startingsuneload);
	end if;

	select @v_result;

END$$
DELIMITER ;

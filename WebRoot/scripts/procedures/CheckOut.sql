DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckOut`(in p_onduty_id int(11),
								in p_eloadDailyBalanceid int(11),
								in p_userid int(11),
								in p_totalcash decimal(22,2),
								in p_handovercash decimal(22,2),
								in p_endingbalglobe decimal(22,2),
								in p_endingbalsmart decimal(22,2),
								in p_endingbalsun decimal(22,2),
								in p_journalentry varchar(300))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	set v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set v_result = 'user.does.not.exist';
	else
		CALL WrapperCheckOut(@v_result,p_onduty_id,p_eloadDailyBalanceid,p_userid,p_totalcash,p_handovercash,p_endingbalglobe,p_endingbalsmart,p_endingbalsun,p_journalentry);
	end if;

	select @v_result;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `RecordJournalEntry`(in p_userid int(11),
										in p_journalentry varchar(300),
										in p_createddate varchar(30))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	set v_result = 'initial';
	select count(1) into v_count from user where user_id=p_userId;
	if (v_count=0) THEN
		set v_result = 'user.does.not.exist';
	else
		CALL WrapperRecordJournalEntry(@v_result,p_userid,p_journalentry,p_createddate);
	end if;

	select @v_result;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperRecordJournalEntry`(out p_result varchar(50),
												in p_userid int(11),
												in p_journalentry varchar(300),
												in p_createddate varchar(30))
BEGIN
	set p_result = 'initialwrapper';
	UPDATE on_duty SET journal_entry=p_journalentry WHERE user_id=p_userid AND DATE(login_date)=p_createddate;
	COMMIT;
	set p_result = 'success';
END$$
DELIMITER ;

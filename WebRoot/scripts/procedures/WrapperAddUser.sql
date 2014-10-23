DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddUser`(out p_result varchar(50),
									in p_username varchar(45),
									in p_fullname varchar(45),
									in p_password varchar(100),
									in p_rankid int(2),
									in p_createdby varchar(50),
									in p_bankaccountnum varchar(70))
BEGIN

	set p_result = 'initialwrapper';
	insert into user(user_name,full_name,pasword,rank_id,created_date,created_by,status,bank_account_num)
		values(p_username,p_fullname,p_password,p_rankid,CURRENT_TIMESTAMP,p_createdby,0,p_bankaccountnum);
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

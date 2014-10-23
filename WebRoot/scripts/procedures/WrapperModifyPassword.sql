DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperModifyPassword`(out p_result varchar(50),
															in p_userId int(11),
															in p_newPassword varchar(100),
															in p_updatedBy varchar(50))
BEGIN

	set p_result = 'initialwrapper';
	update user set pasword=p_newPassword ,
					created_date=CURRENT_TIMESTAMP,
					created_by=p_updatedBy
		where user_id=p_userId;
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

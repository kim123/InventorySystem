DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperModifyRole`(out p_result varchar(50),
										in p_userid varchar(45),
										in p_rankId int(3),
										in p_updatedBy varchar(45))
BEGIN

	set p_result = 'initialwrapper';
	update user set rank_id=p_rankId,
					created_date=CURRENT_TIMESTAMP,
					created_by=p_updatedBy
		where user_id=p_userid;
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

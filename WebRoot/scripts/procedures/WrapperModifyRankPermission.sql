DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperModifyRankPermission`(out p_result varchar(50),
												in p_rankid int(3),
												in p_permission varchar(150),
												in p_createdby varchar(45))
BEGIN

	set p_result = 'initialwrapper';
	update rank set permission=p_permission,
					created_date=CURRENT_TIMESTAMP,
					created_by=p_createdby
			where rank_id=p_rankid;
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

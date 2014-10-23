DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddRole`(out p_result varchar(50),
									in p_role varchar(45),
									in p_permission varchar(45),
									in p_createdby varchar(45))
BEGIN

	set p_result = 'initialwrapper';
	insert into rank(rank,permission,created_date,created_by)
		values(p_role,p_permission,CURRENT_TIMESTAMP,p_createdby);
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

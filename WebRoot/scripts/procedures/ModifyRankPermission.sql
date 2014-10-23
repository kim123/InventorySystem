DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModifyRankPermission`(in p_rankid int(3),
											in p_permission varchar(150),
											in p_createdby varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(3);

	set v_result = 'initial';
	select count(1) into v_count from rank where rank_id=p_rankid;
	if (v_count=0) then
		set v_result = 'role.does.not.exist';
	else
		CALL WrapperModifyRankPermission(@v_result,p_rankid,p_permission,p_createdby);
	end if;

	select @v_result;

END$$
DELIMITER ;

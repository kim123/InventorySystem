DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddRole`(in p_role varchar(45),
							in p_permission varchar(45),
							in p_createdby varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(3);

	set v_result = 'initial';
	select count(1) into v_count from rank where rank=p_role;
	if (v_count > 0) then
		set v_result = 'role.name.already.exists';
	else
		CALL WrapperAddRole(@v_result,p_role,p_permission,p_createdby);
	end if;

	select @v_result;

END$$
DELIMITER ;

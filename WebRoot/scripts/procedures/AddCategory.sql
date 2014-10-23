-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCategory`(in p_categoryName varchar(45),
															in p_createdBy varchar(45))
BEGIN
	DECLARE v_result varchar(50);
	DECLARE v_count int(2);

	set v_result = 'initial';
	select count(1) into v_count from category where name=p_categoryName;
	if (v_count > 0) then
		set v_result = 'category.name.already.exists';
	else 
		CALL WrapperAddCategory(@v_result, p_categoryName, p_createdBy);
	end if;
	SELECT @v_result;

END
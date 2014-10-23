DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddCategory`(out p_result varchar(50),
										in p_categoryName varchar(45),
										in p_createdBy varchar(45))
BEGIN
	
	set p_result = 'wrapperinitial';
	insert into category(name, created_date, created_by)
		values(p_categoryName, CURRENT_TIMESTAMP, p_createdBy);
	COMMIT;
	set p_result = 'success';

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `WrapperAddStocksOnHand`(in p_result varchar(50),
											in p_productId int(11),
											in p_quantity int(5),
											in p_inventoryId int(11),
											in p_createdBy varchar(45))
BEGIN
	DECLARE totalquantity int(5);
	DECLARE endingquantity int(5);
	DECLARE previousEndingQuantity int(5);
	SET p_result = 'initialwrapper';

	select ending_quantity into previousEndingQuantity from daily_on_hand_products 
		where on_hand_product_id = 1 order by created_date desc limit 1;
	
	SET totalquantity = previousEndingQuantity+p_quantity;
	SET endingquantity = totalquantity;

	insert into daily_on_hand_products(inventory_id,created_by,quantity,total_quantity,ending_quantity,on_hand_product_id)
		values(p_inventoryId,p_createdBy,p_quantity,totalquantity,endingquantity,p_productId);
	COMMIT;
	
	set p_result = 'success';
END$$
DELIMITER ;

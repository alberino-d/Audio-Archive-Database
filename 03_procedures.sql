use audio_archive;

-- STORED PROCEDURES


-- Create PlaceCustomerOrder Procedure
drop procedure if exists PlaceCustomerOrder;

delimiter //

create procedure PlaceCustomerOrder(
	in p_cart_id int
)
begin
	declare v_order_id int;
    declare v_discount_id int;
    declare v_discount_amount decimal(10,2) default 0;
    declare v_subtotal decimal(10,2);
    declare v_total_price decimal(10,2);
    declare v_user_id int;
    declare v_card_id int;
    declare v_fulfilled_location_id int;
    declare v_latitude decimal(9,6);
    declare v_longitude decimal (9,6);
	
    
	-- Rollback for Errors
    declare exit handler for sqlexception
	begin
		rollback;
        resignal;
	end;
    
    
    start transaction;
    
    
    -- Get ShoppingCart Info
    if not exists (
		select *
        from shopping_cart
        where cart_id = p_cart_id
	)
    then
		signal sqlstate '45000'
			set message_text = 'Shopping cart does not exist';
	end if;
    
    select discount_id, user_id, card_id
    into v_discount_id, v_user_id, v_card_id
    from shopping_cart
    where cart_id = p_cart_id;
    
	
    -- Verify Payment Card Exists
    if v_card_id is null then
		signal sqlstate '45000'
			set message_text = 'Shopping cart has no payment card';
	end if;
    
    if not exists (
		select *
        from card
        where card_id = v_card_id
			and user_id = v_user_id
	)
    then
		signal sqlstate '45000'
			set message_text = 'Invalid payment card';
	end if;
    
    
    -- Check Cart is not Empty
    if not exists (
		select *
        from shopping_cart_line
        where cart_id = p_cart_id
	)
    then
		signal sqlstate '45000'
			set message_text = 'Cannot checkout empty cart';
	end if;
    
    
    -- Determine Closest Warehouse w/ Sufficient Stock
    select latitude, longitude
    into v_latitude, v_longitude
    from user
    where user_id = v_user_id;
    
    
    select l.location_id
    into v_fulfilled_location_id
    from location l
    where l.location_type = 'warehouse'
		and not exists (
			select *
			from shopping_cart_line scl
			left join inventory i
				on i.product_id = scl.product_id
				and i.location_id = l.location_id
			where scl.cart_id = p_cart_id
				and (i.inventory_id is null
					or i.quantity < scl.quantity
				)
		)
	order by power(l.latitude - v_latitude, 2) + power(l.longitude - v_longitude, 2)
	limit 1;
    
    if v_fulfilled_location_id is null then
		signal sqlstate '45000'
        set message_text = 'No warehouse has sufficient inventory';
	end if;
    
    
    -- Calculate Subtotal
    select sum(scl.quantity * p.price)
    into v_subtotal
    from shopping_cart_line scl
	join product p using (product_id)
    where scl.cart_id = p_cart_id;
    
    
    -- Apply Discount
    if v_discount_id is not null then
		select coalesce (
			case
				when discount_type = 'percentage'
					then v_subtotal * (value / 100)
				else value
			end, 0
		)
        into v_discount_amount
        from discount
        where discount_id = v_discount_id
			and is_active = true
            and current_date between start_date and ifnull(end_date, current_date)
            and v_subtotal >= minimum_purchase;
	end if;
    
    set v_discount_amount = least(v_discount_amount, v_subtotal);
    
    
    -- Calculate Total
    set v_total_price = v_subtotal - v_discount_amount;
    
    
    -- Insert CustomerOrder
    insert into customer_order (
		discount_id,
        discount_amount,
        subtotal,
        total_price,
        user_id,
        card_id,
        fulfilled_location_id
	) values (
		v_discount_id,
        v_discount_amount,
        v_subtotal,
        v_total_price,
        v_user_id,
        v_card_id,
        v_fulfilled_location_id
	);
    
    set v_order_id = last_insert_id();
    
    
    -- Insert CustomerOrderLines
    insert into customer_order_line (
		customer_order_id,
        product_id,
        quantity,
        unit_price
	)
    select v_order_id, scl.product_id, scl.quantity, p.price
    from shopping_cart_line scl
    join product p using (product_id)
    where scl.cart_id = p_cart_id;
    
    
    -- Clear ShoppingCart
    delete from shopping_cart_line
    where cart_id = p_cart_id;
    
    
    commit;

end //

delimiter ;

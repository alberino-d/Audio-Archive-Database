use audio_archive;

-- TRIGGERS


-- Create CustomerOrder Inventory Decrease Trigger
drop trigger if exists co_inventory_decrease;

delimiter //

create trigger co_inventory_decrease
	after insert on customer_order_line
    for each row
begin
	update inventory i
    join customer_order co
		on co.customer_order_id = new.customer_order_id
    set i.quantity = i.quantity - new.quantity
    where i.product_id = new.product_id
		and i.location_id = co.fulfilled_location_id;
end //

delimiter ;


-- Create VendorOrder Inventory Increase Trigger
drop trigger if exists vo_inventory_increase;

delimiter //

create trigger vo_inventory_increase
	after insert on vendor_order_line
    for each row
begin
	update inventory i
    join vendor_order vo
		on vo.vendor_order_id = new.vendor_order_id
	set i.quantity = i.quantity + new.quantity
    where i.product_id = new.product_id
		and i.location_id = vo.to_location_id;
end //

delimiter ;


-- Create CustomerReturn Inventory Increase Trigger
drop trigger if exists cr_inventory_increase;

delimiter //

create trigger cr_inventory_increase
	after insert on customer_return_line
    for each row
begin
	update inventory i
    join customer_return cr
		on cr.return_id = new.return_id
	set i.quantity = i.quantity + new.quantity
    where i.product_id = new.product_id
		and i.location_id = cr.location_id;
end //

delimiter ;


-- Create InventoryTransfer Inventory Update Trigger
drop trigger if exists it_inventory_update;

delimiter //

create trigger it_inventory_update
	after insert on inventory_transfer_line
    for each row
begin
	declare v_from_location_id int;
    declare v_to_location_id int;
    
    select from_location_id, to_location_id
    into v_from_location_id, v_to_location_id
    from inventory_transfer it
    where it.inventory_transfer_id = new.inventory_transfer_id;

	update inventory
	set quantity = quantity - new.quantity
    where product_id = new.product_id
		and location_id = v_from_location_id;
	
    update inventory
	set quantity = quantity + new.quantity
    where product_id = new.product_id
		and location_id = v_to_location_id;
end //

delimiter ;


-- Create ReorderAlert Trigger
drop trigger if exists reorder_alert_check;

delimiter //

create trigger reorder_alert_check
	after update on inventory
    for each row
begin
	if old.quantity > old.reorder_level
		and new.quantity <= new.reorder_level
	then
		insert into reorder_alert (current_quantity, inventory_id) values
        (new.quantity, new.inventory_id);
	end if;
end //

delimiter ;


-- Create ShoppingCart Update last_updated Triggers
drop trigger if exists sc_last_updated_insert;

delimiter //

create trigger sc_last_updated_insert
	after insert on shopping_cart_line
	for each row
begin
	update shopping_cart
    set last_updated = current_timestamp
    where cart_id = new.cart_id;
end //

delimiter ;


drop trigger if exists sc_last_updated_update;

delimiter //

create trigger sc_last_updated_update
	after update on shopping_cart_line
	for each row
begin
	update shopping_cart
    set last_updated = current_timestamp
    where cart_id = new.cart_id;
end //

delimiter ;


drop trigger if exists sc_last_updated_delete;

delimiter //

create trigger sc_last_updated_delete
	after delete on shopping_cart_line
	for each row
begin
	update shopping_cart
    set last_updated = current_timestamp
    where cart_id = old.cart_id;
end //

delimiter ;


-- Create ShoppingCart Creation Trigger
drop trigger if exists create_shopping_cart;

delimiter //

create trigger create_shopping_cart
	after insert on user
	for each row
begin
	insert into shopping_cart (user_id) values
    (new.user_id);
end //

delimiter ;

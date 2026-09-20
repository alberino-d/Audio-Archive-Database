-- Create and Activate Database
drop database if exists audio_archive;
create database audio_archive;

use audio_archive;




-- TABLES


-- Create Medium Table
drop table if exists medium;
create table medium (
	medium_id int primary key auto_increment,
    name varchar(20) unique not null
);


-- Create Genre Table
drop table if exists genre;
create table genre (
	genre_id int primary key auto_increment,
    name varchar(20) unique not null
);


-- Create Product Table
drop table if exists product;
create table product (
	product_id int primary key auto_increment,
    title varchar(100) not null,
    release_year year not null,
    price decimal(10,2) not null
		check (price >= 0),
    condition_status enum('new', 'used') not null,
    medium_id int not null,
    constraint product_fk_medium foreign key (medium_id) references medium (medium_id)
);


-- Create Artist Table
drop table if exists artist;
create table artist (
	artist_id int primary key auto_increment,
    name varchar(100) not null,
    country varchar(50) not null,
    type enum('solo', 'band') not null
);


-- Create Creates Table
drop table if exists creates;
create table creates (
	product_id int not null,
    artist_id int not null,
    constraint records_fk_product foreign key (product_id) references product (product_id),
    constraint records_fk_artist foreign key (artist_id) references artist (artist_id),
    primary key (product_id, artist_id)
);


-- Create Classifies Table
drop table if exists classifies;
create table classifies (
	product_id int not null,
    genre_id int not null,
    constraint classifies_fk_product foreign key (product_id) references product (product_id),
    constraint classifies_fk_genre foreign key (genre_id) references genre (genre_id),
    primary key (product_id, genre_id)
);


-- Create Location Table
drop table if exists location;
create table location (
	location_id int primary key auto_increment,
    name varchar(50) not null unique,
    location_type enum('warehouse', 'store') not null,
    phone varchar(20) unique,
    street varchar(100) not null,
    city varchar(50) not null,
    state char(2),
    country varchar(50) not null,
    postal_code varchar(20) not null,
    latitude decimal(9,6) not null
		check (latitude between -90 and 90),
    longitude decimal(9,6) not null
		check (longitude between -180 and 180)
);


-- Create Inventory Table
drop table if exists inventory;
create table inventory (
	inventory_id int primary key auto_increment,
    quantity int unsigned not null,
	reorder_level int unsigned not null,
	product_id int not null,
    location_id int not null,
    constraint inventory_fk_product foreign key (product_id) references product (product_id),
    constraint inventory_fk_location foreign key (location_id) references location (location_id),
    unique(product_id, location_id)
);


-- Create Vendor Table
drop table if exists vendor;
create table vendor (
	vendor_id int primary key auto_increment,
    name varchar(50) not null,
    email varchar(100) not null unique,
    phone varchar(20) not null,
    website varchar(255) unique,
    street varchar(100) not null,
    city varchar(50) not null,
    state char(2),
    country varchar(50) not null,
    postal_code varchar(20) not null
);


-- Create VendorOrder Table
drop table if exists vendor_order;
create table vendor_order (
	vendor_order_id int primary key auto_increment,
    date timestamp not null default current_timestamp,
    total_cost decimal(10,2) not null
		check (total_cost >= 0),
    to_location_id int not null,
    vendor_id int not null,
    constraint vendororder_fk_location foreign key (to_location_id) references location (location_id),
    constraint vendororder_fk_vendor foreign key (vendor_id) references vendor (vendor_id)
);


-- Create VendorOrderLine Table
drop table if exists vendor_order_line;
create table vendor_order_line (
	vendor_order_id int not null,
    product_id int not null,
    quantity int unsigned not null,
    unit_cost decimal(10,2) not null
		check (unit_cost >= 0),
    constraint vendororderline_fk_vendororder foreign key (vendor_order_id) references vendor_order (vendor_order_id),
    constraint vendororderline_fk_product foreign key (product_id) references product (product_id),
    primary key (vendor_order_id, product_id)
);


-- Create InventoryTransfer Table
drop table if exists inventory_transfer;
create table inventory_transfer (
	inventory_transfer_id int primary key auto_increment,
    date timestamp not null default current_timestamp,
    notes varchar(255),
    from_location_id int not null,
    to_location_id int not null,
    constraint inventorytransfer_fk_location1 foreign key (from_location_id) references location (location_id),
    constraint inventorytransfer_fk_location2 foreign key (to_location_id) references location (location_id)
);


-- Create InventoryTransferLine Table
drop table if exists inventory_transfer_line;
create table inventory_transfer_line (
	inventory_transfer_id int not null,
    product_id int not null,
    quantity int unsigned not null,
	constraint inventorytransferline_fk_inventorytransfer foreign key (inventory_transfer_id) references inventory_transfer (inventory_transfer_id),
    constraint inventorytransferline_fk_product foreign key (product_id) references product (product_id),
    primary key (inventory_transfer_id, product_id)
);


-- Create User Table
drop table if exists user;
create table user (
	user_id int primary key auto_increment,
    lastname varchar(50) not null,
    firstname varchar(50) not null,
    register_date timestamp not null default current_timestamp,
    email varchar(100) not null unique,
    phone varchar(20) unique,
    street varchar(100),
    city varchar(50),
    state char(2),
    country varchar(50),
    postal_code varchar(20),
    latitude decimal(9,6)
		check (latitude between -90 and 90),
    longitude decimal(9,6)
		check (longitude between -180 and 180)
);


-- Create Card Table
drop table if exists card;
create table card (
	card_id int primary key auto_increment,
    card_token varchar(16) not null unique,
    last4digits char(4) not null
		check (last4digits regexp '^[0-9]{4}$'),
    card_type enum('Visa', 'Mastercard', 'American Express', 'Discover') not null,
    exp_month int not null
		check (exp_month between 1 and 12),
    exp_year int not null,
    user_id int not null,
    constraint card_fk_user foreign key (user_id) references user (user_id),
    unique (card_id, user_id)
);


-- Create Discount Table
drop table if exists discount;
create table discount (
	discount_id int primary key auto_increment,
    code varchar(30) not null unique,
    name varchar(100) not null unique,
    discount_type enum('percentage', 'fixed amount') not null,
    value decimal(10,2) not null
		check (value >= 0),
	start_date date not null,
    end_date date,
    minimum_purchase decimal(10,2) not null default 0
		check (minimum_purchase >= 0),
	is_active boolean default true
);


-- Create ShoppingCart Table
drop table if exists shopping_cart;
create table shopping_cart (
	cart_id int primary key auto_increment,
    created_date timestamp not null default current_timestamp,
    last_updated timestamp not null default current_timestamp
		on update current_timestamp,
	discount_id int,
	user_id int unique not null,
    card_id int,
    constraint shoppingcart_fk_discount foreign key (discount_id) references discount (discount_id),
    constraint shoppingcart_fk_user foreign key (user_id) references user (user_id),
    constraint shoppingcart_fk_card foreign key (card_id) references card (card_id)
);


-- Create ShoppingCartLine Table
drop table if exists shopping_cart_line;
create table shopping_cart_line (
	cart_id int not null,
    product_id int not null,
    quantity int unsigned not null,
    constraint shoppingcartline_fk_shoppingcart foreign key (cart_id) references shopping_cart (cart_id),
    constraint shoppingcartline_fk_product foreign key (product_id) references product (product_id),
    primary key (cart_id, product_id)
);


-- Create CustomerOrder Table
drop table if exists customer_order;
create table customer_order (
	customer_order_id int primary key auto_increment,
    date timestamp not null default current_timestamp,
    discount_id int,
    discount_amount decimal(10,2) not null
		check (discount_amount >= 0),
    subtotal decimal(10,2) not null
		check (subtotal >= 0),
    total_price decimal(10,2) not null
		check (total_price >= 0),
    user_id int,
    card_id int not null,
    fulfilled_location_id int not null,
    constraint customerorder_fk_discount foreign key (discount_id) references discount (discount_id),
    constraint customerorder_fk_user foreign key (user_id) references user (user_id),
    constraint customerorder_fk_card_user foreign key (card_id, user_id) references card (card_id, user_id),
    constraint customerorder_fk_location foreign key (fulfilled_location_id) references location (location_id)
);


-- Create CustomerOrderLine Table
drop table if exists customer_order_line;
create table customer_order_line (
	customer_order_id int not null,
    product_id int not null,
    quantity int unsigned not null,
    unit_price decimal(10,2) not null
		check (unit_price >= 0),
    constraint customerorderline_fk_customerorder foreign key (customer_order_id) references customer_order (customer_order_id),
    constraint customerorderline_fk_product foreign key (product_id) references product (product_id),
    primary key (customer_order_id, product_id)
);


-- Create CustomerReturn Table
drop table if exists customer_return;
create table customer_return (
	return_id int primary key auto_increment,
    date timestamp not null default current_timestamp,
    total_refund decimal(10,2) not null
		check (total_refund >= 0),
	location_id int not null,
    constraint customerreturn_fk_location foreign key (location_id) references location (location_id)
);


-- Create CustomerReturnLine Table
drop table if exists customer_return_line;
create table customer_return_line (
	return_id int not null,
    customer_order_id int not null,
    product_id int not null,
    quantity int unsigned not null,
    refund_amount decimal(10,2) not null
		check (refund_amount >= 0),
	reason varchar(255) not null,
    constraint customerreturnline_fk_customerreturn foreign key (return_id) references customer_return (return_id),
    constraint customerreturnline_fk_customerorderline foreign key (customer_order_id, product_id) references customer_order_line (customer_order_id, product_id),
    primary key (return_id, customer_order_id, product_id)
);


-- Create ReorderAlert Table
drop table if exists reorder_alert;
create table reorder_alert (
	alert_id int primary key auto_increment,
    date timestamp not null default current_timestamp,
    current_quantity int unsigned not null,
    inventory_id int not null,
    constraint reorderalert_fk_inventory foreign key (inventory_id) references inventory (inventory_id)
);




-- INDEXES
create index idx_inventory_product_location
	on inventory(product_id, location_id);


create index idx_inventory_location
	on inventory(location_id);


create index idx_cartline_cart
	on shopping_cart_line(cart_id);


create index idx_customerorder_user
	on customer_order(user_id);


create index idx_vendororder_vendor
	on vendor_order(vendor_id);


create index idx_vendororder_location
	on vendor_order(to_location_id);


create index idx_inventorytransfer_from
	on inventory_transfer(from_location_id);


create index idx_inventorytransfer_to
	on inventory_transfer(to_location_id);

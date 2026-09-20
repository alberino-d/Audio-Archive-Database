use audio_archive;


-- Insert Medium Table
INSERT INTO medium (name) VALUES
('Vinyl'),
('CD'),
('Cassette');


-- Insert Genre Table
INSERT INTO genre (name) VALUES
('Rock'),
('Pop'),
('Hip-Hop'),
('Jazz'),
('Country'),
('Metal'),
('Classical'),
('Electronic'),
('R&B'),
('Folk');


-- Insert Artist Table
INSERT INTO artist (name, country, type) VALUES
('The Beatles', 'United Kingdom', 'band'),
('Taylor Swift', 'United States', 'solo'),
('Michael Jackson', 'United States', 'solo'),
('Pink Floyd', 'United Kingdom', 'band'),
('Fleetwood Mac', 'United Kingdom', 'band'),
('Queen', 'United Kingdom', 'band'),
('Kendrick Lamar', 'United States', 'solo'),
('Miles Davis', 'United States', 'solo'),
('Metallica', 'United States', 'band'),
('Daft Punk', 'France', 'band'),
('Adele', 'United Kingdom', 'solo'),
('Luke Combs', 'United States', 'solo');


-- Insert Product Table
INSERT INTO product
(title, release_year, price, condition_status, medium_id)
VALUES
('Abbey Road', 1969, 29.99, 'new', 1),
('1989 (Taylor''s Version)', 2023, 34.99, 'new', 1),
('Thriller', 1982, 18.99, 'new', 2),
('The Dark Side of the Moon', 1973, 31.99, 'new', 1),
('Rumours', 1977, 27.99, 'used', 1),
('A Night at the Opera', 1975, 19.99, 'new', 2),
('good kid, m.A.A.d city', 2012, 16.99, 'new', 2),
('Kind of Blue', 1959, 24.99, 'new', 1),
('Master of Puppets', 1986, 32.99, 'new', 1),
('Random Access Memories', 2013, 17.99, 'new', 2),
('25', 2015, 15.99, 'new', 2),
('Gettin'' Old', 2023, 28.99, 'new', 1);


-- Insert Creates Table
INSERT INTO creates VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12);


-- Insert Classifies Values
INSERT INTO classifies VALUES
(1,1),
(1,2),
(2,2),
(3,2),
(3,9),
(4,1),
(5,1),
(6,1),
(7,3),
(8,4),
(9,6),
(10,8),
(11,2),
(11,9),
(12,5);


-- Insert Location Table
INSERT INTO location
(name, location_type, phone, street, city, state, country, postal_code, latitude, longitude)
VALUES
('Northeast Distribution Center',
'warehouse',
'2035551001',
'120 Commerce Way',
'New Haven',
'CT',
'United States',
'06511',
41.308300,
-72.927900),

('Midwest Distribution Center',
'warehouse',
'3125551002',
'455 Industrial Pkwy',
'Chicago',
'IL',
'United States',
'60607',
41.878100,
-87.629800),

('West Coast Distribution Center',
'warehouse',
'2135551003',
'980 Warehouse Blvd',
'Los Angeles',
'CA',
'United States',
'90021',
34.052200,
-118.243700),

('New Haven Store',
'store',
'2035552001',
'50 Chapel Street',
'New Haven',
'CT',
'United States',
'06510',
41.308800,
-72.927000),

('Chicago Store',
'store',
'3125552002',
'900 State Street',
'Chicago',
'IL',
'United States',
'60605',
41.878600,
-87.624400),

('Los Angeles Store',
'store',
'2135552003',
'800 Sunset Blvd',
'Los Angeles',
'CA',
'United States',
'90026',
34.098300,
-118.329500);


-- Insert Inventory Table
INSERT INTO inventory
(quantity, reorder_level, product_id, location_id)
VALUES

-- Warehouse 1
(40,10,1,1),
(35,10,2,1),
(30,8,3,1),
(22,8,4,1),
(18,5,5,1),
(28,8,6,1),
(45,10,7,1),
(20,5,8,1),
(25,6,9,1),
(30,8,10,1),
(38,10,11,1),
(24,6,12,1),

-- Warehouse 2
(30,8,1,2),
(26,8,2,2),
(18,5,3,2),
(20,5,4,2),
(15,5,5,2),
(18,5,6,2),
(32,8,7,2),
(14,4,8,2),
(16,5,9,2),
(20,5,10,2),
(25,6,11,2),
(18,5,12,2),

-- Warehouse 3
(22,6,1,3),
(20,6,2,3),
(15,4,3,3),
(18,5,4,3),
(10,4,5,3),
(16,5,6,3),
(20,6,7,3),
(12,4,8,3),
(14,4,9,3),
(18,5,10,3),
(18,5,11,3),
(15,4,12,3),

-- New Haven Store
(6,2,1,4),
(4,2,2,4),
(8,2,3,4),
(5,2,4,4),
(3,1,5,4),
(5,2,6,4),
(6,2,7,4),
(3,1,8,4),
(4,2,9,4),
(5,2,10,4),
(6,2,11,4),
(4,2,12,4),

-- Chicago Store
(5,2,1,5),
(6,2,2,5),
(5,2,3,5),
(4,2,4,5),
(2,1,5,5),
(4,2,6,5),
(7,2,7,5),
(2,1,8,5),
(3,2,9,5),
(4,2,10,5),
(5,2,11,5),
(3,2,12,5),

-- Los Angeles Store
(7,2,1,6),
(5,2,2,6),
(6,2,3,6),
(5,2,4,6),
(3,1,5,6),
(4,2,6,6),
(8,2,7,6),
(3,1,8,6),
(4,2,9,6),
(5,2,10,6),
(6,2,11,6),
(4,2,12,6);


-- Insert Vendor Table
INSERT INTO vendor
(name, email, phone, website, street, city, state, country, postal_code)
VALUES
('Universal Music Distribution',
 'sales@universalmusic.com',
 '310-555-1001',
 'https://www.umusic.com',
 '2220 Colorado Ave',
 'Santa Monica',
 'CA',
 'United States',
 '90404'),

('Sony Music Entertainment',
 'orders@sonymusic.com',
 '212-555-1002',
 'https://www.sonymusic.com',
 '25 Madison Ave',
 'New York',
 'NY',
 'United States',
 '10010'),

('Warner Music Group',
 'purchasing@wmg.com',
 '212-555-1003',
 'https://www.wmg.com',
 '1633 Broadway',
 'New York',
 'NY',
 'United States',
 '10019'),

('Alliance Entertainment',
 'sales@aent.com',
 '954-555-1004',
 'https://www.aent.com',
 '8201 Peters Rd',
 'Plantation',
 'FL',
 'United States',
 '33324');
 
 
 -- Insert VendorOrder Table
INSERT INTO vendor_order
(date, total_cost, to_location_id, vendor_id)
VALUES
('2026-01-10 09:30:00', 1275.00, 1, 1),
('2026-02-08 11:15:00', 980.00, 2, 2),
('2026-03-14 14:45:00', 1460.00, 3, 3),
('2026-04-18 10:20:00', 735.00, 1, 4),
('2026-05-12 13:10:00', 860.00, 2, 1);


-- Insert VendorOrderLine Table
INSERT INTO vendor_order_line
(vendor_order_id, product_id, quantity, unit_cost)
VALUES

-- Order 1
(1,1,20,18.00),
(1,4,15,19.00),
(1,8,10,15.00),
(1,11,25,11.00),

-- Order 2
(2,2,20,22.00),
(2,6,15,12.00),
(2,7,30,10.00),
(2,12,10,18.00),

-- Order 3
(3,3,25,11.00),
(3,5,15,16.00),
(3,9,20,21.00),
(3,10,30,14.00),

-- Order 4
(4,1,10,18.00),
(4,5,15,16.00),
(4,8,10,15.00),

-- Order 5
(5,2,15,22.00),
(5,7,20,10.00),
(5,11,30,11.00);


-- Insert InventoryTransfer Table
INSERT INTO inventory_transfer
(date, notes, from_location_id, to_location_id)
VALUES
('2026-06-01 09:00:00',
 'Weekly restock for New Haven store.',
 1,4),

('2026-06-03 10:30:00',
 'Restock Chicago retail location.',
 2,5),

('2026-06-05 13:15:00',
 'Restock Los Angeles store.',
 3,6),

('2026-06-08 08:45:00',
 'Transfer excess jazz inventory.',
 1,2),

('2026-06-10 15:20:00',
 'Move metal albums to West warehouse.',
 2,3);
 
 
 -- Insert InventoryTransferLine Table
 INSERT INTO inventory_transfer_line
(inventory_transfer_id, product_id, quantity)
VALUES

-- Warehouse 1 -> New Haven Store
(1,1,4),
(1,2,3),
(1,11,5),

-- Warehouse 2 -> Chicago Store
(2,7,6),
(2,6,3),
(2,12,4),

-- Warehouse 3 -> Los Angeles Store
(3,3,5),
(3,9,4),
(3,10,6),

-- Warehouse 1 -> Warehouse 2
(4,8,5),
(4,4,4),

-- Warehouse 2 -> Warehouse 3
(5,9,5),
(5,5,3);


-- Insert User Table
INSERT INTO user
(lastname, firstname, email, phone,
 street, city, state, country, postal_code,
 latitude, longitude)
VALUES
('Smith','John','john.smith@email.com','203-555-1001',
 '12 Oak Street','New Haven','CT','United States','06511',
 41.3083,-72.9279),

('Johnson','Emily','emily.johnson@email.com','312-555-1002',
 '455 Maple Ave','Chicago','IL','United States','60605',
 41.8781,-87.6298),

('Brown','Michael','michael.brown@email.com','213-555-1003',
 '910 Sunset Blvd','Los Angeles','CA','United States','90026',
 34.0522,-118.2437),

('Davis','Sarah','sarah.davis@email.com','617-555-1004',
 '88 Beacon Street','Boston','MA','United States','02108',
 42.3601,-71.0589),

('Wilson','David','david.wilson@email.com','615-555-1005',
 '721 Broadway','Nashville','TN','United States','37203',
 36.1627,-86.7816),

('Martinez','Sophia','sophia.martinez@email.com','305-555-1006',
 '440 Ocean Drive','Miami','FL','United States','33139',
 25.7617,-80.1918),

('Anderson','James','james.anderson@email.com','206-555-1007',
 '318 Pine Street','Seattle','WA','United States','98101',
 47.6062,-122.3321),

('Thomas','Olivia','olivia.thomas@email.com','303-555-1008',
 '700 Colfax Ave','Denver','CO','United States','80203',
 39.7392,-104.9903);
 
 
 -- Insert Card Table
INSERT INTO card
(card_token, last4digits, card_type, exp_month, exp_year, user_id)
VALUES
('A1B2C3D4E5F6G7H8','4821','Visa',5,2029,1),
('B2C3D4E5F6G7H8I9','1394','Mastercard',11,2028,2),
('C3D4E5F6G7H8I9J0','6648','Visa',3,2030,3),
('D4E5F6G7H8I9J0K1','2197','American Express',8,2027,4),
('E5F6G7H8I9J0K1L2','7813','Discover',12,2029,5),
('F6G7H8I9J0K1L2M3','4305','Visa',6,2028,6),
('G7H8I9J0K1L2M3N4','9052','Mastercard',10,2031,7),
('H8I9J0K1L2M3N4O5','1178','Visa',2,2030,8),
('J9K0L1M2N3O4P5Q6','5524','Visa',9,2030,1),
('K0L1M2N3O4P5Q6R7','8641','Mastercard',4,2029,3),
('L1M2N3O4P5Q6R7S8','3409','Discover',7,2030,6);


-- Insert Discount Table
INSERT INTO discount
(code, name, discount_type, value,
 start_date, end_date,
 minimum_purchase, is_active)
VALUES

('WELCOME10',
 '10% Welcome Discount',
 'percentage',
 10.00,
 '2026-01-01',
 NULL,
 25.00,
 TRUE),

('SAVE20',
 '$20 Off Orders Over $100',
 'fixed amount',
 20.00,
 '2026-01-01',
 NULL,
 100.00,
 TRUE),

('VINYL15',
 '15% Off Vinyl Records',
 'percentage',
 15.00,
 '2026-03-01',
 '2026-12-31',
 40.00,
 TRUE),

('SUMMER5',
 '$5 Summer Coupon',
 'fixed amount',
 5.00,
 '2026-06-01',
 '2026-08-31',
 20.00,
 TRUE),

('EXPIRED25',
 'Expired Promotion',
 'percentage',
 25.00,
 '2025-01-01',
 '2025-12-31',
 50.00,
 FALSE);
 
 
-- Insert ShoppingCart Table
INSERT INTO shopping_cart
(user_id, card_id, discount_id)
VALUES
(1, 1, 1),
(2, 2, NULL),
(3, 3, NULL),
(4, 4, NULL),
(5, 5, NULL),
(6, 6, 2),
(7, 7, NULL),
(8, 8, NULL);


-- Insert ShoppingCartLine Table
INSERT INTO shopping_cart_line
(cart_id, product_id, quantity)
VALUES

-- John
(1,2,1),
(1,8,1),

-- Emily
(2,7,2),

-- Michael
(3,1,1),
(3,9,1),
(3,10,1),

-- Sarah
(4,11,2),

-- David
(5,12,1),

-- Sophia
(6,3,1),
(6,6,1),

-- James
(7,4,1);


-- Insert CustomerOrder Table
INSERT INTO customer_order
(date, discount_id, discount_amount, subtotal,
 total_price, user_id, card_id, fulfilled_location_id)
VALUES

('2026-06-15 14:22:00',1,5.00,49.98,44.98,1,1,1),

('2026-06-17 11:05:00',NULL,0.00,33.98,33.98,2,2,2),

('2026-06-20 18:40:00',NULL,0.00,80.97,80.97,3,3,3),

('2026-06-25 13:10:00',NULL,0.00,31.98,31.98,4,4,1),

('2026-06-28 16:30:00',NULL,0.00,28.99,28.99,5,5,2),

('2026-07-01 09:45:00',2,20.00,35.98,15.98,6,6,1),

('2026-07-03 15:50:00',NULL,0.00,31.99,31.99,7,7,3);


-- Insert CustomerOrderLine Table
INSERT INTO customer_order_line
(customer_order_id, product_id, quantity, unit_price)
VALUES

-- Order 1
(1,2,1,34.99),
(1,8,1,24.99),

-- Order 2
(2,7,2,16.99),

-- Order 3
(3,1,1,29.99),
(3,9,1,32.99),
(3,10,1,17.99),

-- Order 4
(4,11,2,15.99),

-- Order 5
(5,12,1,28.99),

-- Order 6
(6,3,1,18.99),
(6,6,1,19.99),

-- Order 7
(7,4,1,31.99);


-- Insert CustomerReturn Table
INSERT INTO customer_return
(date,total_refund,location_id)
VALUES

('2026-07-10 10:15:00',24.99,1),

('2026-07-12 15:40:00',31.98,1),

('2026-07-15 13:20:00',16.99,2);


-- Insert CustomerReturnLine Table
INSERT INTO customer_return_line
(return_id,customer_order_id,product_id,
 quantity,refund_amount,reason)
VALUES

-- John returned Kind of Blue
(1,1,8,1,24.99,
'Customer changed mind'),

-- Sarah returned both copies of 25
(2,4,11,2,31.98,
'Received damaged packaging'),

-- Emily returned one copy of Kendrick Lamar CD
(3,2,7,1,16.99,
'Ordered by mistake');


-- Insert ReorderAlert Table
INSERT INTO reorder_alert
(date,current_quantity,inventory_id)
VALUES

('2026-07-08 09:10:00',
2,
29),

('2026-07-16 14:25:00',
1,
53);

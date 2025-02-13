INSERT INTO `Culdampolla`.`suppliers` (`suppliers_name`, `suppliers_address`, `suppliers_phone`, `suppliers_fax`, `suppliers_taxId`)
VALUES
('OpticVision Ltd.', '123 Main St, New York', '1234567890', '1234567891', 'TX123456'),
('EyeCare Supplies', '456 Elm St, Chicago', '9876543210', '9876543211', 'TX987654'),
('Glasses Wholesale Inc.', '789 Oak St, Los Angeles', '1122334455', '1122334456', 'TX112233'),
('Premium Optics', '321 Maple St, Houston', '6677889900', '6677889901', 'TX667788'),
('ClearSight Co.', '654 Pine St, Miami', '4455667788', '4455667789', 'TX445566');

INSERT INTO `Culdampolla`.`customers` (`customers_name`, `customers_address`, `customers_phone`, `customers_email`, `customers_referral`, `customers_salesRep`)
VALUES
('John Doe', '742 Evergreen Terrace, Springfield', '1231231234', 'johndoe@example.com', 'Google Ads', 'Alice Johnson'),
('Jane Smith', '123 Baker St, London', '9879879876', 'janesmith@example.com', 'Friend', 'Bob Williams'),
('Michael Brown', '456 Cherry Lane, Seattle', '5555555555', 'michaelbrown@example.com', 'Social Media', 'Charlie Davis'),
('Emily White', '789 Oakwood Dr, Denver', '4444444444', 'emilywhite@example.com', 'Website', 'David Harris'),
('Robert Green', '321 Maple St, Austin', '3333333333', 'robertgreen@example.com', 'Flyer', 'Emma Martinez');
INSERT INTO `Culdampolla`.`glasses` (`glasses_prescription`, `glasses_frameType`, `glasses_frameColor`, `glasses_glassColor`, `glasses_price`, `suppliers_suppliers_id`)
VALUES
(1.5, 'metallic', 'black', 'blue', 150.00, 1),
(2.0, 'acetate', 'brown', 'green', 180.00, 1),
(-1.75, 'floating', 'gold', 'gray', 220.00, 2),
(3.25, 'metallic', 'silver', 'brown', 200.00, 2),
(-0.5, 'acetate', 'red', 'black', 170.00, 3),
(2.75, 'floating', 'blue', 'yellow', 190.00, 3),
(-3.0, 'metallic', 'black', 'green', 210.00, 4),
(1.25, 'acetate', 'tortoise', 'blue', 160.00, 4),
(-2.5, 'floating', 'gray', 'red', 230.00, 5),
(0.75, 'metallic', 'gold', 'gray', 195.00, 5);
INSERT INTO `Culdampolla`.`orders` 
(`orders_created`, `orders_total_price`, `orders_status`, `orders_type`, `customers_customers_id`, `suppliers_suppliers_id`, `orders_salesperson`)
VALUES
-- Sales orders (ventas a clientes)
('2024-01-15', 120.50, 'pending', 'sale', 1, NULL, 'Mark'),
('2024-02-03', 75.00, 'processing', 'sale', 2, NULL, 'Roy'),
('2024-03-20', 210.99, 'shipped', 'sale', 3, NULL, 'Mary'),
('2024-04-10', 89.50, 'delivered', 'sale', 4, NULL, 'Lilly'),
('2024-05-05', 150.75, 'cancelled', 'sale', 5, NULL, 'Mark'),

-- Purchase orders (compras a proveedores)
('2024-06-18', 500.00, 'pending', 'purchase', NULL, 1),
('2024-07-21', 320.25, 'processing', 'purchase', NULL, 2),
('2024-08-05', 890.75, 'shipped', 'purchase', NULL, 3),
('2024-09-12', 450.90, 'delivered', 'purchase', NULL, 4),
('2024-10-28', 700.00, 'cancelled', 'purchase', NULL, 5);
INSERT INTO `Culdampolla`.`order_items` 
(`orders_orders_id`, `glasses_glasses_id`, `order_items_quantity`, `order_items_unit_price`)
VALUES
(1, 1, 2, 60.25),  
(1, 2, 1, 120.50),
(2, 3, 3, 25.00), 
(3, 4, 1, 210.99), 
(4, 5, 2, 44.75),  
(6, 6, 10, 50.00), 
(7, 7, 5, 64.05),  
(8, 8, 20, 44.50),  
(9, 9, 8, 56.30),   
(10, 10, 12, 58.33); 


SELECT SUM(Pizzeria.order_items.order_quantity) AS total_drinks_sold
FROM Pizzeria.order_items
JOIN Pizzeria.products ON Pizzeria.order_items.products_products_id = Pizzeria.products.products_id
JOIN Pizzeria.orders ON Pizzeria.order_items.orders_orders_id = Pizzeria.orders.orders_id
JOIN Pizzeria.employees ON Pizzeria.orders.orders_employees_id = Pizzeria.employees.employees_id
JOIN Pizzeria.stores ON Pizzeria.employees.stores_stores_id = Pizzeria.stores.stores_id
JOIN Pizzeria.cities ON Pizzeria.stores.cities_cities_id = Pizzeria.cities.cities_id
WHERE Pizzeria.products.products_type = 'drink'
AND Pizzeria.cities.cities_name = 'Madrid';


SELECT SUM(Pizzeria.order_items.order_quantity) AS total_orders_sold
FROM Pizzeria.order_items
JOIN Pizzeria.orders ON Pizzeria.order_items.orders_orders_id = Pizzeria.orders.orders_id
JOIN Pizzeria.employees ON Pizzeria.orders.orders_employees_id = Pizzeria.employees.employees_id
WHERE Pizzeria.employees.employees_name = 'Maria';

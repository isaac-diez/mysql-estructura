SELECT SUM(Pizzeria.order_items.order_quantity) AS total_orders_sold
FROM Pizzeria.order_items
JOIN Pizzeria.orders ON Pizzeria.order_items.orders_orders_id = Pizzeria.orders.orders_id
JOIN Pizzeria.employees ON Pizzeria.orders.orders_employees_id = Pizzeria.employees.employees_id
WHERE Pizzeria.employees.employees_name = 'Maria';


# Pizzeria Management System

## Description

This project is designed to manage the customers, orders, products, and employees of a pizzeria that offers online food ordering and delivery services.

## Requirements

The system needs to store and manage the following information:

### Cities
For each city, the following details should be recorded:
- City name
- Province ID

### Customers
The system should store the following information about customers:
- First name
- Last name
- Address
- Postal code
- City
- Province
- Phone number

The data for cities and provinces should be stored in separate tables. A city belongs to a single province, and a province can have many cities. Each city should have a unique identifier and name. Each province should have a unique identifier and name.

### Orders
The system should store the following information about orders:
- Order creation date and time
- Whether the order is for home delivery or store pickup
- Quantity of each type of product selected
- Total price
- Employee ID
- Customer ID

An order can consist of one or more products. A person can place many orders, but each order can only be placed by a single person. 

### Products
The system should store the following information about products:
- Product name
- Description
- Image
- Price
- Product type (pizza, burger, drink)

### Categories
For each category, the following details should be recorded:
- Category name
- Creation date
- Modification date

Pizzas can belong to different categories, and a category can have many pizzas.

### Stores
For each store, the following details should be recorded:
- Address
- Postal code
- City
- Province

An order is managed by a single store, and a store can manage many orders.

### Employees
The system should store the following information about employees:
- First name
- Last name
- NIF
- Phone number
- Position (cook or delivery person)
- Store ID

Many employees can work in a store, and an employee can only work in one store. For home delivery orders, it is necessary to store the delivery person who made the delivery and the date/time of the delivery.

## Database Schema and Queries

### Schema

1. **Cities Table**

    ```sql
      `cities_id` INT(11) NOT NULL AUTO_INCREMENT,
      `cities_name` VARCHAR(60) NOT NULL,
      `provinces_provinces_id` INT(11) NOT NULL,
      PRIMARY KEY (`cities_id`),
      FOREIGN KEY (`provinces_provinces_id`)
    ```

2. **Customers Table**

    ```sql
      `customers_id` INT(11) NOT NULL AUTO_INCREMENT,
      `customers_name` VARCHAR(45) NOT NULL,
      `customers_lastName` VARCHAR(45) NOT NULL,
      `customers_address` VARCHAR(60) NULL DEFAULT NULL,
      `customers_phone` VARCHAR(15) NOT NULL,
      `customers_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `customers_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `cities_cities_id` INT(11) NOT NULL,
      PRIMARY KEY (`customers_id`),
        FOREIGN KEY (`cities_cities_id`)
    ```

3. **Provinces Table**

    ```sql
      `provinces_id` INT(11) NOT NULL AUTO_INCREMENT,
      `provinces_name` VARCHAR(45) NOT NULL,
      PRIMARY KEY (`provinces_id`))
    ```

4. **Orders Table**

    ```sql
      `orders_id` INT(11) NOT NULL AUTO_INCREMENT,
      `orders_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `orders_type` VARCHAR(8) NOT NULL,
      `orders_productQty` INT(11) NOT NULL,
      `orders_price` DECIMAL(10,2) NOT NULL,
      `orders_timeOfDelivery` VARCHAR(45) NULL DEFAULT NULL,
      `orders_employees_id` INT(11) NOT NULL,
      `orders_customers_id` INT(11) NOT NULL,
      PRIMARY KEY (`orders_id`),
         FOREIGN KEY (`orders_employees_id`)
        FOREIGN KEY (`orders_customers_id`)
   ```

5. **Products Table**

    ```sql
      `products_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '\n',
      `products_name` VARCHAR(45) NOT NULL,
      `products_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `products_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `products_image` VARCHAR(255) NULL DEFAULT NULL COMMENT '\n',
      `products_description` VARCHAR(255) NULL DEFAULT NULL,
      `products_price` DECIMAL(10,2) NOT NULL,
      `products_type` ENUM('pizza', 'burger', 'drink') NOT NULL,
      `category_category_id` INT(11) NULL DEFAULT NULL,
      PRIMARY KEY (`products_id`),
        FOREIGN KEY (`category_category_id`)
    ```

6. **Categories Table**

    ```sql
      `categories_id` INT(11) NOT NULL AUTO_INCREMENT,
      `categories_name` VARCHAR(45) NOT NULL,
      `categories_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
      `categories_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`categories_id`))
  ```

7. **Stores Table**

    ```sql
      `stores_id` INT(11) NOT NULL AUTO_INCREMENT,
      `stores_address` VARCHAR(60) NOT NULL,
      `stores_zipcode` VARCHAR(5) NOT NULL,
      `stores_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `stores_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `cities_cities_id` INT(11) NOT NULL,
      PRIMARY KEY (`stores_id`),
        FOREIGN KEY (`cities_cities_id`)
        REFERENCES `Pizzeria`.`cities` (`cities_id`)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;
    ```

8. **Employees Table**

    ```sql
      `employees_id` INT(11) NOT NULL AUTO_INCREMENT,
      `employees_name` VARCHAR(45) NOT NULL,
      `employees_lastName` VARCHAR(45) NOT NULL,
      `employees_idDocument` VARCHAR(10) NOT NULL,
      `employees_phone` VARCHAR(25) NOT NULL,
      `employees_position` VARCHAR(45) NOT NULL,
      `employees_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `employees_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `stores_stores_id` INT(11) NOT NULL,
      PRIMARY KEY (`employees_id`),
        FOREIGN KEY (`stores_stores_id`)
    ```

9. **Order Items Table**

    ```sql
     `order_items_id` INT(11) NOT NULL AUTO_INCREMENT,
      `orders_orders_id` INT(11) NOT NULL,
      `products_products_id` INT(11) NOT NULL,
      `order_quantity` INT(11) NOT NULL DEFAULT 1,
      PRIMARY KEY (`order_items_id`),
        FOREIGN KEY (`orders_orders_id`)
        FOREIGN KEY (`products_products_id`)
    ```

## Instructions

1. Clone the repository:
    ```bash
    git clone https://github.com/isaac-diez/mysql-estructura.git
    ```

2. Navigate to the project directory:
    ```bash
    cd Pizzeria
	```

3. Set up the database using the provided schema.

4. Run the application and enjoy managing your pizzeria!

## Contributors

- Isaac Díez (isaac-diez)

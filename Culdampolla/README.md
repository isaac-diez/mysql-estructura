# Optics Management System - "Cul d'Ampolla"

## Description

The "Cul d'Ampolla" optics wants to digitize the management of customers and sales of glasses.

## Requirements

The system needs to store and manage the following information:

### Suppliers
For each supplier, the following details should be recorded:
- Name
- Address (street, number, floor, door, city, postal code, and country)
- Phone
- Fax
- VAT Number (NIF)

### Glasses
The purchasing policy of the optics is that glasses of a brand will be purchased from a single supplier, but multiple brands can be bought from one supplier. The following information about the glasses should be stored:
- Brand
- Lens prescription (for each lens)
- Frame type (floating, plastic, or metal)
- Frame color
- Lens color (for each lens)
- Price

### Customers
The system should store the following information about customers:
- Name
- Postal address
- Phone
- Email
- Registration date
- Referred by another customer (if applicable)

### Sales
The system should indicate which employee sold each pair of glasses.

## Database Queries

1. **Glasses Table**
```sql
      `glasses_id` INT(11) NOT NULL AUTO_INCREMENT,
      `glasses_prescription` FLOAT(11) NOT NULL,
      `glasses_frameType` ENUM('metallic', 'acetate', 'floating') NOT NULL,
      `glasses_frameColor` VARCHAR(45) NOT NULL,
      `glasses_glassColor` VARCHAR(45) NOT NULL,
      `glasses_price` FLOAT(11) NOT NULL,
      `glasses_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      `glasses_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
      `suppliers_suppliers_id` INT(11) NOT NULL,
      PRIMARY KEY (`glasses_id`, `suppliers_suppliers_id`))

    ```

3. **Suppliers Table**

    ```sql
      `suppliers_id` INT(11) NOT NULL AUTO_INCREMENT,
      `suppliers_name` VARCHAR(45) NOT NULL,
      `suppliers_address` VARCHAR(60) NOT NULL,
      `suppliers_phone` VARCHAR(15) NOT NULL,
      `suppliers_fax` VARCHAR(15) NOT NULL,
      `suppliers_taxId` VARCHAR(10) NOT NULL,
      `suppliers_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
      `suppliers_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`suppliers_id`))
    ```

4. **Customers Table**

    ```sql
      `customers_id` INT(11) NOT NULL AUTO_INCREMENT,
      `customers_name` VARCHAR(45) NOT NULL,
      `customers_address` VARCHAR(60) NULL DEFAULT NULL,
      `customers_phone` VARCHAR(15) NOT NULL,
      `customers_email` VARCHAR(255) NOT NULL,
      `customers_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `customers_referral` VARCHAR(45) NULL DEFAULT NULL,
      `customers_salesRep` VARCHAR(45) NOT NULL,
      `customers_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      PRIMARY KEY (`customers_id`),
    ```

5. **Orders Table**

    ```sql
      `orders_id` INT(11) NOT NULL AUTO_INCREMENT,
      `orders_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `orders_total_price` DECIMAL(10,2) NOT NULL,
      `orders_status` ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL,
      `orders_type` ENUM('purchase', 'sale') NOT NULL,
      `customers_customers_id` INT(11) NULL DEFAULT NULL,
      `suppliers_suppliers_id` INT(11) NULL DEFAULT NULL,
      `orders_salesperson` ENUM('Mark', 'Mary', 'Roy', 'Lilly') NULL DEFAULT NULL,
      PRIMARY KEY (`orders_id`),
        FOREIGN KEY (`customers_customers_id`)
        FOREIGN KEY (`suppliers_suppliers_id`)
    ```

6. **Order Items Table**

    ```sql
      `order_items_id` INT(11) NOT NULL AUTO_INCREMENT,
      `order_items_quantity` INT(11) NOT NULL,
      `order_items_unit_price` DECIMAL(10,2) NOT NULL,
      `order_items_subtotal` DECIMAL(10,2) GENERATED ALWAYS AS (`order_items_quantity` * `order_items_unit_price`) STORED,
      `orders_orders_id` INT(11) NOT NULL,
      `glasses_glasses_id` INT(11) NOT NULL,
      PRIMARY KEY (`order_items_id`),
        FOREIGN KEY (`orders_orders_id`)
        FOREIGN KEY (`glasses_glasses_id`)
    ```

## Instructions

1. Clone the repository:
    ```bash
    https://github.com/isaac-diez/mysql-estructura.git
    ```
2. Set up the database using the provided schema.

3. Run the application and enjoy managing your optics store!

## Contributors

- Isaac Díez (isaac-diez)

CREATE DATABASE zara_bike_rentals;

USE zara_bike_rentals;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE bikes(

bike_id INT AUTO_INCREMENT PRIMARY KEY,
brand VARCHAR(50) NOT NULL,
type VARCHAR(30) NOT NULL,
daily_rate DECIMAL(6, 2) NOT NULL,
available BOOLEAN DEFAULT TRUE
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    bike_id INT NOT NULL,
    start_date DATE NOT NULL,
    expected_return_date DATE NOT NULL,
    actual_return_date DATE,
    total_amount_charged DECIMAL(8, 2),
    
    
    CONSTRAINT fk_rentals_customers 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_rentals_bikes 
        FOREIGN KEY (bike_id) REFERENCES bikes(bike_id)
        ON DELETE CASCADE
        
);

SELECT * FROM bikes;

UPDATE bikes SET available = FALSE WHERE brand = 'Trek';

INSERT INTO customers (full_name,email,date_of_birth)
VALUES
('Kevin Motuka','kevinmotuka75@gmail.com', '2006-01-17'),
('Jane Smith', 'jane.smith@example.com', '1988-11-23');


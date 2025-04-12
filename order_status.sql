Create and use the database
CREATE DATABASE IF NOT EXISTS BookStore;
USE BookStore;

-- 1. Create order_status table
CREATE TABLE IF NOT EXISTS order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
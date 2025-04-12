-- 2. Create shipping_method table
CREATE TABLE IF NOT EXISTS shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL
);

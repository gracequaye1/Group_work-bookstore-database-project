-- 3. Create cust_order table
CREATE TABLE IF NOT EXISTS cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    order_status_id INT,
    shipping_method_id INT,
    FOREIGN KEY (order_status_id) REFERENCES order_status(status_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id)
);
-- Insert countries
INSERT INTO country (country_name) VALUES 
('Ghana'), 
('Nigeria'), 
('Kenya');

-- Insert address statuses
INSERT INTO address_status (status_description) VALUES 
('Current'), 
('Old');

-- Insert customers
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('Ama', 'Mensah', 'ama.mensah@example.com', '+233201234567'),
('Kwame', 'Boateng', 'kwame.boateng@example.com', '+233245678901');

-- Insert addresses
INSERT INTO address (street, city, postal_code, country_id) VALUES
('123 Market St', 'Accra', 'GA123', 1),
('456 High St', 'Kumasi', 'AK456', 1);

-- Link customers to addresses with status
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),  -- Ama lives at Market St (Current)
(2, 2, 1);  -- Kwame lives at High St (Current)

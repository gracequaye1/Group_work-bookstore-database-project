-- Step 3: Create user accounts

CREATE USER 'reader'@'localhost' IDENTIFIED BY 'reader_pass';
CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'analyst_pass';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_pass';

-- Step 4: Assign privileges

-- Reader can only read data
GRANT SELECT ON BookStore.* TO 'reader'@'localhost';

-- Analyst can read and insert data
GRANT SELECT, INSERT ON BookStore.* TO 'analyst'@'localhost';

-- Admin has full permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON BookStore.* TO 'admin'@'localhost';
-- Apply all changes
FLUSH PRIVILEGES;

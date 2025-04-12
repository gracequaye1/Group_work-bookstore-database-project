-- =============================================
-- BOOKSTORE DATABASE SETUP
-- Enhanced with professional standards
-- =============================================

-- 1. DATABASE CREATION
DROP DATABASE IF EXISTS bookstore;
CREATE DATABASE bookstore 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci
    COMMENT 'Database for bookstore operations';

USE bookstore;

-- =============================================
-- 2. CORE TABLES (Your Primary Responsibility)
-- =============================================

-- PUBLISHER TABLE (Lookup Table)
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Official publisher name',
    founded_year SMALLINT COMMENT 'Year the publisher was established',
    headquarters VARCHAR(100) COMMENT 'Main office location',
    website VARCHAR(255) COMMENT 'Official publisher website',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_founded_year CHECK (founded_year > 1500 AND founded_year <= YEAR(CURRENT_DATE))
) ENGINE=InnoDB COMMENT 'Book publishers information';

-- BOOK LANGUAGE TABLE (Lookup Table)
CREATE TABLE book_language (
    language_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    language_code CHAR(2) NOT NULL UNIQUE COMMENT 'ISO 639-1 language code',
    language_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Full language name',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB COMMENT 'Supported languages for books';

-- AUTHOR TABLE (Core Entity)
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL COMMENT 'Full author name',
    birth_date DATE COMMENT 'Author date of birth',
    death_date DATE COMMENT 'Author date of death (if applicable)',
    nationality VARCHAR(50) COMMENT 'Author nationality',
    biography TEXT COMMENT 'Detailed author biography',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_author_identity UNIQUE (author_name, birth_date) COMMENT 'Prevent duplicate author entries',
    CONSTRAINT chk_life_dates CHECK (death_date IS NULL OR birth_date < death_date)
) ENGINE=InnoDB COMMENT 'Authors information';

-- BOOK TABLE (Core Entity)
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL COMMENT 'Book title',
    isbn VARCHAR(17) NOT NULL UNIQUE COMMENT 'ISBN-13 format with hyphens',
    publication_date DATE NOT NULL COMMENT 'Original publication date',
    price DECIMAL(10,2) NOT NULL COMMENT 'Current retail price',
    num_pages SMALLINT UNSIGNED COMMENT 'Total page count',
    edition TINYINT UNSIGNED DEFAULT 1 COMMENT 'Edition number',
    description TEXT COMMENT 'Book synopsis',
    cover_image_url VARCHAR(255) COMMENT 'URL to book cover image',
    publisher_id INT NOT NULL COMMENT 'Reference to publisher',
    language_id SMALLINT NOT NULL COMMENT 'Reference to language',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_pages CHECK (num_pages > 0),
    CONSTRAINT chk_isbn CHECK (isbn REGEXP '^[0-9]{3}-[0-9]{10}$') COMMENT 'Validate ISBN-13 format',
    INDEX idx_title (title),
    INDEX idx_isbn (isbn),
    INDEX idx_publication_date (publication_date),
    FULLTEXT INDEX ftx_title_desc (title, description) COMMENT 'For search functionality'
) ENGINE=InnoDB COMMENT 'Core book information';

-- BOOK_AUTHOR JUNCTION TABLE (Many-to-Many Relationship)
CREATE TABLE book_author (
    book_id INT NOT NULL COMMENT 'Reference to book',
    author_id INT NOT NULL COMMENT 'Reference to author',
    contribution_type ENUM('Primary', 'Co-Author', 'Editor', 'Translator', 'Illustrator') 
        DEFAULT 'Primary' COMMENT 'Role in book creation',
    royalty_percentage DECIMAL(5,2) COMMENT 'Percentage royalty for this contribution',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id, author_id, contribution_type),
    FOREIGN KEY (book_id) REFERENCES book(book_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_royalty CHECK (royalty_percentage IS NULL OR 
                               (royalty_percentage >= 0 AND royalty_percentage <= 100))
) ENGINE=InnoDB COMMENT 'Relationship between books and authors';

-- =============================================
-- 3. SAMPLE DATA INSERTION
-- =============================================

-- Insert Publishers
INSERT INTO publisher (publisher_name, founded_year, headquarters, website) VALUES
('Penguin Random House', 2013, 'New York, USA', 'https://www.penguinrandomhouse.com'),
('HarperCollins', 1817, 'New York, USA', 'https://www.harpercollins.com'),
('Simon & Schuster', 1924, 'New York, USA', 'https://www.simonandschuster.com'),
('Gallimard', 1911, 'Paris, France', 'https://www.gallimard.fr');

-- Insert Languages
INSERT INTO book_language (language_code, language_name) VALUES
('en', 'English'),
('es', 'Spanish'),
('fr', 'French'),
('de', 'German'),
('it', 'Italian'),
('ja', 'Japanese');

-- Insert Authors
INSERT INTO author (author_name, birth_date, death_date, nationality, biography) VALUES
('J.K. Rowling', '1965-07-31', NULL, 'British', 'Creator of the Harry Potter series'),
('George R.R. Martin', '1948-09-20', NULL, 'American', 'Author of A Song of Ice and Fire'),
('Agatha Christie', '1890-09-15', '1976-01-12', 'British', 'Master of detective novels'),
('Gabriel García Márquez', '1927-03-06', '2014-04-17', 'Colombian', 'Nobel Prize-winning author'),
('Haruki Murakami', '1949-01-12', NULL, 'Japanese', 'Contemporary Japanese writer');

-- Insert Books
INSERT INTO book (title, isbn, publication_date, price, num_pages, edition, 
                 description, publisher_id, language_id) VALUES
('Harry Potter and the Philosopher''s Stone', '978-0747532743', '1997-06-26', 12.99, 223, 1,
 'The first book in the Harry Potter series', 1, 1),
('A Game of Thrones', '978-0553103540', '1996-08-01', 15.99, 694, 1,
 'First book in A Song of Ice and Fire', 2, 1),
('Murder on the Orient Express', '978-0062693662', '1934-01-01', 8.99, 256, 75,
 'Classic Hercule Poirot mystery', 3, 1),
('One Hundred Years of Solitude', '978-0060883287', '1967-05-30', 14.99, 417, 1,
 'Magical realism masterpiece', 2, 2),
('Norwegian Wood', '978-0099448822', '1987-09-04', 11.99, 296, 1,
 'Coming-of-age novel set in Tokyo', 1, 6);

-- Insert Book-Author Relationships
INSERT INTO book_author (book_id, author_id, contribution_type, royalty_percentage) VALUES
(1, 1, 'Primary', 15.00),
(2, 2, 'Primary', 20.00),
(3, 3, 'Primary', NULL),
(4, 4, 'Primary', 12.50),
(5, 5, 'Primary', 10.00);

-- =============================================
-- 4. VERIFICATION QUERIES
-- =============================================

-- Verify book-author-publisher relationships
SELECT 
    b.book_id,
    b.title,
    GROUP_CONCAT(DISTINCT a.author_name SEPARATOR ', ') AS authors,
    p.publisher_name,
    bl.language_name,
    b.price,
    b.isbn
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
JOIN book_language bl ON b.language_id = bl.language_id
LEFT JOIN book_author ba ON b.book_id = ba.book_id
LEFT JOIN author a ON ba.author_id = a.author_id
GROUP BY b.book_id
ORDER BY b.publication_date DESC;

-- Count books by language
SELECT 
    bl.language_name,
    COUNT(b.book_id) AS total_books,
    MIN(b.publication_date) AS oldest_publication,
    MAX(b.publication_date) AS newest_publication
FROM book_language bl
LEFT JOIN book b ON bl.language_id = b.language_id
GROUP BY bl.language_id
ORDER BY total_books DESC;


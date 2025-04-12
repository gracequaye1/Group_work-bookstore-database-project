# Group_work-bookstore-database-project
# Bookstore Database Design & Programming with SQL

## Project Overview
This project simulates a real-world database administration task for a bookstore. As a team, we designed and implemented a MySQL relational database system to handle the core operations of the bookstore including book listings, authorship, customer data, orders, shipping, and more.

We followed a modular team-based approach, where each member handled specific parts of the project, from database schema design to data input and user role management.

---

##  Objectives
- Design an efficient and normalized relational database for a bookstore.
- Create SQL tables and relationships using best practices.
- Load sample data for testing.
- Implement user roles and security privileges.
- Query the database for meaningful insights.

---

## Tools & Technologies
- **MySQL** – Database creation and management  
- **Draw.io** – Entity Relationship Diagram (ERD)  
- **SQL** – Table creation, queries, and data manipulation  

---

##  Contributors & Roles

| Name                | Role                         | Responsibilities |
|---------------------|------------------------------|------------------|
| **EsaKris**         | Member 1 – Database Designer  | Designed ERD, created book-related tables, finalized schema and relationships |
| **Grace Okailey Quaye** | Member 2 – SQL Table Creation & Sample Data | Created and tested tables related to customer and address modules |
| **Shadrack Oguta**  | Member 3 – Orders & User Management | Created order and shipping tables, implemented user roles and privileges |

---

##  Tables Created

Each team member worked on the following tables:

### Member 1 – EsaKris
- `book`
- `book_author`
- `author`
- `book_language`
- `publisher`

### Member 2 – Grace Okailey Quaye
- `customer`
- `customer_address`
- `address`
- `address_status`
- `country`

### Member 3 – Shadrack Oguta
- `cust_order`
- `order_line`
- `order_status`
- `order_history`
- `shipping_method`

---

##  Sample Data & Testing
- All members added test records to their respective tables.
- SELECT queries were run to test joins and ensure data integrity.
- Results were validated for accuracy and consistency.

---

##  User Management
- Roles created: `Reader`, `Admin`, `Analyst`
- Permissions were assigned to ensure secure and structured access to data.

---

##  ERD (Entity Relationship Diagram)
The ERD for this database was created using Draw.io and includes all 15 tables with their relationships.

---

##  Files Included
- `create_tables.sql` – Full SQL scripts to create all tables.
- `sample_data.sql` – Test data for each table.
- `README.md` – Project documentation.
- `bookstore_erd.drawio` – Visual schema design.

---

##  Acknowledgements
Big thanks to our team for their hard work, collaboration, and commitment to completing this hands-on database project.


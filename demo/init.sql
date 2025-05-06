CREATE DATABASE IF NOT EXISTS icafe_db;

-- Sử dụng cơ sở dữ liệu
USE icafe_db;

DROP TABLE IF EXISTS role;
CREATE TABLE role (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO role (role_id, role_name) VALUES
(1, 'ADMIN'),
(2, 'MANAGER'),
(3, 'STAFF');
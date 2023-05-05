-- Exercise 1:

-- question 1
-- create database
DROP DATABASE IF EXISTS QL_FRESHER;
CREATE DATABASE QL_FRESHER;
USE QL_FRESHER;

-- create table trainee
DROP TABLE IF EXISTS trainee;
CREATE TABLE trainee(
	trainee_id				INT AUTO_INCREMENT PRIMARY KEY,
    full_name				VARCHAR(50) NOT NULL,
    birth_date				DATETIME NOT NULL,
    gender					ENUM('male','female','unknown') NOT NULL,
    et_iq					INT CHECK (0 <= et_iq <= 20) NOT NULL,
    et_gmath				INT CHECK (0 <= et_gmath <= 20) NOT NULL,
    et_english				INT CHECK (0 <= et_english <= 50) NOT NULL,
    training_class			CHAR(10) NOT NULL UNIQUE KEY,
    evaluation_notes		TEXT	
);

-- question 2:
ALTER TABLE trainee
ADD COLUMN VTI_account 		INT NOT NULL UNIQUE KEY;


-- Exercise 2
DROP DATABASE IF EXISTS exercise2;
CREATE DATABASE exercise2;
USE exercise2;

DROP TABLE IF EXISTS table1;
CREATE TABLE table1(
	id					TINYINT	AUTO_INCREMENT PRIMARY KEY,
    `name`				CHAR(50) NOT NULL,
    `code`				CHAR(5) NOT NULL UNIQUE KEY,
    modified_date		DATETIME NOT NULL DEFAULT NOW()
);


-- Exercise 3
DROP DATABASE IF EXISTS exercise3;
CREATE DATABASE exercise3;
USE exercise3;

DROP TABLE IF EXISTS table2;
CREATE TABLE table2(
	id					TINYINT AUTO_INCREMENT PRIMARY KEY,
    `name`				CHAR(50) NOT NULL,
    birth_date			DATETIME NOT NULL,
    gender				ENUM('0','1','NULL') NOT NULL, -- 0 là male, 1 là female, NULL là unknown
    is_deleted_flag		BIT NOT NULL -- 0 là đang hoạt động, 1 là đã xóa
);
-- create database 
DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- create table department
DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id		INT	AUTO_INCREMENT PRIMARY KEY,
    department_name		VARCHAR(50)	UNIQUE KEY	NOT NULL
);

-- create table position
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id		INT AUTO_INCREMENT	PRIMARY KEY,
    position_name	ENUM('Dev','Test','Scrum Master','PM') UNIQUE NOT NULL
);

-- create table account
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id		INT	AUTO_INCREMENT	PRIMARY KEY,
    email			VARCHAR(30) UNIQUE NOT NULL,
    username		VARCHAR(30)	UNIQUE NOT NULL,
    fullname		VARCHAR(30) NOT NULL,
    department_id	INT,
    position_id		INT,
    create_date		DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (department_id) REFERENCES	department(department_id),
    FOREIGN KEY (position_id)	REFERENCES	`position`(position_id)
);

-- create table group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id	INT	AUTO_INCREMENT PRIMARY KEY,
    group_name	VARCHAR(30) UNIQUE KEY NOT NULL,
    creator_id  VARCHAR(30) UNIQUE KEY NOT NULL,
    create_date	DATETIME NOT NULL DEFAULT NOW()
);

-- create table group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account(
	group_id	INT,
    account_id	INT,
    join_date	DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (group_id,account_id),
    FOREIGN KEY (group_id) 		REFERENCES `group`(group_id),
    FOREIGN KEY (account_id)	REFERENCES	`account`(account_id)
);

-- create table type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question(
	type_id		INT AUTO_INCREMENT	PRIMARY KEY,
    type_name	ENUM('Essay', 'Multiple-Choice') NOT NULL
);

-- create table category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question(
	category_id		INT AUTO_INCREMENT PRIMARY KEY,
    category_name	VARCHAR(30)	NOT NULL 
);

-- create table question
DROP TABLE IF EXISTS question;
CREATE TABLE question(
	question_id		INT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(100),
    category_id		INT NOT NULL UNIQUE,
    type_id			INT NOT NULL UNIQUE,
    creator_id		INT NOT NULL UNIQUE,
    create_date		DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (category_id)	REFERENCES category_question(category_id),
    FOREIGN KEY (type_id)		REFERENCES type_question(type_id)
);

-- create table answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer(
	answer_id		INT AUTO_INCREMENT PRIMARY KEY,
    content			VARCHAR(100),
    question_id		INT NOT NULL UNIQUE,
    iscorrect		ENUM('Correct', 'incorrect') NOT NULL,
    FOREIGN KEY (question_id)	REFERENCES question(question_id)
);

-- create table exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam(
	exam_id			INT AUTO_INCREMENT PRIMARY KEY,
    `code`			CHAR(10) NOT NULL UNIQUE,
    title			VARCHAR(30) NOT NULL,
    category_id		INT NOT NULL,
    duration		VARCHAR(10) NOT NULL,
    creator_id		INT NOT NULL UNIQUE,
    create_date		DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (category_id)	REFERENCES category_question(category_id)
);

-- create table exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question(
	exam_id			INT AUTO_INCREMENT PRIMARY KEY,
    question_id		INT NOT NULL,
    FOREIGN KEY (question_id)	REFERENCES question(question_id)
);
-- create database
DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- create table department
DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id				INT	AUTO_INCREMENT PRIMARY KEY,
    department_name				VARCHAR(50)	UNIQUE KEY	NOT NULL
);

-- create table position
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`(
	position_id					INT AUTO_INCREMENT	PRIMARY KEY,
    position_name				ENUM('Dev','Test','Scrum Master','PM') UNIQUE NOT NULL
);

-- create table account
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id					INT	AUTO_INCREMENT	PRIMARY KEY,
    email						VARCHAR(30) UNIQUE NOT NULL,
    username					VARCHAR(30)	UNIQUE NOT NULL,
    fullname					VARCHAR(30) NOT NULL,
    department_id				INT,
    position_id					INT,
    create_date					DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (department_id) REFERENCES	department(department_id),
    FOREIGN KEY (position_id)	REFERENCES	`position`(position_id)
);

-- create table group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id					INT	AUTO_INCREMENT PRIMARY KEY,
    group_name					VARCHAR(30) UNIQUE KEY NOT NULL,
    creator_id  				VARCHAR(30) UNIQUE KEY NOT NULL,
    create_date					DATETIME NOT NULL DEFAULT NOW()
);

-- create table group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account(
	group_id					INT,
    account_id					INT,
    join_date					DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (group_id,account_id),
    FOREIGN KEY (group_id) 		REFERENCES `group`(group_id),
    FOREIGN KEY (account_id)	REFERENCES	`account`(account_id)
);

-- create table type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question(
	type_id						INT AUTO_INCREMENT PRIMARY KEY,
    type_name					ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question(
	category_id					INT AUTO_INCREMENT PRIMARY KEY,
    category_name				VARCHAR(30)	NOT NULL 
);

-- create table question
DROP TABLE IF EXISTS question;
CREATE TABLE question(
	question_id					INT AUTO_INCREMENT PRIMARY KEY,
    content						VARCHAR(100),
    category_id					INT NOT NULL,
    type_id						INT NOT NULL,
    creator_id					INT NOT NULL,
    create_date					DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (category_id)	REFERENCES category_question(category_id),
    FOREIGN KEY (type_id)		REFERENCES type_question(type_id)
);

-- create table answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer(
	answer_id					INT AUTO_INCREMENT PRIMARY KEY,
    content						VARCHAR(100),
    question_id					INT NOT NULL UNIQUE,
    iscorrect					ENUM('correct', 'incorrect') NOT NULL,
    FOREIGN KEY (question_id)	REFERENCES question(question_id)
);

-- create table exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam(
	exam_id						INT AUTO_INCREMENT PRIMARY KEY,
    `code`						CHAR(10) NOT NULL UNIQUE,
    title						VARCHAR(30) NOT NULL,
    category_id					INT NOT NULL,
    duration					VARCHAR(10) NOT NULL,
    creator_id					INT NOT NULL UNIQUE,
    create_date					DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY (category_id)	REFERENCES category_question(category_id)
);

-- create table exam_question
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question(
	exam_id						INT AUTO_INCREMENT PRIMARY KEY,
    question_id					INT NOT NULL,
    FOREIGN KEY (question_id)	REFERENCES question(question_id)
);

-- insert data into table department
INSERT INTO department(department_name) VALUES
						('Giám đốc'),
						('Phó Giám đốc'),
						('Bảo vệ'),
						('Kỹ thuật'),
						('Nhân sự'),
						('Bán hàng');
           
-- insert data into table position
INSERT INTO `position`(position_name) VALUES
						('Dev'),
                        ('Test'),
                        ('Scrum Master'),
                        ('PM');
 
-- insert data into table account
INSERT INTO `account`(email, username, fullname, department_id, position_id, create_date) VALUES
					('email1@gmail.com', 'username 1', 'fullname 1', 1, 3, '2023-05-01'),
                    ('email2@gmail.com', 'username 2', 'fullname 2', 5, 1, '2023-05-01'),
                    ('email3@gmail.com', 'username 3', 'fullname 3', 2, 2, '2023-05-01'),
                    ('email4@gmail.com', 'username 4', 'fullname 4', 3, 4, '2023-05-01'),
                    ('email5@gmail.com', 'username 5', 'fullname 5', 4, 1, '2023-05-01');
                    
-- insert data into table group
INSERT INTO `group` (group_name, creator_id, create_date) VALUES
					('groupname 1', 1, '2023-05-01'),
                    ('groupname 2', 2, '2023-05-01'),
                    ('groupname 3', 3, '2023-05-01'),
                    ('groupname 4', 4, '2023-05-01'),
                    ('groupname 5', 5, '2023-05-01');
                    
-- insert data into table group_account
INSERT INTO group_account (group_id, account_id, join_date) VALUES
							(1, 1, '2023-05-01'),
                            (1, 2, '2023-05-01'),
                            (2, 3, '2023-05-01'),
                            (2, 4, '2023-05-01'),
                            (3, 1, '2023-05-01'),
                            (3, 5, '2023-05-01'),
                            (4, 2, '2023-05-01'),
                            (5, 3, '2023-05-01');
                            
-- insert data into table type_question
INSERT INTO type_question (type_name) VALUES
							('Essay'),
                            ('Multiple-Choice');
                            
-- insert data into table category_question
INSERT INTO category_question (category_name) VALUES
								('Java'),
                                ('.NET'),
                                ('SQL'),
                                ('Python'),
                                ('Ruby'),
                                ('C++'),
                                ('Postman');
                                
-- insert data into table question
INSERT INTO question (content, category_id, type_id, creator_id, create_date) VALUES
					('content 1', 1, '1', 2, '2023-05-01'),
                    ('content 2', 2, '2', 1, '2023-05-01'),
                    ('content 3', 3, '1', 4, '2023-05-01'),
                    ('content 4', 4, '2', 5, '2023-05-01'),
                    ('content 5', 5, '1', 3, '2023-05-01');
                    
-- insert data into table answer
INSERT INTO answer (content, question_id, iscorrect) VALUES
					('Trả lời 1', 1, 'correct'),
                    ('Trả lời 2', 2, 'correct'),
                    ('Trả lời 3', 5, 'incorrect'),
                    ('Trả lời 4', 3, 'correct'),
                    ('Trả lời 5', 4, 'incorrect');
                    
-- insert data into table exam
INSERT INTO exam (`code`, title, category_id, duration, creator_id, create_date) VALUES
				('VTI001', 'Đề thi Java',	1, 	'120',  1, '2023-03-15'),
                ('VTI002', 'Đề thi SQL',	4,	'60',	2, '2023-04-15'),
                ('VTI003', 'Đề thi C++', 	6,	'90', 	3, '2023-03-02'),
                ('VTI004', 'Đề thi Ruby', 	5,	'120',  5, '2023-03-02'),
                ('VTI005', 'Đề thi .NET',	2,	'60', 	4, '2023-03-21');
                
-- insert data into table exam_question
INSERT INTO exam_question (exam_id, question_id) VALUES
							(1,3),
                            (2,2),
                            (3,4),
                            (4,1),
                            (5,5);



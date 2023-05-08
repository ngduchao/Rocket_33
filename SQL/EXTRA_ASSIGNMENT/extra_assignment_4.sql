DROP TABLE IF EXISTS extra_assignment4;
CREATE DATABASE IF NOT EXISTS extra_assignment4;
USE extra_assignment4;

-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_number				INT AUTO_INCREMENT PRIMARY KEY,
    department_name					VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS employee_table;
CREATE TABLE employee_table(
	employee_number					INT AUTO_INCREMENT PRIMARY KEY,
    employee_name					VARCHAR(30) NOT NULL,
    department_number				INT NOT NULL,
    FOREIGN KEY (department_number) REFERENCES department(department_number)
);

DROP TABLE IF EXISTS employee_skill_table;
CREATE TABLE employee_skill_table(
	employee_number					INT NOT NULL,
    skill_code						VARCHAR(30) NOT NULL,
    date_registerd					DATETIME NOT NULL,
    FOREIGN KEY (employee_number) 	REFERENCES employee_table(employee_number)
);

-- Question 2: Thêm ít nhất 10 bản ghi vào table
INSERT INTO department (department_name) VALUES
						('Giám đốc'),
						('Phó giám đốc'),
						('Sale'),
						('Marketing'),
						('Nhân sự'),
						('Phòng họp'),
						('Kỹ thuật'),
						('Kế toán'),
						('Bảo vệ'),
						('Thư ký');
                        
INSERT INTO employee_table (employee_name, department_number) VALUES
							('Nguyễn Đức Hảo', 			1),
							('Hà Vy Oanh', 				2),
							('Nguyễn Thị Ngọc Giang', 	10),
							('Nguyễn Quang Hiếu', 		7),
							('Nguyễn Đức Chiến', 		7),
							('Dương Thị Thu Hà', 		3),
							('Trần Thị Khánh Linh', 	3),
							('Nguyễn Minh Thu', 		3),
							('Lê Thị Kiều Loan', 		3),
							('Nguyễn Quang Hải', 		9);
                            
INSERT INTO employee_skill_table (employee_number, skill_code, date_registerd) VALUES
								(1, 'Java', 	'2023-04-27'),
								(1, 'Python', 	'2023-04-27'),
								(2, 'SQL', 		'2023-04-27'),
								(4, 'PHP', 		'2023-04-27'),
								(4, 'C++',		'2023-04-27'),
								(4, 'Java',		'2023-04-27'),
								(5, 'Java',		'2023-04-27'),
								(5, 'Ruby',		'2023-04-27'),
								(1, '.NET', 	'2023-04-27'),
								(1, 'SQL', 		'2023-04-27');
                                
-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java 
SELECT ET.employee_name, EST.skill_code
FROM employee_table AS ET
JOIN employee_skill_table AS EST ON EST.employee_number = ET.employee_number
WHERE EST.skill_code = 'Java';


-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT D.department_name, COUNT(ET.employee_number) AS SL
FROM department AS D
JOIN employee_table AS ET ON ET.department_number = D.department_number
GROUP BY D.department_name
HAVING SL > 3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT D.department_name, GROUP_CONCAT(ET.employee_name) AS 'Danh sách nhân viên'
FROM department AS D
JOIN employee_table AS ET ON ET.department_number = D.department_number
GROUP BY D.department_name;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
SELECT ET.employee_name, COUNT(EST.skill_code) AS SL
FROM employee_table AS ET
JOIN employee_skill_table AS EST ON EST.employee_number = ET.employee_number
GROUP BY ET.employee_name
HAVING SL > 1;
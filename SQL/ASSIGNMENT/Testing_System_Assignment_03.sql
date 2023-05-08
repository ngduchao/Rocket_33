USE testing_system;

-- Question 1: Thêm ít nhất 10 record vào mỗi table
INSERT INTO department(department_name) VALUES
						('Marketing'),
                        ('Truyền thống'),
                        ('Kế toán');
 

INSERT INTO `account`(email, username, fullname, department_id, position_id, create_date) VALUES
					('email6@gmail.com',  'ngocgiang', 	'Nguyễn Thị Ngọc Giang', 3, 4, '2023-05-06'),
                    ('email7@gmail.com',  'ducchien', 	'Nguyễn Đức Chiến', 	 3, 1, '2023-05-06'),
                    ('email8@gmail.com',  'quanghai', 	'Nguyễn Quang Hải', 	 8, 2, '2023-05-06'),
                    ('email9@gmail.com',  'kieuloan', 	'Lê Thị Kiều Loan', 	 3, 4, '2023-05-06'),
                    ('email10@gmail.com', 'thaotrang', 	'Nguyễn Thảo Trang', 	 4, 1, '2023-05-06');
                    
                    
INSERT INTO `group` (group_name, creator_id, create_date) VALUES
					('groupname 6',  1, '2023-02-01'),
                    ('groupname 7',  2, '2023-04-19'),
                    ('groupname 8',  3, '2020-11-20'),
                    ('groupname 9',  4, '2021-05-01'),
                    ('groupname 10', 5, '2022-07-01');
                    

INSERT INTO group_account (group_id, account_id, join_date) VALUES
							(3, 2, '2019-12-20'),
							(3, 6, '2019-12-20'),
							(3, 8, '2019-12-20'),
							(3, 9, '2019-12-20'),
							(3, 4, '2019-12-20'),
							(3, 3, '2019-12-20'),
							(4, 3, '2019-12-20'),
							(4, 1, '2019-12-20'),
							(4, 6, '2019-12-20'),
							(4, 7, '2019-12-20'),
							(4, 5, '2019-12-20'),
                            (5, 1, '2023-01-02');
                            

INSERT INTO category_question (category_name) VALUES
								('Front End'),
                                ('Phỏng vấn'),
                                ('PHP');
                                
                                
INSERT INTO question (content, category_id, type_id, creator_id, create_date) VALUES
					('câu hỏi về Front End', 	6, '1', 2, '2023-05-01'),
                    ('câu hỏi phỏng vấn SQL', 	3, '2', 1, '2023-05-01'),
                    ('vấn đáp sql', 			3, '1', 4, '2023-05-01'),
                    ('trắc nghiệm Java Core', 	1, '2', 5, '2023-05-01'),
                    ('báo cáo nghiên cứu', 		5, '1', 3, '2023-05-01');
                    
	
INSERT INTO answer (content, question_id, iscorrect) VALUES
					('Trả lời 6', 	7, 'correct'),
                    ('Trả lời 7', 	1, 'correct'),
                    ('Trả lời 8', 	8, 'incorrect'),
                    ('Trả lời 9', 	9, 'correct'),
                    ('Trả lời 10', 	6, 'incorrect');
                    
                    
INSERT INTO exam (`code`, title, category_id, duration, creator_id, create_date) VALUES
				('VTI006', 'Đề thi Java Core',		1, 	'120',  1, '2023-03-15'),
                ('VTI007', 'Đề thi PHP',			4,	'60',	2, '2023-04-15'),
                ('VTI008', 'Đề thi Python', 		6,	'90', 	3, '2023-03-02'),
                ('VTI009', 'Đề thi Java Advance', 	5,	'120',  4, '2023-03-02'),
                ('VTI0010', 'Đề thi Front End',		2,	'60', 	5, '2023-03-21');
                
                
INSERT INTO exam_question (question_id) VALUES
							(1),
                            (2),
                            (3),
                            (4),
                            (1);

-- Question 2:lấy ra tất cả các phòng ban
SELECT * FROM department;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT department_id FROM department
WHERE department_name = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT *, LENGTH(fullname) AS 'Độ dài' FROM `account`
WHERE LENGTH(fullname) = (SELECT MAX(LENGTH(fullname)) FROM `account`)
ORDER BY fullname DESC;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT *, LENGTH(fullname) AS 'Độ dài' FROM `account`
WHERE LENGTH(fullname) = (SELECT MAX(LENGTH(fullname)) FROM `account`) AND department_id = 3
ORDER BY fullname DESC;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT group_name FROM `group`
WHERE create_date < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT answer.question_id, COUNT(answer.question_id) AS 'Số lượng' FROM answer
GROUP BY answer.question_id
HAVING COUNT(answer.question_id) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT exam_id FROM exam
WHERE duration >= 60 AND create_date < '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM `group`
ORDER BY create_date DESC
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT department_id, COUNT(department_id) AS 'Số lượng' 
FROM department
GROUP BY department_id
HAVING department_id = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account`
WHERE fullname LIKE 'D%o';

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM `exam`
WHERE create_date < '2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"


-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`
SET fullname = 'Nguyễn Bá Lộc', email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;


-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE `group`
SET group_id = 4
WHERE creator_id = 5;
USE testing_system;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `account` JOIN department
ON `account`.department_id = department.department_id;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * FROM `account` JOIN department
ON `account`.department_id = department.department_id
WHERE create_date > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT * FROM `account` JOIN `position`
ON `account`.position_id = `position`.position_id
WHERE `position`.position_name = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT department.department_name, COUNT(`account`.department_id) AS SL 
FROM `account` JOIN department
ON `account`.department_id = department.department_id
GROUP BY `account`.department_id
HAVING SL > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT exam_question.question_id, question.content, COUNT(exam_question.question_id) AS SL FROM question JOIN exam_question
ON question.question_id = exam_question.question_id
GROUP BY exam_question.question_id
HAVING SL = (SELECT MAX(count_q) 
				FROM (SELECT COUNT(exam_question.question_id) AS count_q
					FROM exam_question GROUP BY exam_question.question_id) AS count_table);


-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT CQ.category_name, COUNT(Q.category_id) AS SL
FROM category_question AS CQ JOIN question AS Q
ON CQ.category_id = Q.category_id
GROUP BY Q.category_id;


-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT Q.content, COUNT(EQ.question_id)
FROM question AS Q JOIN exam_question AS EQ
ON Q.question_id = EQ.question_id
GROUP BY EQ.question_id;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.content, COUNT(A.question_id)
FROM question AS Q JOIN answer AS A
ON Q.question_id = A.question_id
GROUP BY A.question_id
HAVING COUNT(A.question_id) = (SELECT MAX(count_q) 
								FROM (SELECT COUNT(A2.question_id) AS count_q 
									FROM answer AS A2 GROUP BY A2.question_id) AS count_table);
                                    
                                    
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT G.group_name, COUNT(GA.account_id) AS SL
FROM `group` AS G JOIN group_account AS GA
ON G.group_id = GA.group_id
GROUP BY G.group_id
ORDER BY SL ASC;


-- Question 10: Tìm chức vụ có ít người nhất
SELECT P.position_name, COUNT(A.position_id) AS SL
FROM `position` AS P JOIN `account` AS A
ON P.position_id = A.position_id
GROUP BY A.position_id
HAVING SL = (SELECT MIN(count_p) FROM (SELECT COUNT(`account`.position_id) AS count_p FROM `account` GROUP BY position_id) AS count_table);


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT P.position_name, COUNT(A.position_id)
FROM `account` AS A JOIN `position` AS P
ON A.position_id = P.position_id
GROUP BY A.position_id;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.question_id, Q.content, TQ.type_name AS 'Tên người tạo', AN.content
FROM question AS Q 
JOIN type_question AS TQ ON Q.type_id = TQ.type_id
JOIN `account` AS A ON Q.creator_id = A.account_id
JOIN answer AS AN ON Q.question_id = AN.question_id;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT TQ.type_name AS 'Loại câu hỏi', COUNT(Q.type_id) AS 'Số lượng'
FROM question AS Q JOIN type_question AS TQ
ON Q.type_id = TQ.type_id
GROUP BY Q.type_id;

-- Question 14: Lấy ra group không có account nào
SELECT * FROM `group` AS G
WHERE group_id NOT IN (SELECT group_id FROM group_account);

-- Question 15:Lấy ra group không có account nào
SELECT * FROM `group` AS G
LEFT JOIN group_account AS GA ON GA.group_id = G.group_id
WHERE GA.account_id IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT * FROM question AS Q
LEFT JOIN answer AS AN ON AN.question_id = Q.question_id
WHERE AN.question_id IS NULL;

-- Question 17: 
-- 			a) Lấy các account thuộc nhóm thứ 1
-- 			b) Lấy các account thuộc nhóm thứ 2
-- 			c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.fullname FROM `account` AS A 
JOIN group_account AS GA ON GA.account_id = A.account_id
WHERE GA.group_id = 1
UNION
SELECT A.fullname FROM `account` AS A 
JOIN group_account AS GA ON GA.account_id = A.account_id
WHERE GA.group_id = 2;

-- Question 18:
-- 			a) Lấy các group có lớn hơn 5 thành viên
-- 			b) Lấy các group có nhỏ hơn 7 thành viên
-- 			c) Ghép 2 kết quả từ câu a) và câu b)
SELECT G.group_name FROM `group` AS G
JOIN group_account AS GA ON GA.group_id = G.group_id
GROUP BY GA.group_id
HAVING COUNT(GA.group_id) > 5 -- -->3,4
UNION
SELECT G.group_name FROM `group` AS G
JOIN group_account AS GA ON GA.group_id = G.group_id
GROUP BY GA.group_id
HAVING COUNT(GA.group_id) < 7; -- -->1,2,4,5
-- --> không có 6,7,8,9,10 vì các nhóm này không có thành viên
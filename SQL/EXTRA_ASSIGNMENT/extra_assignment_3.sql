USE QL_FRESHER;

SELECT * FROM trainee;
-- Question 1: Thêm ít nhất 10 bản ghi vào table
INSERT INTO trainee (`full_name`, `birth_date`, `gender`, `et_iq`, `et_gmath`, `et_english`, `training_class`, `evaluation_notes`, `VTI_account`) VALUES
					('Nguyễn Đức Hảo', 			'2002-02-02', 'male', 	19, 20, 30, 'TTS001', 'Không có gì', 'duchaovti@gmail.com'),
					('Nguyễn Thị Ngọc Giang', 	'2000-03-08', 'female', 19, 20, 40, 'TTS001', 'Không có gì', 'giangvti@gmail.com'),
					('Nguyễn Đức Chiến', 		'2002-07-15', 'male', 	19, 15, 25, 'TTS002', 'Không có gì', 'ducchienvti@gmail.com'),
					('Nguyễn Quang Hiếu', 		'2002-09-22', 'male', 	15, 18, 30, 'TTS002', 'Không có gì', 'quanghieuvti@gmail.com'),
					('Trần Thị Khánh Linh', 	'2002-03-14', 'female', 19, 20, 20, 'TTS003', 'Không có gì', 'khanhlinhvti@gmail.com'),
					('Dương Thị Thu Hà', 		'2003-12-29', 'female', 18, 20, 45, 'TTS003', 'Không có gì', 'duonghavti@gmail.com'),
					('Vũ Anh Quân', 			'1999-11-28', 'male', 	19, 20, 20, 'TTS003', 'Không có gì', 'vuquanvti@gmail.com'),
					('Nguyễn Minh Thu', 		'2001-11-20', 'female', 19, 20, 45, 'TTS003', 'Không có gì', 'minhthuvti@gmail.com'),
					('Nguyễn Thu Hương', 		'2001-08-20', 'female', 19, 20, 36, 'TTS003', 'Không có gì', 'thuhuongvti@gmail.com'),
					('Đào Thu Trang', 			'2002-06-02', 'female', 19, 20, 30, 'TTS003', 'Không có gì', 'thutrangvti@gmail.com');
                    

-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau
SELECT GROUP_CONCAT(full_name), MONTH(birth_date) AS 'Tháng sinh' 
FROM trainee
GROUP BY MONTH(birth_date);

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT full_name, (YEAR(NOW()) - YEAR(birth_date)) AS 'Tuổi', gender, et_iq, et_gmath, et_english, training_class, evaluation_notes, VTI_account
FROM trainee
WHERE LENGTH(full_name) = (SELECT MAX(LENGTH(full_name)) FROM trainee)
ORDER BY full_name DESC;

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  	ET_IQ + ET_Gmath>=20
--  	ET_IQ>=8
--  	ET_Gmath>=8
--  	ET_English>=18

SELECT full_name
FROM trainee
WHERE (et_iq + et_gmath) >= 20 OR et_iq >= 8 OR et_gmath >= 8 OR et_english >= 18;


-- Question 5: xóa thực tập sinh có TraineeID = 3
DELETE FROM trainee
WHERE trainee_id = 3;


-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật thông tin vào database
UPDATE trainee
SET training_class = 'TTS002'
WHERE trainee_id = 5;
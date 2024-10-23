-- Active: 1729082435147@@127.0.0.1@5432@university_db
CREATE DATABASE university_db;
-- creating students table
CREATE Table students(
    student_id INTEGER PRIMARY KEY UNIQUE,
    student_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(50)
);
-- creating courses table
CREATE Table courses(
course_id INTEGER PRIMARY KEY UNIQUE,
course_name VARCHAR(100),
credits INTEGER
);
-- creating enrollment table
CREATE Table enrollment(
    enrollment_id INTEGER PRIMARY KEY UNIQUE,
    student_id INTEGER REFERENCES students(student_id),
    course_id  INTEGER REFERENCES courses(course_id)
);

-- insert data to students table
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(1, 'Sameer', 21, 'sameer@example.com',48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com',52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com',37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com',41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com',50, 52, NULL),
(6, 'Hasan', 23, 'hasan@example.com',43, 39, NULL);

-- insert data to courses table
INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

-- insert data to enrollment table 
INSERT INTO enrollment (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollment;

-- Query 1:
-- Insert a new student record with the following details:
-- Purpose: Insert means post a new student to students table
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
(7, 'Gandib', 24, 'gandib@gmail.com',59, 60, NULL);

-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
-- Purpose: Displaying the names who are enrolled Next.js
SELECT student_name from enrollment e 
JOIN students s ON s.student_id = e.student_id 
JOIN courses c ON e.course_id = c.course_id 
WHERE c.course_id = 1;

-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
-- Purpose: Updating specific student's status whose marks (frontend_mark + backend_mark) is highest
UPDATE students SET status = 'Awarded' 
WHERE student_id = (SELECT student_id 
FROM students 
GROUP BY student_id 
ORDER BY sum(frontend_mark+backend_mark) 
desc LIMIT 1);

-- Query 4:
-- Delete all courses that have no students enrolled.
-- Purpose: Deleting rest of courses which are not enrolled
DELETE FROM courses 
WHERE courses.course_id 
NOT IN (SELECT course_id 
FROM enrollment  
NATURAL JOIN courses 
GROUP BY course_id);

-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name  FROM students LIMIT 2 OFFSET 2;

-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(student_name) as students_enrolled 
FROM enrollment e 
JOIN students s ON s.student_id = e.student_id 
JOIN courses c ON e.course_id = c.course_id 
GROUP BY course_name;

-- Query 7:
-- Calculate and display the average age of all students.
SELECT  avg(age) AS average_age FROM students;

-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'
SELECT student_name FROM students 
WHERE email LIKE '%example.com';

-- query completed--

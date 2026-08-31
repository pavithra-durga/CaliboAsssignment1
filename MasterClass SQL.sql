CREATE DATABASE CollegeManagement;

USE CollegeManagement;

CREATE TABLE Student_Management (
Student_ID INT UNSIGNED PRIMARY KEY,
Student_Name VARCHAR(100) NOT NULL,
Email VARCHAR(255) NOT NULL UNIQUE,
Phone VARCHAR(15) NOT NULL UNIQUE,
Age TINYINT UNSIGNED NOT NULL,
Department VARCHAR(50) NOT NULL,
Year TINYINT UNSIGNED NOT NULL,
CGPA DECIMAL(3,2) NOT NULL CHECK (CGPA >= 0 AND CGPA <= 10)
);


INSERT INTO Student_Management
(Student_ID, Student_Name, Email, Phone, Age, Department, Year, CGPA)
VALUES
(101, 'Kushi', 'kushi101@gmail.com', '9876543210', 20, 'CSE', 3, 8.50),
(102, 'Anjali', 'anjali102@gmail.com', '9876543211', 21, 'CSE', 3, 9.10),
(103, 'Rahul', 'rahul103@gmail.com', '9876543212', 22, 'ECE', 4, 7.80),
(104, 'Priya', 'priya104@gmail.com', '9876543213', 20, 'IT', 3, 8.20),
(105, 'Arjun', 'arjun105@gmail.com', '9876543214', 23, 'CSE', 4, 9.30),
(106, 'Sneha', 'sneha106@gmail.com', '9876543215', 21, 'ECE', 3, 7.50),
(107, 'Ravi', 'ravi107@gmail.com', '9876543216', 22, 'IT', 4, 8.80),
(108, 'Divya', 'divya108@gmail.com', '9876543217', 19, 'CSE', 2, 8.00),
(109, 'Kiran', 'kiran109@gmail.com', '9876543218', 24, 'MECH', 4, 7.90),
(110, 'Neha', 'neha110@gmail.com', '9876543219', 21, 'CSE', 3, 8.70);

SELECT * FROM Student_Management;

CREATE TABLE Departments (
Department_ID INT PRIMARY KEY,
Department_Name VARCHAR(100) NOT NULL
);

INSERT INTO Departments (Department_ID, Department_Name)
VALUES
(10, 'CSE'),
(20, 'ECE'),
(30, 'EEE'),
(40, 'MECH');

SELECT * FROM Departments;

CREATE TABLE Students (
Student_ID INT PRIMARY KEY,
Student_Name VARCHAR(100) NOT NULL,
Department_ID INT
);

INSERT INTO Students (Student_ID, Student_Name, Department_ID)
VALUES
(101, 'Rahul', 10),
(102, 'Priya', 20),
(103, 'Ravi', 10),
(104, 'Anu', 30),
(105, 'Kiran', NULL);

SELECT * FROM Students;

SELECT
Students.Student_ID,
Students.Student_Name,
Departments.Department_Name
FROM Students
INNER JOIN Departments
ON Students.Department_ID = Departments.Department_ID;

SELECT
Departments.Department_ID,
Departments.Department_Name,
Students.Student_ID,
Students.Student_Name
FROM Departments
LEFT JOIN Students
ON Departments.Department_ID = Students.Department_ID;

SELECT
Students.Student_ID,
Students.Student_Name,
Students.Department_ID
FROM Students
LEFT JOIN Departments
ON Students.Department_ID = Departments.Department_ID
WHERE Departments.Department_ID IS NULL;

SELECT
Departments.Department_ID,
Departments.Department_Name
FROM Departments
LEFT JOIN Students
ON Departments.Department_ID = Students.Department_ID
WHERE Students.Student_ID IS NULL;

SELECT
Students.Student_ID,
Students.Student_Name,
Students.Department_ID,
Departments.Department_Name
FROM Students
LEFT JOIN Departments
ON Students.Department_ID = Departments.Department_ID

UNION

SELECT
Students.Student_ID,
Students.Student_Name,
Students.Department_ID,
Departments.Department_Name
FROM Students
RIGHT JOIN Departments
ON Students.Department_ID = Departments.Department_ID;

CREATE TABLE Employees (
Employee_ID INT PRIMARY KEY,
Employee_Name VARCHAR(100) NOT NULL,
Manager_ID INT,
Department_ID INT,
Salary DECIMAL(10,2)
);

INSERT INTO Employees
(Employee_ID, Employee_Name, Manager_ID, Department_ID, Salary)
VALUES
(1, 'Arun', NULL, 10, 50000),
(2, 'Ravi', 1, 10, 60000),
(3, 'Priya', 1, 20, 55000),
(4, 'Kiran', 2, 20, 65000),
(5, 'Anu', NULL, 30, 45000);

SELECT * FROM Employees;

SELECT
E.Employee_Name AS Employee_Name,
M.Employee_Name AS Manager_Name
FROM Employees E
LEFT JOIN Employees M
ON E.Manager_ID = M.Employee_ID;

CREATE TABLE Courses (
Course_ID INT PRIMARY KEY,
Course_Name VARCHAR(100) NOT NULL,
Department_ID INT
);

INSERT INTO Courses
(Course_ID, Course_Name, Department_ID)
VALUES
(201, 'DBMS', 10),
(202, 'Python', 10),
(203, 'Digital Electronics', 20),
(204, 'Power Systems', 30);

CREATE TABLE Enrollments (
Student_ID INT,
Course_ID INT,
PRIMARY KEY (Student_ID, Course_ID)
);

INSERT INTO Enrollments
(Student_ID, Course_ID)
VALUES
(101, 201),
(101, 202),
(102, 203),
(103, 201),
(104, 204);


SELECT * FROM Courses;

SELECT * FROM Enrollments;

SELECT
Students.Student_Name,
Departments.Department_Name AS Department,
Courses.Course_Name AS Course
FROM Students
INNER JOIN Departments
ON Students.Department_ID = Departments.Department_ID
INNER JOIN Enrollments
ON Students.Student_ID = Enrollments.Student_ID
INNER JOIN Courses
ON Enrollments.Course_ID = Courses.Course_ID;

SELECT
Students.Student_Name,
Departments.Department_Name AS Department,
Courses.Course_Name AS Course
FROM Students
INNER JOIN Departments
ON Students.Department_ID = Departments.Department_ID
INNER JOIN Enrollments
ON Students.Student_ID = Enrollments.Student_ID
INNER JOIN Courses
ON Enrollments.Course_ID = Courses.Course_ID
WHERE Departments.Department_Name = 'CSE';

SELECT
Departments.Department_Name,
COUNT(Employees.Employee_ID) AS Number_of_Employees,
AVG(Employees.Salary) AS Average_Salary,
SUM(Employees.Salary) AS Total_Salary,
MAX(Employees.Salary) AS Highest_Salary,
MIN(Employees.Salary) AS Lowest_Salary
FROM Departments
LEFT JOIN Employees
ON Departments.Department_ID = Employees.Department_ID
GROUP BY
Departments.Department_ID,
Departments.Department_Name;

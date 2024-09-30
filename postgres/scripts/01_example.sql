CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary NUMERIC(10, 2),
    department VARCHAR(50)
);


INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, job_title, salary, department)
VALUES 
('John', 'Doe', 'john.doe@example.com', '555-1234', '2023-01-15', 'Software Engineer', 75000.00, 'IT'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2022-11-20', 'Data Analyst', 68000.00, 'Marketing'),
('Michael', 'Brown', 'michael.brown@example.com', '555-8765', '2021-05-10', 'Project Manager', 85000.00, 'Operations'),
('Emily', 'Davis', 'emily.davis@example.com', '555-4321', '2020-03-30', 'HR Specialist', 62000.00, 'Human Resources'),
('David', 'Wilson', 'david.wilson@example.com', '555-6543', '2022-07-18', 'Accountant', 70000.00, 'Finance');

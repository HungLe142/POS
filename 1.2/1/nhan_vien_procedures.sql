-- Create table for 'Nhan vien'
CREATE TABLE nhan_vien (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

-- Insert procedure
CREATE PROCEDURE insert_nhan_vien (
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(10, 2)
)
BEGIN
    -- Validate data
    IF p_age <= 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age must be greater than 18';
    END IF;

    IF NOT p_phone_number REGEXP '^[0-9]{10,15}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid phone number format';
    END IF;

    IF NOT p_email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;

    -- Insert data
    INSERT INTO nhan_vien (id, name, age, phone_number, email, position, salary)
    VALUES (p_id, p_name, p_age, p_phone_number, p_email, p_position, p_salary);
END;

-- Update procedure
CREATE PROCEDURE update_nhan_vien (
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_age INT,
    IN p_phone_number VARCHAR(15),
    IN p_email VARCHAR(100),
    IN p_position VARCHAR(50),
    IN p_salary DECIMAL(10, 2)
)
BEGIN
    -- Validate data
    IF p_age <= 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Age must be greater than 18';
    END IF;

    IF NOT p_phone_number REGEXP '^[0-9]{10,15}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid phone number format';
    END IF;

    IF NOT p_email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid email format';
    END IF;

    -- Update data
    UPDATE nhan_vien
    SET name = p_name, age = p_age, phone_number = p_phone_number, email = p_email, position = p_position, salary = p_salary
    WHERE id = p_id;
END;

-- Delete procedure
CREATE PROCEDURE delete_nhan_vien (
    IN p_id INT
)
BEGIN
    DELETE FROM nhan_vien WHERE id = p_id;
END;
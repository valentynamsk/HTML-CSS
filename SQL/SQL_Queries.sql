--Create a table car_brands - contains information about all car brands (id, title)--
CREATE TABLE car_brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255));

INSERT INTO car_brands (title) VALUES
('Toyota'),
('BMW'),
('Audi');


-- Create a table car_models - contains information about car models (id, carBrandId, title)--
CREATE TABLE car_models (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carBrandId INT NOT NULL,
    title TEXT NOT NULL,
    FOREIGN KEY (carBrandId) REFERENCES car_brands(id));

INSERT INTO car_models (carBrandId, title) VALUES
(1, 'Corolla'),
(1, 'Camry'),
(2, 'X5'),
(2, 'X3'),
(3, 'A4'),
(3, 'Q7');


-- Create a table users - contains information about users (id, userId, firstName, lastName, email, password)--
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    firstName TEXT,
    lastName TEXT,
    email TEXT NOT NULL,
    password TEXT NOT NULL);

INSERT INTO users (userId, firstName, lastName, email, password) VALUES
(1, 'Valentyna', 'Mysak', 'valentyna@gmail.com', 'Valentyna2025'),
(2, 'Yura', 'Ivanov', 'yura@gmail.com', 'Yura123456789'),
(3, 'Olga', 'Petrenko', 'olga@gmail.com', 'Olga1234456789'),
(4, 'Andriy', 'Kovalenko', 'andriy@gmail.com', 'Andriy@2025');


-- Create a table cars - contains data about users and their cars (id, carBrandId, carModelId, mileage, initialMileage)--
CREATE TABLE cars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carBrandId INT NOT NULL,
    carModelId INT NOT NULL,
    mileage INT,
    initialMileage INT,
    FOREIGN KEY (carBrandId) REFERENCES car_brands(id),
    FOREIGN KEY (carModelId) REFERENCES car_models(id));

INSERT INTO cars (carBrandId, carModelId, mileage, initialMileage) VALUES
(1, 8, 50000, 50),
(1, 9, 30000, 100),
(2, 10, 40000, 2000),
(2, 11, 20000, 300),
(3, 12, 35000, 500),
(3, 13, 10000, 100);


-- Find users whose first name contains the sequence of letters "am"--
SELECT *
FROM users
WHERE firstName LIKE '%am%';


-- Find the highest mileage among Audi cars--
SELECT MAX(mileage)
FROM cars
WHERE car_brands.title = 'Audi';


-- Find the number of models for the brands AUDI and BMW--
-- Display two columns: count_models (number of models) and car_id (brand id)--
SELECT
    carBrandId AS car_id,
    COUNT(id) AS count_models
FROM car_models
WHERE carBrandId IN
      (SELECT id FROM car_brands WHERE title IN ('Audi', 'BMW'))
GROUP BY carBrandId;


-- Find the number of car owners by car brands and models--
-- Display three columns: car_model, car_brand, and user_count--
SELECT
    title AS car_model,
    carBrandId AS car_brand,
    (SELECT COUNT(*)
     FROM cars
     WHERE cars.carModelId = car_models.id AND cars.ownerId IS NOT NULL) AS user_count
FROM car_models
WHERE carBrandId IN
      (SELECT id FROM car_brands)
ORDER BY carBrandId, id;

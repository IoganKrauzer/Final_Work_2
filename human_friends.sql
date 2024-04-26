CREATE DATABASE IF NOT EXISTS human_friends;
USE human_friends;

CREATE TABLE IF NOT EXISTS animals_type
(id INT PRIMARY KEY AUTO_INCREMENT,
animal_type VARCHAR(25));

INSERT INTO animals_type(animal_type)
VALUES 
('home_pet'), 
('pack_animal');

CREATE TABLE IF NOT EXISTS home_pets
(id INT PRIMARY KEY AUTO_INCREMENT,
genus_name VARCHAR (25),
animal_type_id INT,
FOREIGN KEY (animal_type_id) REFERENCES animals_type (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO home_pets (genus_name, animal_type_id)
VALUES 
('dog', 1),
('cat', 1),  
('hamster', 1); 

CREATE TABLE IF NOT EXISTS pack_animals
(id INT PRIMARY KEY AUTO_INCREMENT,
genus_name VARCHAR (25),
animal_type_id INT, 
FOREIGN KEY (animal_type_id) REFERENCES animals_type (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO pack_animals (genus_name, animal_type_id)
VALUES 
('horse', 2),
('camel', 2),  
('donkey', 2); 

CREATE TABLE animals_commands
(id INT PRIMARY KEY AUTO_INCREMENT, 
command_name VARCHAR (50));

INSERT INTO animals_commands (command_name)
VALUES 
('eat'),
('sleep'),  
('wake_up'),
('sit_down'),
('snap'); 

CREATE TABLE IF NOT EXISTS dogs 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES home_pets (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO dogs (nickname, birthday, command_id, genus_name_id)
VALUES
('Brazil', '2023-06-01', 5, 1),
('Nalaak', '2021-12-01', 2, 1),
('Kysto', '2024-01-01', 1, 1);

CREATE TABLE IF NOT EXISTS cats 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES home_pets (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO cats (nickname, birthday, command_id, genus_name_id)
VALUES
('Zloba', '2023-05-01', 1, 2),
('Amanda', '2020-12-01', 2, 2),
('Chris', '2022-12-12', 1, 2);

CREATE TABLE IF NOT EXISTS hamsters 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES home_pets (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO hamsters (nickname, birthday, command_id, genus_name_id)
VALUES
('Schpak', '2024-02-01', 1, 3),
('Lolka', '2023-03-01', 2, 3),
('Koleso', '2022-11-12', 1, 3);

CREATE TABLE IF NOT EXISTS horses 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO horses (nickname, birthday, command_id, genus_name_id)
VALUES
('Blacky', '2021-02-01', 1, 1),
('White', '2018-12-01', 2, 1),
('Planeta', '2023-12-12', 1, 1);

CREATE TABLE IF NOT EXISTS camels 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO camels (nickname, birthday, command_id, genus_name_id)
VALUES
('Cabluk', '2024-02-01', 1, 2),
('Truba', '2023-04-01', 5, 2),
('Gaby', '2017-12-12', 2, 2);

CREATE TABLE IF NOT EXISTS donkeys 
(id INT PRIMARY KEY AUTO_INCREMENT, 
nickname VARCHAR(20), 
birthday DATE,
command_id INT, FOREIGN KEY (command_id) REFERENCES animals_commands (id) ON DELETE CASCADE ON UPDATE CASCADE,
genus_name_id INT, FOREIGN KEY (genus_name_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO donkeys (nickname, birthday, command_id, genus_name_id)
VALUES
('Grey', '2019-02-01', 1, 3),
('Klosha', '2022-12-01', 2, 3),
('Chupa', '2023-01-12', 1, 3);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM camels;

CREATE TABLE IF NOT EXISTS  animals_in_the_nursery  AS
SELECT *, 'horse' as genus_name 
FROM horses
UNION SELECT *, 'donkey' AS genus_name FROM donkeys
UNION SELECT *, 'dog' AS genus_name FROM dogs
UNION SELECT *, 'cat' AS genus_name FROM cats
UNION SELECT *, 'hamster' AS genus_name FROM hamsters;

CREATE TABLE IF NOT EXISTS young_animals AS
SELECT nickname, birthday, genus_name, genus_name_id, command_id, TIMESTAMPDIFF(MONTH, birthday, CURDATE()) AS age_in_month 
FROM animals_in_the_nursery 
WHERE DATE_ADD(birthday, INTERVAL 1 YEAR) < CURDATE() AND DATE_ADD(birthday, INTERVAL 3 YEAR) > CURDATE();

CREATE TABLE IF NOT EXISTS horses_and_donkeys AS
SELECT nickname, birthday, command_id, genus_name_id FROM horses
UNION SELECT nickname, birthday, command_id, genus_name_id  FROM donkeys;

SELECT nickname, birthday, genus_name_id
FROM horses_and_donkeys
UNION SELECT nickname, birthday, genus_name_id 
FROM young_animals;

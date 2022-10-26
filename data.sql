/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES
('Agumon', DATE '2020-02-03', 0, 'TRUE', 10.23),
('Gabumon', DATE '2018-11-15', 2, 'TRUE', 8),
('Pikachu', DATE '2021-01-07', 1, 'FALSE', 15.04),
('Devimon', DATE '2017-05-12', 5, 'TRUE', 11);

INSERT INTO animals (name,  date_of_birth, weight_kg, neutered, escape_attempts)
VALUES 
	('Charmander', '2020-02-08', -11, FALSE, 0),
	('Plantmon', '2021-11-15', -5.7, TRUE, 2),
	('Squirtle', '1993-06-02', -12.13, FALSE, 3),
	('Angemon', '2005-06-12', -45, TRUE, 1),
	('Boarmon', '2005-06-07', 20.4, TRUE, 7),
	('Blossom', '1998-10-13', 17, TRUE, 3),
	('Ditto', '2022-05-14', 22, TRUE, 4);


INSERT INTO owners (full_name, age)
VALUES 
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

INSERT INTO species(name) 
VALUES 
('Pokemon'), 
('Digimon');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith' ) WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
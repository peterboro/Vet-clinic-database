/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4  AND weight_kg <= 17.3;


-- update the animals table by setting the species column to unspecified. then rollback the change
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


-- update the animals table by setting the species column to digimon for all animals that have a name ending in mon
-- update the animals table by setting the species column to pokemon for all animals that don't have species already set
BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pekomon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;


-- delete all records in the animals table, then roll back the change
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;


-- delete all animals born after Jan 1st, 2022, create a savepoint for the transaction, Update all animals' weight to be their weight multiplied by -1, Rollback to the savepoint.
-- After the rollback, update all animals' weights that are negative to be their weight multiplied by -1
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT born_after_Jan2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO born_after_Jan2022;
UPDATE animals SET weight_kg = weight_kg * -1 
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

--how many animals are there?
SELECT COUNT(*) FROM animals;
--how many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
--what is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
--who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
--what is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
--what is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;


--What animals belong to Melody Pond?
SELECT * FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';


--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

--List of all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id;

--How many animals are there per species?
SELECT S.name, COUNT(*)
FROM animals A
JOIN species S ON A.species_id = S.id
GROUP BY S.name;

--List all Digimon owned by Jennifer Orwell.
SELECT A.*
FROM animals A
JOIN owners O ON A.owner_id = O.id
JOIN species S ON A.species_id = S.id
WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.*
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0
AND O.full_name = 'Dean Winchester';


--Who owns the most animals?Sol
SELECT COUNT(*) as count, full_name
FROM animals as A
JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY count DESC;
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

--Who was the last animal seen by William Tatcher?
SELECT animals.name FROM visits 
JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name) FROM visits
JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM specializations
FULL OUTER JOIN vets ON vets.id = specializations.vet_id FULL OUTER JOIN species ON species.id = specializations.species_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(visits.date_of_visit) DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name FROM visits
JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith' GROUP BY animals.name, visits.date_of_visit ORDER BY visits.date_of_visit ASC LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM animals A
JOIN visits V ON A.id = V.animal_id JOIN vets ON vets.id = V.vet_id
ORDER BY V.date_of_visit DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(v.animal_id) AS "Number of Visits" FROM animals a 
JOIN visits v ON v.animal_id = a.id JOIN vets vet ON vet.id = v.vet_id JOIN species s ON s.id = a.species_id JOIN specializations sp ON sp.vet_id = vet.id JOIN species specialize ON specialize.id = sp.species_id 
WHERE s.name <> specialize.name;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name) as visits
FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY visits DESC LIMIT 1;

-- create queries to check performance

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4
CREATE INDEX visits_animals_id ON visits(animal_id);

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2
CREATE INDEX visits_vets_id ON visits(vet_id);

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
CREATE INDEX owners_email ON owners(email);

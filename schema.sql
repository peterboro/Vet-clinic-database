/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name varchar(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

/* Add column species of type string */
ALTER TABLE animals
ADD COLUMN species VARCHAR(50);


CREATE TABLE owners (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	full_name VARCHAR(50),
	age INT,
);

CREATE TABLE species (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
);

-- remove column species
ALTER TABLE animals
DROP COLUMN species,
ALTER TABLE animals
ADD species_id INT REFERENCES species(id)
ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id);


CREATE TABLE vets (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vets_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id)
);  

CREATE TABLE visits (
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE,
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
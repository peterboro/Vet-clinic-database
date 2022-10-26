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
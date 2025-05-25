CREATE DATABASE conservation_db;
--create rangers table
CREATE Table rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(100)
);
--create species table
CREATE Table species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status TEXT
);
--create sightings table
CREATE Table sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT,
    species_id INT,
    sighting_time DATE,
    location TEXT,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);

SELECT * FROM sightings;
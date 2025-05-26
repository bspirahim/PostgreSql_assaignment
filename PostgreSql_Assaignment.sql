CREATE DATABASE conservation_db;
--create rangers table
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(100) NOT NULL
);
--create species table
CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE,
    conservation_status TEXT
);
--create sightings table
CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(150) NOT NULL,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    FOREIGN KEY (species_id) REFERENCES species (species_id)
);
--insert data of rangers table
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );
--insert data of species table
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );
--insert data of sightings table
INSERT INTO
    sightings (
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

--Problem:1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

--Problem:2
SELECT count(DISTINCT species_id) as unique_species_count
from sightings;

--Problem:3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--Problem:4
SELECT name, count(sighting_id)AS total_sightings from sightings
JOIN rangers USING(ranger_id)
GROUP BY ranger_id, name;

--Problem:5
SELECT common_name from species LEFT JOIN sightings USING(species_id)
WHERE sightings.species_id is NULL;


--problem:6
SELECT common_name,sighting_time, name from sightings JOIN species USING(species_id) JOIN rangers using(ranger_id) ORDER BY sighting_time DESC LIMIT 2;

--Problem:7
UPDATE species set conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01' ;

--Problem:8
SELECT sighting_id,
CASE 
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM sighting_time) >= 18 THEN 'Evening'
      
END AS time_of_day 
FROM sightings

--Problem:9
DELETE FROM rangers WHERE ranger_id IN (SELECT ranger_id from rangers LEFT JOIN sightings USING(ranger_id)
WHERE sightings.ranger_id is NULL);


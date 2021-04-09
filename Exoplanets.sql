SELECT name
	FROM stars_table
	WHERE name LIKE 'Kepler%';

SELECT name
	FROM planets_table
	WHERE discovery_method_id = 2;

SELECT name
	FROM planets_table
	WHERE orbital_period >= 200 AND
		orbital_period <= 400;



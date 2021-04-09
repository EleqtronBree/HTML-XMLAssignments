-- QUESTION 1
SELECT country_table.name AS country, region_table.name AS region, resort_table.name AS resort
	FROM country_table
	INNER JOIN region_table
		ON country_table.id =
		region_table.country
	INNER JOIN resort_table
		ON region_table.id =
		resort_table.region
	ORDER BY country ASC;

-- QUESTION 2
SELECT country_table.name AS country, AVG(vertical_drop) AS average_vertical_drop
	FROM country_table
	INNER JOIN region_table
		ON country_table.id =
		region_table.country
	INNER JOIN resort_table
		ON region_table.id =
		resort_table.region
	GROUP BY country
	ORDER BY average_vertical_drop DESC

-- QUESTION 3
SELECT resort_table.name AS resort, (resort_table.vertical_drop/(resort_table.daily_price * country_table.exchange_rate)) AS value
	FROM resort_table
	INNER JOIN region_table
		ON region_table.id =
		resort_table.region
	INNER JOIN country_table
		ON country_table.id =
		region_table.country
	ORDER BY value DESC
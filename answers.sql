-- Tutorial 0

SELECT population FROM world
  WHERE name = 'Germany'

SELECT name, population FROM world
  WHERE name IN ( 'Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

  -- Tutorial 1

SELECT name FROM world
  WHERE name LIKE 'Y%'

SELECT name FROM world
  WHERE name LIKE '%y'

SELECT name FROM world
  WHERE name LIKE '%x%'

SELECT name FROM world
  WHERE name LIKE '%land'

SELECT name FROM world
  WHERE name LIKE 'C%ia'

SELECT name FROM world
  WHERE name LIKE '%oo%'

SELECT name FROM world
  WHERE name LIKE '%a%a%a%'

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name

SELECT name FROM world
 WHERE name LIKE '%o__o%%'

SELECT name FROM world
 WHERE name LIKE '____'

SELECT name
  FROM world
 WHERE name LIKE capital

 SELECT name
  FROM world
 WHERE capital LIKE concat(name, ' City')

SELECT capital, name
  FROM world
 WHERE capital LIKE concat(name, '%')

SELECT capital, name
FROM world
WHERE capital LIKE concat(name, '_%')

SELECT name,
REPLACE(capital, name, '') AS extension
FROM world
WHERE capital LIKE CONCAT(name, '_%');

-- Tutorial 2

SELECT name, continent, population FROM world

SELECT name
  FROM world
 WHERE population >= 200000000

SELECT name, gdp/population FROM world WHERE population >= 200000000

SELECT name, population/1000000 FROM world WHERE continent = 'South America'

SELECT name, population FROM world WHERE name = 'France' OR name = 'Germany' OR name = 'Italy'

SELECT name FROM world WHERE name LIKE 'United%'

SELECT name, population, area FROM world WHERE area > 3000000 OR population > 250000000

SELECT name, population, area FROM world WHERE (area > 3000000 OR population > 250000000) AND NOT (area > 3000000 AND population > 250000000)

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world WHERE continent = 'South America'

SELECT name, ROUND(gdp/population, -3) FROM world WHERE gdp >= 1000000000000 

SELECT name, capital FROM world WHERE LEN(name) = LEN(capital)

SELECT name, capital FROM world WHERE LEFT(name, 1) = LEFT(capital, 1) AND NOT name = capital

SELECT name
   FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND NOT name LIKE '% %'

-- Tutorial 3

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein'

SELECT winner FROM nobel WHERE yr >= 2000 AND subject = 'Peace'

SELECT yr, subject, winner FROM nobel WHERE subject = 'Literature' AND yr >= 1980 AND 1990 > yr

SELECT * FROM nobel
 WHERE winner = 'Theodore Roosevelt' 
OR winner = 'Woodrow Wilson'
OR winner = 'Jimmy Carter'
OR winner = 'Barack Obama'

SELECT winner FROM nobel WHERE winner LIKE 'John%'

SELECT yr, subject, winner FROM nobel WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984)

SELECT yr, subject, winner FROM nobel WHERE NOT subject = 'Chemistry' AND NOT subject = 'Medicine' AND yr = 1980

SELECT yr, subject, winner FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr > 2003)

SELECT yr, subject, winner FROM nobel WHERE winner LIKE '%Gr' + CHAR(252) + 'nberg'

SELECT yr, subject, winner FROM nobel WHERE winner = 'EUGENE O''NEILL'

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%'  ORDER BY yr DESC, winner ASC

SELECT winner, subject FROM nobel WHERE yr = 1984
ORDER BY 
CASE WHEN subject IN ('Chemistry','Physics') THEN 1 ELSE 0 END,
subject, winner

-- Tutorial 4

SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name = 'Russia')

SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

SELECT name, continent FROM world WHERE continent = (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))

SELECT name, population FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')

SELECT name, CONCAT(CONVERT(DOUBLE PRECISION, ROUND((population/(SELECT population FROM world WHERE name = 'Germany')) * 100, 0)), '%') AS percentage FROM world WHERE continent = 'Europe'

SELECT name FROM world WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe')

SELECT continent, name, area FROM world WHERE 
area = (SELECT MAX(area) FROM world WHERE continent = 'Europe') OR 
area = (SELECT MAX(area) FROM world WHERE continent = 'Africa') OR 
area = (SELECT MAX(area) FROM world WHERE continent = 'North America') OR 
area = (SELECT MAX(area) FROM world WHERE continent = 'South America') OR 
area = (SELECT MAX(area) FROM world WHERE continent = 'Oceania') OR
area = (SELECT MAX(area) FROM world WHERE continent = 'Asia') OR
area = (SELECT MAX(area) FROM world WHERE continent = 'Eurasia') OR
area = (SELECT MAX(area) FROM world WHERE continent = 'Caribbean') 

SELECT continent, name FROM world WHERE 
name = (SELECT TOP 1 name FROM world WHERE continent = 'Europe')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'Asia')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'North America')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'South America')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'Oceania')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'Eurasia')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'Caribbean')
OR
name = (SELECT TOP 1 name FROM world WHERE continent = 'Africa')

SELECT name, continent, population FROM world a
WHERE 25000000 >= ALL(SELECT population FROM world b WHERE b.continent LIKE a.continent)

-- MISSING EXERCISE 10

-- Tutorial 5

SELECT SUM(population)
FROM world

SELECT DISTINCT continent FROM world

SELECT SUM(gdp) FROM world WHERE continent = 'Africa'

SELECT COUNT(name) FROM world WHERE area >= 1000000

SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

SELECT DISTINCT continent, COUNT(name) FROM world WHERE population > 10000000 GROUP BY continent

SELECT continent FROM world GROUP BY continent HAVING SUM(population)>100000000

-- Tutorial 6
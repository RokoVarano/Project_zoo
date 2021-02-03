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

SELECT matchid, player FROM goal WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game WHERE id=1012

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid) WHERE player LIKE '%Mario%'

SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON teamid = id WHERE gtime<=10

SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE coach = 'Fernando Santos'

SELECT player FROM game JOIN goal ON (id = matchid) WHERE stadium = 'National Stadium, Warsaw'

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id WHERE (team1 = 'GER' OR team2 = 'GER') AND (goal.teamid != 'GER')

SELECT teamname, COUNT(player) FROM eteam JOIN goal ON teamid=eteam.id  GROUP BY teamname

SELECT stadium, COUNT(player) FROM game JOIN goal ON (game.id = goal.matchid) GROUP BY stadium

SELECT matchid, mdate, COUNT(player) FROM game JOIN goal ON 

SELECT matchid, mdate, COUNT(player) FROM game JOIN goal ON (teamid = team1 OR teamid = team2) GROUP BY matchid WHERE (team1 = 'POL' OR team2 = 'POL')

SELECT matchid, mdate, goals FROM (SELECT matchid, COUNT(*) AS goals FROM goal GROUP BY matchid) AS x JOIN game ON matchid=id WHERE (team1 = 'POL' OR team2 = 'POL')

SELECT matchid, mdate, goals FROM game JOIN (SELECT matchid, COUNT(*) AS goals FROM goal WHERE teamid = 'GER' GROUP BY matchid) AS gergoals ON id=matchid

SELECT mdate, team1, score FROM 

-- MISSING EXERCISE 13

-- Tutorial 7

SELECT id, title FROM movie WHERE yr = 1962

SELECT yr FROM movie WHERE title = 'Citizen Kane'

SELECT id, title, yr FROM movie WHERE title LIKE 'Star Trek%'

SELECT id FROM actor WHERE name = 'Glenn Close'

SELECT id FROM movie WHERE title = 'Casablanca'

SELECT name FROM casting JOIN actor ON (id = actorid) WHERE movieid = 27

SELECT name FROM
(SELECT actorid FROM (SELECT id FROM movie WHERE title = 'Alien') as movie
JOIN
casting
ON
(movieid=id)) as a
JOIN
actor
ON
(actorid = id)

SELECT title FROM 
(SELECT title, actorid FROM movie JOIN casting ON id = movieid) as a
JOIN
actor
ON actorid = id
WHERE name = 'Harrison Ford'

SELECT title FROM 
(SELECT title, actorid FROM movie JOIN casting ON id = movieid 
WHERE ord != 1) as a
JOIN
actor
ON actorid = id
WHERE name = 'Harrison Ford'

SELECT title, name FROM 
(SELECT title, actorid FROM movie JOIN casting ON id = movieid 
WHERE ord = 1 AND yr = 1962) as a
JOIN
actor
ON actorid = id

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Doris Day'
GROUP BY yr
HAVING COUNT(title) > 2

SELECT title, name FROM
movie JOIN casting ON (movieid = movie.id AND ord = 1)
      JOIN actor ON (actorid = actor.id)
WHERE movie.id IN (
  SELECT movieid FROM casting WHERE actorid IN (
    SELECT id FROM actor WHERE name = 'Julie Andrews'
  )
)

SELECT name FROM actor JOIN
(SELECT actorid, SUM(ord) AS starring FROM casting  WHERE ord = 1 GROUP BY actorid) AS a
ON id = actorid
WHERE starring > 14
ORDER BY name

SELECT title, castsize FROM movie JOIN
(SELECT movieid, COUNT(actorid) AS castsize FROM casting GROUP BY movieid) as a
ON id = movieid
WHERE yr = 1978
ORDER BY castsize DESC, title

SELECT name FROM actor JOIN
(SELECT actorid FROM casting JOIN
(SELECT movieid FROM movie JOIN 
(SELECT movieid, actorid FROM casting WHERE actorid = 2064) AS a
ON id = movieid) AS b
ON casting.movieid = b.movieid) AS c
ON id = actorid
WHERE name != 'Art Garfunkel'

--Tutorial 8


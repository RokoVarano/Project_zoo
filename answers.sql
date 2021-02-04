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

SELECT name, continent FROM world w
  WHERE population >= ALL(SELECT population*3
                         FROM world y
                         WHERE w.continent = y.continent
                         and y.name != w.name)

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

SELECT DISTINCT mdate, team1,	
SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, team2,
SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game
LEFT JOIN goal ON game.id = goal.matchid
GROUP BY id, mdate, team1, team2

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

SELECT name FROM teacher WHERE dept IS NULL

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher

SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON dept.id = teacher.dept

SELECT COUNT(*), COUNT(mobile) from teacher

SELECT DISTINCT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept GROUP BY dept.name

SELECT name, CASE
WHEN dept IN (1, 2) THEN 'Sci'
ELSE 'Art'
END
FROM teacher

SELECT name, CASE
WHEN dept IN (1, 2) THEN 'Sci'
WHEN dept =3 THEN 'Art'
ELSE 'None'
END
FROM teacher

-- Tutorial 9

SELECT COUNT(*) FROM stops

SELECT id FROM stops WHERE name = 'Craiglockhart'

SELECT id, name FROM stops JOIN route ON stop = id WHERE num = '4' AND company = 'LRT'

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num HAVING COUNT(*) = 2

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'AND stopb.name = 'London Road'

SELECT DISTINCT a.* FROM 
(SELECT company, num FROM route WHERE stop = 115) AS a
INNER JOIN
(SELECT company, num FROM route WHERE stop = 137) AS b
ON a.num = b.num

SELECT Craig.company, Craig.num FROM
(SELECT * FROM stops JOIN route ON stop = id WHERE name = 'Craiglockhart') as Craig
INNER JOIN
(SELECT * FROM stops JOIN route ON stop = id WHERE name = 'Tollcross') as Toll
ON Craig.num = Toll.num

SELECT a.name, a.company, a.num FROM 
(SELECT name, company, num FROM stops JOIN route ON stop = id) as a
INNER JOIN
(SELECT num FROM stops JOIN route ON stop = id WHERE name = 'Craiglockhart') as b
ON a.num = b.num
WHERE company = 'LRT'
ORDER BY name

SELECT DISTINCT c.num, c.company, stops.name, l.num, l.company
FROM
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Craiglockhart')
) AS c
  JOIN
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Lochend')
) AS l
ON (c.stop = l.stop)
JOIN stops ON(stops.id = c.stop)
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    second_name VARCHAR(50),
    team_name VARCHAR(50),
    position VARCHAR(20),
    price DECIMAL(4,1),
    points INT,
    minutes_played INT,
    ppg FLOAT,
    value_ratio FLOAT,
    selected_percent FLOAT,
    form FLOAT,
    transfers_in INT,
    transfers_out INT,
    influence FLOAT,
    creativity FLOAT,
    threat FLOAT
);

-- TOP PLAYERS TO SCORE POINTS
SELECT first_name, team_name, position, points from players
order by points desc limit 10; 

-- TOP PLAYERS TO PLAY BY AMOUNT OF MINITUES PLAYED
SELECT first_name, team_name, minutes_played from players
order by minutes_played desc limit 10;

-- TOP PLAYERS BY VALUE RATIO HAVING PLAYED MINIMUM OF 1000 MINUTES
SELECT first_name, team_name, value_ratio from players
where minutes_played >= 1000
order by value_ratio desc limit 10;

-- TOP PLAYERS BY PPG BY POSITION
SELECT first_name, team_name, ppg, position
FROM (
  SELECT 
    first_name,
    team_name,
    ppg,
    position,
    ROW_NUMBER() OVER (PARTITION BY position ORDER BY ppg DESC) AS star
  FROM players
) AS ranked_players
WHERE star <= 10;

-- TOP TEAMS BY TOTAL CREATIVE OUTPUT OF FIRST 11 PLAYERS BY MINUTES PLAYED
SELECT team_name, SUM(creativity) from (
select team_name, minutes_played, creativity,
ROW_NUMBER() over (partition by team_name order by minutes_played desc) as top
from players) as ranked
where top <= 11
group by team_name
order by sum(creativity) desc;














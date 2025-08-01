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

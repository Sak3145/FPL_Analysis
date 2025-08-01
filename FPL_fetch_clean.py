import requests
import pandas as pd

# API data
url = "https://fantasy.premierleague.com/api/bootstrap-static/"
response = requests.get(url)
data = response.json()

# Extract key parts
players = pd.DataFrame(data["elements"])
teams = pd.DataFrame(data["teams"])
positions = pd.DataFrame(data["element_types"])

# team and position names
players["team_name"] = players["team"].map(teams.set_index("id")["name"])
players["position"] = players["element_type"].map(positions.set_index("id")["singular_name"])

# important columns
players_clean = players[[
    "id", "first_name", "second_name", "team_name", "position",
    "now_cost", "total_points", "minutes", "points_per_game",
    "value_season", "selected_by_percent", "form", "transfers_in", "transfers_out",
    "influence", "creativity", "threat"
]]

# Rename columns for clarity
players_clean.rename(columns={
    "id": "player_id",
    "now_cost": "price_tenths", 
    "total_points": "points",
    "minutes": "minutes_played",
    "value_season": "value_ratio",
    "points_per_game": "ppg",
    "selected_by_percent": "selected_percent"
}, inplace=True)

# Convert price to actual price
players_clean["price"] = players_clean["price_tenths"] / 10
players_clean.drop(columns=["price_tenths"], inplace=True)

# CSV
players_clean.to_csv("C:/Users/DELL/Desktop/datasets/fpl_cleaned.csv", index=False)
print("FPL Cleaned dataset saved as fpl_cleaned.csv")

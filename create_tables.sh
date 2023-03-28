#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

echo -e '\nDROPPING TABLES\n'
echo $($PSQL "DROP TABLE games, teams")

echo -e '\nCREATING TABLES\n'
echo $($PSQL "CREATE TABLE 
teams(
  team_id SERIAL PRIMARY KEY,name TEXT UNIQUE NOT NULL
)")

echo $($PSQL "CREATE TABLE
games(
  game_id SERIAL PRIMARY KEY, year INT NOT NULL, round VARCHAR NOT NULL, winner_id INT NOT NULL, opponent_id INT NOT NULL,
  winner_goals INT NOT NULL, opponent_goals INT NOT NULL
)")
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY(winner_id) REFERENCES teams(team_id)")
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY(opponent_id) REFERENCES teams(team_id)")

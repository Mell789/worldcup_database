#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e '\nInserting data...\n'
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $WINNER != 'winner' ]]
  then
    echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")

    # get team_id for winner and opponent
    team_id_winner=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    team_id_opponent=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")


    echo $($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) 
    VALUES($YEAR,'$ROUND',$team_id_winner,$team_id_opponent,$WINNER_GOALS,$OPPONENT_GOALS)")

  fi
done

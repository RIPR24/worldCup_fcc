#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.



cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WG OG
do
  if [[ $YEAR != 'year' ]]
  then
    INSW=$($PSQL "SELECT * FROM teams WHERE name = '$WINNER'")
    if [[ -z $INSW ]]
    then
      INS=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
      #if($INS == '')
    fi

    INSO=$($PSQL "SELECT * FROM teams WHERE name = '$OPP'")
    if [[ -z $INSO ]]
    then
      INSE=$($PSQL "INSERT INTO teams (name) VALUES ('$OPP')")
      #if($INS == '')
    fi

  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WG OG
do
  if [[ $YEAR != 'year' ]]
  then
  WIN=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
  OP=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPP'")

  IN=$($PSQL "INSERT INTO games (year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($YEAR, '$ROUND', $WIN, $OP, $WG, $OG)")
  fi
done

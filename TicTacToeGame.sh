#!/bin/bash 
echo "Welcome to Tic Tac Toe Game"

#Constant Variable
MAX_POSITION=9
PLAYER=1

#variables
playerSymbol=''
computerSymbol=''

#Array
declare -a boardPosition

function freshBoard()
{
	for (( i=1; i<=$MAX_POSITION; i++ ))
	do
		boardPosition[$i]=$i
	done
}

function symbolAssignment()
{
	randomTurn=$((RANDOM%2))

	if [ $randomTurn -eq $PLAYER ]
	then
		playerSymbol='X'
		computerSymbol='O'
		echo "Player symobol : X | Computer symbol : O"
		echo "Player Plays First"
	else
		 playerSymbol='O'
		 computerSymbol='X'
		echo "Player symobol : O | Computer symbol : X"
		echo "Computer Plays First"
	fi
}

freshBoard
symbolAssignment

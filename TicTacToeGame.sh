#!/bin/bash 
echo "Welcome to Tic Tac Toe Game"

#Constant Variable
MAX_POSITION=9
PLAYER=1
SIZE=3

#variables
playerSymbol=''
computerSymbol=''
playerPosition=0

#Array
declare -a boardPosition

function freshBoard()
{
	for (( i=1; i<=$MAX_POSITION; i++ ))
	do
		boardPosition[$i]=0
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

function displayBoard()
{
        n=1
        printf '      /-------|-------|-----\\ \n'
        for (( i=1; i<=$SIZE; i++ ))
        do
                for (( j=1; j<=$SIZE; j++ ))
                do
                        printf '\t'
                        printf '%s' "${boardPosition[$n]}"
                        n=$(( $n + 1 ))
                done
                printf '\n'
        done
        printf '      /-------|-------|-----\\ \n'
}



function playerInput()
{
	read -p "Enter Position Number to put $playerSymbol at Empty Position :" playerPosition
	if [ ${boardPosition[$playerPosition]} == '0' ]
	then
		boardPosition[$playerPosition]=$playerSymbol
	else
		echo "Oh ho! Position Occupied! Please Enter New Position"
		playerInput
	fi
}

freshBoard
symbolAssignment
displayBoard
playerInput

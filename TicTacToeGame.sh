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

#boolean Flags
oneWon=false

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
	displayBoard
	playerInput
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

#Checking Horizontal[Row] To Win Game
function checkHorizontalToWin()
{
	counter=1
	while [ true ]
	do
		i=0
		for (( j=1; j<=$SIZE; j++ ))
		do
			i=$(($i+1))
			if [[ ${boardPosition[$i]} == ${boardPosition[$i+1]} ]] && [[  ${boardPosition[$i+1]}  ==  ${boardPosition[$i+2]} ]] && [[ ${boardPosition[$i+2]} == $1 ]]
			then
				echo "Player Won"
				oneWon=true
				break
			fi
			i=$(($i+2))
			counter=$(($counter+1))
	                if [ $counter -eq 3 ]
        	        then
                	        break
                	fi
		done
		break
	done
}

#checking Vertical[Column] win Game
function checkVerticalToWin()
{
	counter=1
	while [ true ]
	do
		i=0
		for (( j=1; j<=$SIZE; j++ ))
		do
			i=$(($i+1))
			if [[ ${boardPosition[$i]} == ${boardPosition[$i+3]} ]] && [[  ${boardPosition[$i+3]}  ==  ${boardPosition[$i+6]} ]] && [[ ${boardPosition[$i+6]} == $1 ]]
			then
				displayBoard
				echo " Player Won "
				oneWon=true
				break
			fi
			i=$(($i+2))
			counter=$(($counter+1))
			if [ $counter -eq 3 ]
			then
				break
			fi
		done
		break
	done
}

#Checking Horizontal[Row] To Win Game
function checkDiagonalToWin()
{
       
        counter=1
        while [ true ]
        do
		i=0
                for (( j=1; j<=$SIZE; j++ ))
                do
                        i=$(($i+1))
                	if [[ ${boardPosition[$i]} == ${boardPosition[$i+4]} ]] && [[  ${boardPosition[$i+4]}  ==  ${boardPosition[$i+8]} ]] && [[ ${boardPosition[$i+8]} == $1 ]]
 	               	then
                        	echo "Player Won"
                        	oneWon=true
                        	break
			elif [[ ${boardPosition[$i+2]} == ${boardPosition[$i+4]} ]] && [[  ${boardPosition[$i+4]}  ==  ${boardPosition[$i+6]} ]] && [[ ${boardPosition[$i+6]} == $1 ]]
                	then 
				echo "Player Won"
                                oneWon=true
                                break
			fi
			i=$(($i+2))
                	counter=$(($counter+1))
                	if [ $counter -eq 3 ]
                	then
                       		break
                	fi
        	done
		break
        done
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



function checkGameTie()
{
	count=1
	while [[ ${boardPosition[$count]} != 0 ]]
	do
		if [ $count -eq $MAX_POSITION ]
		then
			displayBoard
			echo "Game Is tie"
			oneWon=true
			break
		else
			count=$(($count+1))
		fi
	done
}





#-------------------------MAIN-----------------


freshBoard
symbolAssignment

while [[ $oneWon == false ]]
do
	displayBoard
	playerInput
	checkHorizontalToWin $playerSymbol
	checkVerticalToWin $playerSymbol
	checkDiagonalToWin $playerSymbol
	checkGameTie
done
displayBoard


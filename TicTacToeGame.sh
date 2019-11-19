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
play=false

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
		play=true
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
	play=false
}

function computerInput()
{
	computerPosition=$((RANDOM%9+1))
	if [ ${boardPosition[$computerPosition]} == 0 ]
	then
		boardPosition[$computerPosition]=$computerSymbol
	else
		computerInput
		computerTurn 
	fi
	play=true
}

function computerTurn()
{
	boardPosition[$value]=$computerSymbol
}


#Checking Horizontal[Row] To Win Game
function checkHorizontalToWin()
{
	i=1
	for (( j=1; j<=$SIZE; j++ ))
	do
		if [[ ${boardPosition[$i]} == ${boardPosition[$i+1]} ]] && [[  ${boardPosition[$i+1]}  ==  ${boardPosition[$i+2]} ]] && [[ ${boardPosition[$i+2]} == $playerSymbol ]]
		then
			echo "$1 Won"
			oneWon=true
			break
		else
			checkHorizontalMove
		fi
			i=$(($i+3))
	done
}

#checking Vertical[Column] win Game
function checkVerticalToWin()
{
	i=1
	for (( j=1; j<=$SIZE; j++ ))
	do
		if [[ ${boardPosition[$i]} == ${boardPosition[$i+3]} ]] && [[  ${boardPosition[$i+3]}  ==  ${boardPosition[$i+6]} ]] && [[ ${boardPosition[$i+6]} == $1 ]]
		then
			displayBoard
			echo " $1 Won "
			oneWon=true
			break
		else
			checkVerticalMove
		fi
			i=$(($i+1))
		done
}

#Checking Horizontal[Row] To Win Game
function checkDiagonalToWin()
{
	i=1
       	if [[ ${boardPosition[$i]} == ${boardPosition[$i+4]} ]] && [[  ${boardPosition[$i+4]}  ==  ${boardPosition[$i+8]} ]] && [[ ${boardPosition[$i+8]} == $1 ]]
        then
		echo "$1 Won"
                oneWon=true
	elif [[ ${boardPosition[$i+2]} == ${boardPosition[$i+4]} ]] && [[  ${boardPosition[$i+4]}  ==  ${boardPosition[$i+6]} ]] && [[ ${boardPosition[$i+6]} == $1 ]]
        then 
		echo "Player Won"
                oneWon=true
	else
		checkDiagonalMove
		checkDiagonalTurnMove
	fi
}

function checkHorizontalMove()
{
        if [[  ${boardPosition[$i]}  ==  $playerSymbol ]] && [[ ${boardPosition[$i]} == ${boardPosition[$i+1]} ]]
        then
                value=$(($i+2))
		echo "Position $value is blank"
        elif [[  ${boardPosition[$i]}  ==  $playerSymbol ]] && [[ ${boardPosition[$i]} == ${boardPosition[$i+2]} ]]
        then
		value=$(($i+1))
                echo "Position $(($value)) is Blank"
        elif [[  ${boardPosition[$i+1]}  ==  $playerSymbol ]] &&  [[ ${boardPosition[$i+1]} == ${boardPosition[$i+2]} ]]
        then
		value=$(($i))
                echo "Position $value is Blank" 
        	computerInput
	fi
}

function checkVerticalMove()
{
        if [[ ${boardPosition[$i]} == $playerSymbol ]] && [[  ${boardPosition[$i]}  ==  ${boardPosition[$i+3]} ]]
        then
		value=$(($i+6))
                echo "Position $value is Blank"
	elif [[  ${boardPosition[$i]}  ==  $playerSymbol ]] && [[ ${boardPosition[$i]} == ${boardPosition[$i+6]} ]]
        then
		value=$(($i+3))
                echo "Position $value is Blank"
        elif [[  ${boardPosition[$i+3]}  ==  $playerSymbol ]] &&  [[ ${boardPosition[$i+3]} == ${boardPosition[$i+6]} ]]
        then
		value=$(($i))
                echo "Position $value is Blank" 
        fi
}

function checkDiagonalMove()
{
	if [[ ${boardPosition[$i]} == $playerSymbol ]] && [[  ${boardPosition[$i]}  ==  ${boardPosition[$i+4]} ]]
        then
		value=$(($i+8))
                echo "Position $value is Blank"
        elif [[  ${boardPosition[$i]}  ==  $playerSymbol ]] && [[ ${boardPosition[$i]} == ${boardPosition[$i+8]} ]]
        then
		value=$(($i+4))
                echo "Position $value is Blank"
        elif [[  ${boardPosition[$i+4]}  ==  $playerSymbol ]] &&  [[ ${boardPosition[$i+4]} == ${boardPosition[$i+8]} ]]
        then
		value=$(($i))
                echo "Position $value is Blank" 
        fi
}

function checkDiagonalTurnMove()
{
	if [[ ${boardPosition[$i+2]} == $playerSymbol ]] && [[  ${boardPosition[$i+2]}  ==  ${boardPosition[$i+4]} ]]
        then
		value=$(($i+6))
                echo "Position $value is Blank"
        elif [[  ${boardPosition[$i+2]}  ==  $playerSymbol ]] && [[ ${boardPosition[$i+2]} == ${boardPosition[$i+6]} ]]
        then
		value=$(($i+4))
                echo "Position $value is Blank"
        elif [[  ${boardPosition[$i+4]}  ==  $playerSymbol ]] &&  [[ ${boardPosition[$i+4]} == ${boardPosition[$i+6]} ]]
        then
		value=$(($i+2))
                echo "Position $value is Blank"
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

function checkWin()
{
	symbol=$1
	checkHorizontalToWin $playerSymbol
        checkVerticalToWin $playerSymbol 
        checkDiagonalToWin $playerSymbol
	checkGameTie

}
#-------------------------MAIN-----------------


freshBoard
symbolAssignment

while [ $oneWon == false ]
do
	displayBoard
	if [ $play == true ]
	then
		playerInput
		checkWin $playerSymbol
	else
		computerInput
		checkWin $computerSymbol
	fi

done

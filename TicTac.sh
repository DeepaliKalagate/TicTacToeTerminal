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
computerPosition=0

#boolean Flags
oneWon=false
play=false
computerMove=false


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

function computerInput()
{
	computerMove=false
	echo "***Computer Is Playing***"
	winOrBlockPosition $computerSymbol
	winOrBlockPosition $playerSymbol
	checkCorner
	if [ $computerMove == false ]
	then
		computerPosition=$((RANDOM%9+1))
	fi
	play=true
	displayBoard
}


function winOrBlockPosition()
{
	rowValue=1
	columnValue=3
	leftDiagonalValue=4
	rightDiagonalValue=2

	checkTheWinPosition $rowValue $1 $columnValue
	checkTheWinPosition $columnValue $1 $rowValue
	checkTheWinPosition $leftDiagonalValue $1 0
	checkTheWinPosition $rightDiagonalValue $1 0

}

function checkTheWinPosition()
{
	counterValue=1
	symbol=$2
	if [ $computerMove = false ]
	then
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${boardPosition[$counterValue]} == ${boardPosition[$counterValue+$1+$1]} ]] && [[ ${boardPosition[$counterValue+$1]} == 0 ]] && [[ ${boardPosition[$counterValue]} == $symbol ]]
			then
				computerPosition=$(($counterValue+$1))
				boardPosition[$computerPosition]=$computerSymbol
				computerMove=true
				break
			elif [[  ${boardPosition[$counterValue]} == ${boardPosition[$counterValue+$1]} ]] && [[  ${boardPosition[$counterValue+$1+$1]} == 0 ]] && [[ ${boardPosition[$counterValue]} == $symbol ]]
			then
				computerPosition=$(($counterValue+$1+$1))
				boardPosition[$computerPosition]=$computerSymbol
				computerMove=true
				break
			elif [[ ${boardPosition[$counterValue+$1]} == ${boardPosition[$counterValue+$1+$1]} ]] && [[ ${boardPosition[$counterValue]} == 0 ]] && [[ ${boardPosition[$counterValue+$1]} == $symbol ]]
			then
				computerPosition=$counterValue
				boardPosition[$computerPosition]=$computerSymbol
				computerMove=true
				break
			fi
			counterValue=$(($counterValue+$3))
		done
	fi
}

function checkCorner()
{
	if [ $computerMove = false ]
	then
		for((i=1; i<=MAX_POSITION; i=$(($i+2)) ))
		do
			if [ ${boardPosition[$i]} == 0 ]
			then
				computerPosition=$i
            			boardPosition[$computerPosition]=$computerSymbol
            		break
			fi
			if [ $i -eq 3 ]
			then
				i=$(($i+2))
			fi
		done
	fi
}


#Checking Horizontal[Row] To Win Game
function checkHorizontalToWin()
{
	i=1
	for (( j=1; j<=$SIZE; j++ ))
	do
		if [[ ${boardPosition[$i]} == ${boardPosition[$i+1]} ]] && [[  ${boardPosition[$i+1]}  ==  ${boardPosition[$i+2]} ]] && [[ ${boardPosition[$i+2]} == $1 ]]
		then
			echo "$1 Won"
			oneWon=true
			break
		fi
			i=$(($i+3))
	done
	computerMove=true
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
		fi
			i=$(($i+1))
		done
	computerMove=true
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
		echo "$1 Won"
                oneWon=true
	fi
}

function checkGameTie()
{
        count=1
        while [[ ${boardPosition[$count]} != 0 ]]
        do
                if [ $count -eq $MAX_POSITION ]
                then
                        displayBoard
                        echo "Ohho! Game Is Tie"
                        oneWon=true
                        computerMove=true
                        break
                else
                        count=$(($count+1))
                fi
        done
}

function checkWin()
{
	symbol=$1
	rowValue=1
	columnValue=3

	checkHorizontalToWin $symbol $columnValue  $rowValue
 	checkVerticalToWin $symbol $rowValue $columnValue
	checkDiagonalToWin $symbol
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
		checkGameTie
	else
		computerInput
		checkWin $computerSymbol
		checkGameTie
	fi

done

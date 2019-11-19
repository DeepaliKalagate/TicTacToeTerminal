#!/bin/bash -x
echo "Welcome to Tic Tac Toe Game"

#Constant Variable
MAX_POSITION=9

#Array
declare -a boardPosition

function freshBoard()
{
	for (( i=1; i<=$MAX_POSITION; i++ ))
	do
		boardPosition[$i]=$i
	done
}

freshBoard

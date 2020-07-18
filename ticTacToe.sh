#! /bin/bash
echo "============TIE TAC TOE ==============="
ROW_SIZE=3
BOARD_SIZE=$((ROW_SIZE*ROW_SIZE))
Position=0
userSymbol="0"
compSymbol="0"
declare -A board

function resetBoard() {
	for (( position=1; position<=$BOARD_SIZE; position++ ))
	do
		board[$position]=0
	done
}

function randomGenerator() {
	randomCheck=$((RANDOM%2))
}

function assignSymbol(){
	randomGenerator
	if [ "$randomCheck" == "$userSymbol" ]
	then
		userSymbol="X"
	else
		compSymbol="X"
	fi
	echo "Player Symbol is $userSymbol and Computer_Symbol is $compSymbol "

}

function tossFirstPlayer(){
	case $(($RANDOM%2)) in
		0)	firstPlayer=human
			echo "HUMAN has won the Toss";;
		1)	firstPlayer=Computer
			echo "COMPUTER has won the Toss";;
	esac
}

function displayBoard(){
	for (( count=1; count<=$BOARD_SIZE; count++ ))
   do
   	if [[ "${board[$count]}" -eq "0" ]]
      then
   	   printf _"|"
      else
         printf ${board[$count]}" "
      fi
      if [ $(( $count % $ROW_SIZE )) -eq 0 ]
      then
      	echo
      fi
	done
}

function playerInputChecker(){
	restBoard
	assignSymbol
	validator=false
	while [ $validator -eq false ]
	do
	displayBoard
	echo "Choose a cell for your $userSymbol "
	read -p "Enter the choice in range 1 - $BOARD_SIZE : " inputPosition
	if [ $inputPosition -gt 0 -a $inputPosition -le $BOARD_SIZE ]
	then
		echo "Valid choice  $inputPosition in range"
		validator=true
		if [ validator -eq true -a ${board[$index]} -eq 0 ]
		then
			board[inputPosition]=$userSymbol
		fi
	else
		echo "Invalid position out of range"
	fi
	done
}

function columnChecker(){
	count=0
	for(( column=1; column<=$ROW_SIZE; column++ ))
	do
		for(( row=0; row<=$ROW_SIZE; row++ ))
		do
				index=$(($ROW_SIZE*row+column))
				if [ ${board[$index]}==$1 ]
				then
					(( count++ ))
				fi
		done
		if [ $count -eq $ROW_SIZE ]
		then
			winner $1
			quit=true
		fi
	done
}

function rowChecker(){
	count=0
   for(( row=0; row<=$ROW_SIZE; row++ ))
   do
		for(( column=1; column<=$ROW_SIZE; column++ ))
      do
      	index=$(($ROW_SIZE*row+column))
         if [ ${board[$index]}==$1 ]
         then
         	(( count++ ))
         fi
      done
      if [ $count -eq $ROW_SIZE ]
      then
      	winner $1
         quit=true
      fi
	done
}

function diagonalEndingTopRight(){
	for (( position=1; position<=$BOARD_SIZE; position+=$((ROW_SIZE+1)) ))
	do
		if [ ${board[$position]} -eq $1 ]
		then
			((count++))
		fi
	done
	if [ $count -eq $ROW_SIZE ]
	then
		winner $1
		quit=true
	fi
}

function diagonalEndingTopLeft(){
	for (( position=$ROW_SIZE; position<=$((BOARD_SIZE+1-ROW_SIZE)); position+=$((ROW_SIZE-1)) ))
	do
		if [ ${board[$position]} -eq $1 ]
		then
			((count++))
		fi
	done
	if [ $count -eq $BOARD_SIZE ]
	then
		winner $1
		quit=true
	fi

}

function winnerChecker(){
	columnChecker $1
	rowChecker $1
	diagonalEndingTopRight $1
	diagonalEndingTopLeft $1
}

function staticSign(){
	echo $1
	winner $1
}

function winner(){
	if [ $1 -eq $userSymbol ]
	then
		echo "USER WINS the game"
	else
		echo "COMPUTER WINS the Game"
	fi
}

execute=$( staticSign $userSymbol )
echo $execute



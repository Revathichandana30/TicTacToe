#! /bin/bash
echo "============TIE TAC TOE ==============="
ROW_SIZE=3
BOARD_SIZE=$((ROW_SIZE*ROW_SIZE))
Position=0
declare -A ticBoard

function resetBoard() {
	for (( position=1; position<=$BOARD_SIZE; position++ ))
	do
		ticBoard[$position]=0
	done
}

function tossFirstPlayer(){
	case $(($RANDOM%2)) in
		0)	firstPlayer=human
			echo "HUMAN has won the Toss";;
		1) firstPlayer=Computer
			echo "COMPUTER has won the Toss";;
	esac

}

tossFirstPlayer

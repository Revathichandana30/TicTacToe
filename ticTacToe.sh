#! /bin/bash
echo "============TIE TAC TOE ==============="
declare -a boardElements

function resetBoard(){
	for((row=1;row<=3;row++))
	do
		for((column=1;column<=3;column++))
		do
         boardElements[$row$column]="-";
		done
   done
}

function selectPlayer(){
	case $((RANDOM%2)) in
		0) echo "persons starts the gamme";
			startPerson=player;;
		1) echo "computer Starts the game";
			startPerson=computer;;
	esac
}

function assignLetters(){
	playerLetter=O;computerLetter=O
	selectLetter
	if [[ $letter =~ $playerLetter  ]]
	then
		computerLetter=X;
	else
		playerLetter=X;
	fi
	echo "player letter : $playerLetter and computer letter : $computerLetter"
}

function selectLetter(){
	case $((RANDOM%2)) in
		0) letter=O;;
		1) letter=X;;
	esac
}
resetBoard
selectPlayer
assignLetters

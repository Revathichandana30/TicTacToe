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
	playerLetter=O;computerLetter=O;
	if [[ $1 =~ $playerLetter  ]]
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

function displayBoard(){
	for((row=1;row<=3;row++))
   do
   	for((column=1;column<=3;column++))
      do
         printf "| ${boardElements[$row$column]} |"
      done
      echo -e "\n-------------- "
   done

}

function checkPosition(){
	if [[ ($1 -gt 0) && ($1 -le 3) && ($2 -gt 0) && ($2 -le 3) ]]
	then
		echo "valid input"
	else
		echo "invalid input"
	fi
}

function playerInputCheck(){
	displayBoard;
	assignLetters $selectLetter;
	read -p "enter the position in the matrix:" rowPosition columnPosition
	checkPosition $rowPosition $columnPosition
}
resetBoard
playerInputCheck

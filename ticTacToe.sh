#! /bin/bash
echo "============TIE TAC TOE ==============="
declare -a boardElements
PLAYER_LETTER=O;
COMPUTER_LETTER=O;
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
	if [[ $1 =~ $playerLetter  ]]
	then
		COMPUTER_LETTER=X;
	else
		PLAYER_LETTER=X;
	fi
	echo "player letter : $PLAYER_LETTER and computer letter : $COMPUTER_LETTER"
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

function rowCrossed(){
	for ((row=1;row<=3;row++))
	do
		column=1;
		if [[ (${boardElements[$row$column]} =~ ${boardElements[$row$(($column+1))]}) && (${boardElements[$row$column]} =~ ${boardElements[$row$(($column+2))]}) ]]
		then
			echo 1;break;
		fi
	done
}

function columnCrossed(){
   for ((column=1;column<=3;column++))
   do
      row=1;
      if [[ (${boardElements[$row$column]} =~ ${boardElements[$(($row+1))$column]}) && (${boardElements[$row$column]} =~ ${boardElements[$(($row+2))$column]}) ]]
      then
         echo 1;break;
		fi
   done
}

function diagonalCrossed(){
	if [[ (${boardElements[11]} =~ ${boardElements[22]}) && (${boardElements[11]} =~ ${boardElements[33]}) ]]
	then
   	echo 1;break;
	fi
   if [[ (${boardElements[13]} =~ ${boardElements[22]}) && (${boardElements[22]} =~ ${boardElements[31]}) ]]
   then
      echo 1;break;
   fi
}

function winCheck(){
	row=`rowCrossed`;column=`columnCrossed`;diagonal=`diagonalCrossed`;
	if [[ ($row -eq 1) || ($column -eq 1) || ($diagonal -eq 1) ]]
	then
		echo 1;
	fi
}

function tieCheck(){
	for((row=1;row<=3;row++))
	do
		for((column=1;column<=3;column++))
		do
			if [[ ${boardElements[$row$column]} =~ ^([-])$ ]]
			then
				echo 1;break;
			fi
		done
	done
}

function checkPosition(){
	if [[ ($1 -gt 0) && ($1 -le 3) && ($2 -gt 0) && ($2 -le 3) ]]
	then
		echo 1
	else
		echo 0
	fi
}

function checkCondition(){
	if [[ $1 -eq 1 ]]
	then
		echo "win";exit;
	elif [[ $2 -eq 1 ]]
	then
		echo "tie";exit;
	else
		echo "change turn"
	fi
}
function playerInputCheck(){
	displayBoard;
	assignLetters $selectLetter;
	read -p "enter the position in the matrix:" rowPosition columnPosition
	checkValid=`checkPosition $rowPosition $columnPosition`
	if [[ $checkValid -eq 1 ]]
	then
		boardElements[$rowPosition$columnPosition]=$PLAYER_LETTER;
		displayBoard;
		checkCondition $winCheck $tieCheck $checkPOsition;
	else
		playerInputCheck;
	fi
}
resetBoard
playerInputCheck

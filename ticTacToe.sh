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

function rowCrossed(){
	for ((row=1;row<=3;row++))
	do
		column=1;
		if [[ (${boardElements[$row$column]} =~ ${boardElements[$row$(($column+1))]}) && (${boardElements[$row$column]} =~ ${boardElements[$row$(($column+2))]}) ]]
		then
			echo 1;break;
		fi
	done
	echo 0
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
	echo 0
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
	echo 0
}

function winCheck(){
	row=`rowCrossed`;column=`columnCrossed`;diagonal=`diagonalCrossed`;
	if [[ ($row -eq 1) || ($column -eq 1) || ($diagonal -eq 1) ]]
	then
		echo 1;
	fi
	echo 0
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
	echo 0
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
	elif [[ $3 -eq 1 ]]
	then
		echo 1;
	fi
}
function userPlay(){
	displayBoard
	read -p "enter the position in the matrix:" rowPosition columnPosition
	checkValid=`checkPosition $rowPosition $columnPosition`
	if [[ ($checkValid -eq 1) && (${boardElements[$rowPosition$columnPosition]} =~ ^([-])$) ]]
	then
		boardElements[$rowPosition$columnPosition]=$playerLetter;
		changePositon=`checkCondition $winCheck $tieCheck $checkValid`;
	else
		echo "not valid and try again";
	fi
	if [[ $changePosition -eq 1 ]]
	then
		computerPlay
	else
		userPlay
	fi
}
function computerPlay(){
	row=$((1+$(($RANDOM%3))));column=$((1+$(($RANDOM%3))));
	if [[ ${boardElements[$row$column]} =~ ^([-])$ ]]
   then
		boardElements[$row$column]=$computerLetter;
   	changePosition=`checkCondition $winCheck $tieCheck $checkPosition`;
	else
		computerPlay
	fi
	if [[ $changePosition -eq 1 ]]
   then
      userPlay
   fi

}

function startGame(){
	count=0;
	resetBoard;
	selectPlayer;
	assignLetters $selectLetter;
	case $startPerson in
		player) userPlay;;
		computer) computerPlay;;
	esac
}
startGame


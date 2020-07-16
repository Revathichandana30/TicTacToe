#! /bin/bash
echo "============TIE TAC TOE ==============="
define -a boardElements;

function resetBoard(){
   for((row=1;row<=3;row++))
   do
      for((column=1;column<=3;column++))
      do
         boardElements[$row$column]=s;
         printf "${boardElements[$row$column]} "
      done
      echo " "
   done
}

function selectPlayer(){
	case $((RANDOM%2)) in
		0) playerLetter=`selectLetter`;
			computerLetter=`assignLetters $playerLetter`
			echo "player starts game and he selected $playerLetter letter and computer letter: $computerLetter "
			displayBoard;;
		1) computerLetter=`selectLetter`;
			playerLetter=`assignLetters $computerLetter`
			echo "computer starts game and it selects $computerLetter letter and player letter: $playerLetter";;
	esac
}

function assignLetters(){
	if [[ $1 =~ [O] ]]
	then
		temp=X
	else
		temp=O
	fi
	echo "$temp"
}

function selectLetter(){
	case $((RANDOM%2)) in
		0) echo "O";;
		1) echo "X";;
	esac
}

function displayBoard(){
	for((row=1;row<=3;row++))
   do
   	for((column=1;column<=3;column++))
      do
         printf "${boardElements[$row$column]} "
      done
      echo " "
   done

}
resetBoard
selectPlayer

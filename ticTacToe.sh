#! /bin/bash
echo "============TIE TAC TOE ==============="
boardElements=( 1 2 3 4 5 6 7 8 9 )

displayBoard(){
	element=0;
	while [ $element -lt 9 ]
	do
		echo " ${boardElements[$((element++))]} ${boardElements[$((element++))]} ${boardElements[$((element++))]}"
	done
}

selectPlayer(){
	case $((RANDOM%2)) in
		0) playerLetter=`selectLetter`;
			computerLetter=`assignLetters $playerLetter`
			echo "player starts game and he selected $playerLetter letter and computer letter: $computerLetter ";;
		1) computerLetter=`selectLetter`;
			playerLetter=`assignLetters $computerLetter`
			echo "computer starts game and it selects $computerLetter letter and player letter: $playerLetter";;
	esac
}
assignLetters(){
	if [[ $1 =~ [O] ]]
	then
		temp=X
	else
		temp=O
	fi
	echo "$temp"
}
selectLetter(){
	case $((RANDOM%2)) in
		0) echo "O";;
		1) echo "X";;
	esac
}
displayBoard
selectPlayer

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
		0) echo "player starts game";;
		1) echo "computer starts game";;
	esac
}
displayBoard
selectPlayer

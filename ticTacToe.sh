#! /bin/bash
echo "============TIE TAC TOE ==============="
boardElements=( 1 2 3 4 5 6 7 8 9 )
function resetBoard(){
   for((row=1;row<=3;row++))
   do
      for((column=1;column<=3;column++))
      do
         boardElements[$row$column]="-";
         printf "| ${boardElements[$row$column]} |"
      done
      echo -e "\n------------ "
   done
}

selectPlayer(){
	case $((RANDOM%2)) in
		0) echo "player starts game";
			startPerson=player;;
		1) echo "computer starts game";
			startPerson=computer;;
	esac
}
resetBoard
selectPlayer

#! /bin/bash
echo "============TIE TAC TOE ==============="
boardElements=( 1 2 3 4 5 6 7 8 9 )
resetBoard(){
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

selectPlayer(){
	case $((RANDOM%2)) in
		0) echo "player starts game";;
		1) echo "computer starts game";;
	esac
}
resetBoard
selectPlayer

#! /bin/bash
echo "============TIE TAC TOE ==============="
define -a boardElements;
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
resetBoard

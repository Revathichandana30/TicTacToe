#! /bin/bash
echo "============TIE TAC TOE ==============="
define -a boardElements;
function resetBoard(){
	for((row=1;row<=3;row++))
	do
		for((column=1;column<=3;column++))
		do
			boardElements[$row$column]="-";
			printf "| ${boardElements[$row$column]} | "
		done
		echo -e "\n------------------ "
	done
}
resetBoard

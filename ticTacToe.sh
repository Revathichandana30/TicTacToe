#! /bin/bash
echo "============TIE TAC TOE ==============="
ROW_SIZE=3
BOARD_SIZE=$(($ROW_SIZE*$ROW_SIZE))
userSymbol="O"
compSymbol="O"
quit=false
validator=false
position=0
count=0
declare -A board

function resetBoard(){
	position=0
   for (( position=1; position<=$BOARD_SIZE ; position++ )) 
	do
 		board[$position]=0
   done
}

function displayBoard(){
	count=0
   for (( count=1; count<=$BOARD_SIZE ; count++ ))
	do
	if [ "${board[$count]}" == "0" ]
   then
   	printf  _" "
   else
   	printf ${board[$count]}" "
   fi
   if [ $(( $count % $ROW_SIZE )) -eq 0 ]
   then
   	echo
   fi
   done
}

function assignSymbol(){
	randomVariable=$((RANDOM%2))
   if [ $randomVariable -eq 0 ]
   then
	   userSymbol="X"
   else
      compSymbol="X"
	fi
   echo "Your sign is "$userSymbol" and computer sign is "$compSymbol
}

function toss(){
	randomVariable=$((RANDOM%2))
   if [ $randomVariable -eq 0 ]
   then
   	echo User turn first
      firstPlay=user
   else
   	echo Computer turn first
      firstPlay=computer
   fi
}

function validPositionChecker(){
	if [ "$visited" == "false" ]
	then
		if [ $1 -gt 0  -a $1 -le $BOARD_SIZE ]
   	then
   		validator=true
   	fi
   	if [ "$validator" == "true" -a "${board[$1]}" == "0" ]
   	then
   		board[$1]=$2
			visited=true
	   else
   	   validator=false
   	fi
	fi
}

function computerPlays(){
	if [ "$visited" == "false" ]
	then
		while [ "$validator" == "false" ]
   	do
	   	number=$((RANDOM%9+1))
      	validPositionChecker $number $compSymbol
   	done
   	validator=false
	fi
}

function userPlays(){
	while [ "$validator" == "false" ]
   do
   	read -p "Please enter the number between 1-9 where insert your $userSymbol in board " input;
      validPositionChecker $input $userSymbol
      if [ "$validator" == "false" ]
      then
			echo Input not accepted please try again
      fi
	done
   validator=false
}

function diagonalEndingTopLeft(){
	if [ "$visited" == "false" ]
	then
		cell=0
		count=0
		increase_by=$((ROW_SIZE+1))
  		for (( position=1; position <= $BOARD_SIZE; position+=$((ROW_SIZE+1)) ))
  		do
	  		if [ ${board[$position]} == $1 ]
     		then
	     		((count++))
     		elif [ "$cell" == "0" -a "${board[$position]}" == "0" ]
			then
				cell=$position
			fi
      done
      if [ $count -eq $ROW_SIZE ]
      then
      	winnerDisplay $1
        	quit=true
      elif [ $count -ne $(($ROW_SIZE-1)) ]
		then
			cell=0
		fi
	fi
}

function diagonalEndingTopRight(){
	if [ "$visited" == "false" ]
	then
		count=0
		cell=0
		for (( position=$ROW_SIZE; position <= $((BOARD_SIZE+1-ROW_SIZE)); position+=$((ROW_SIZE-1)) )) do
			if [ ${board[$position]} == $1 ]
			then
				((count++))
        	elif [ "$cell" == "0" -a "${board[$position]}" == 0 ]
			then
				cell=$position
			fi
     	done
     	if [ $count == $ROW_SIZE ]
     	then
	      winnerDisplay $1
         quit=true
 		elif [ $count -ne $(($ROW_SIZE-1)) ]
		then
			cell=0
		fi
	fi
}

function rowChecker(){
	if [ "$visited" == "false" ]
	then
   	count=0
     	position=0
     	for (( row=0;row<$ROW_SIZE;row++ ))
		do
        	count=0
			cell=0
     		for (( col=1; col<=$ROW_SIZE; col++ ))
			do
	  			position=$(($ROW_SIZE*row+col ))
     			if [ ${board[$position]} == $1 ]
     			then
        			(( count++ ))
        		elif [ "$cell" == "0" -a "${board[$position]}" == 0 ]
        		then
        			cell=$position
       		fi
     		done
     		if [ $count -eq $ROW_SIZE ]
     		then
	        	winnerDisplay $1
           	quit=true
				break
			elif [ $count -ne $(($ROW_SIZE-1)) ]
			then
				cell=0
			else
				break
        	fi
     	done
   fi
}

function rowWin(){
	count=0
   position=0
   for (( row=0; row<$ROW_SIZE; row++ )) do
   	count=0
      for (( col=1; col<=$ROW_SIZE; col++ )) do
      	position=$(( ROW_SIZE*row+col ))
         if [ ${board[$position]} == $1 ]
         then
         	(( count++ ))
         fi
      done
      if [ $count -eq $ROW_SIZE ]
      then
	      winnerDisplay $1
         quit=true
         break
      fi
	done
}

function columnChecker(){
	if [ "$visited" == "false" ]
	then
   	count=0
      position=0
     	for (( col=1;col<=$ROW_SIZE;col++ )) do
   	  	count=0
      	for (( row=0; row<=$ROW_SIZE; row++ )) do
         	position=$(($ROW_SIZE*row+col ))
           	if [ "${board[$position]}" == "$1" ]
          	then
              	(( count++ ))
				elif [ "$cell" == "0" -a "${board[$position]}" == 0 ]
         	then
         		cell=$position
            fi
     		done
        	if [ $count -eq $ROW_SIZE ]
        	then
           	winnerDisplay $1
           	quit=true
				break
     		elif [ $count -ne $(($ROW_SIZE-1)) ]
    		then
        		cell=0
     		else
           	break
        	fi
     	done
	fi
}

function columnWin(){
	if [ "$visited" == "false" ]
   then
   	count=0
      position=0
   	for (( col=1;col<=$ROW_SIZE;col++ )) do
      	count=0
         for (( row=0; row<=$ROW_SIZE; row++ )) do
      	   position=$(($ROW_SIZE*row+col ))
            if [ "${board[$position]}" == "$1" ]
            then
               (( count++ ))
            fi
         done
         if [ $count -eq $ROW_SIZE ]
         then
            winnerDisplay $1
            quit=true
            break
         fi
      done
	fi
}

function centre(){
	if [ "$visited" == "false" ]
   then
   	mid=$((ROW_SIZE/2))
      position=$(( $(( ROW_SIZE*mid)) + $((ROW_SIZE-mid)) ))
      validPositionChecker $position $compSymbol
	fi
}

function block(){
	rowChecker $userSymbol
	validPositionChecker $cell $compSymbol
	columnChecker $userSymbol
	validPositionChecker $cell $compSymbol
	diagonalEndingTopRight $userSymbol
	validPositionChecker $cell $compSymbol
	diagonalEndingTopLeft $userSymbol
	validPositionChecker $cell $compSymbol

}

function corners(){
	if [ $visited == "false" ]
	then
		local position=1
		validPositionChecker 1 $compSymbol
		position=$((ROW_SIZE*0+ROW_SIZE))
		validPositionChecker $position $compSymbol
		position=$(( ROW_SIZE*$((ROW_SIZE-1)) + 1))

		validPositionChecker $position $compSymbol
		position=$(( ROW_SIZE*$((ROW_SIZE-1)) + ROW_SIZE))
		validPositionChecker $position $compSymbol
	fi
}

function winnerChecker(){
	rowChecker $compSymbol
	validPositionChecker $cell $compSymbol
	columnChecker $compSymbol
	validPositionChecker $cell $compSymbol
	diagonalEndingTopRight $compSymbol
	validPositionChecker $cell $compSymbol
	diagonalEndingTopLeft $compSymbol
	validPositionChecker $cell $compSymbol
}

function checkWin(){
	diagonalEndingTopRight $1
	diagonalEndingTopLeft $1
	rowWin $1
	columnWin $1
}


function sides(){
	if [ $visited == "false" ]
   then
   	for (( side=1; side<=$ROW_SIZE; side++ ))
   	do
   		position=side
   		validPositionChecker $position $compSymbol
   	done
  		for (( side=1; side<=$BOARD_SIZE; side+=$ROW_SIZE ))
  		do
  			position=side
  			validPositionChecker $position $compSymbol
  		done
  		for (( side=$((BOARD_SIZE-ROW_SIZE+1)); side<=$BOARD_SIZE; side++ ))
  		do
  			position=side
  			validPositionChecker $position $compSymbol
 		done
  		for (( side=$ROW_SIZE; side<=$BOARD_SIZE; side++ ))
  		do
  			position=side
  			validPositionChecker $position $compSymbol
  		done
	fi
}


function plays(){
	winnerChecker
	block
	corners
	centre
	sides
	computerPlays
}

function winnerDisplay(){
	if [ $1 == $userSymbol ]
   then
   	echo "User Wins the game"
   else
      echo "Computer wins the game"
   fi
}

function gameEnds(){
	for keys in ${board[@]}
	do
		if [ $values==0 ]
		then
			((count++))
		fi
		if [ $count -gt 0 ]
		then
			break
		fi
	done
	if [ $count -eq 0 -a $quit == false  ]
	then
		echo "DRAW"
		quit=true
	fi
}


function ticTacToeApplication(){
	resetBoard
	assignSymbol
	toss
	while [ $quit == false ]
	do
		validator=false
		visited=false
		if [ $firstPlay == user ]
		then
			displayBoard
			userPlays
			validator=false
			visited=false
			checkWin $userSymbol
			gameEnds
			firstPlay=computer
		fi
		if [ $firstPlay == computer -a $quit == false ]
		then
			plays
			visited=false
			checkWin $compSymbol
			gameEnds
			firstPlay=user
		fi
	done
	displayBoard
}

ticTacToeApplication

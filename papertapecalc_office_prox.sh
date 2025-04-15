

subtotalArr=()
totalArr=()
numberArr=()
absArr=()
entries=0
plus="+"
minus="-"
divide="\\"
mult="*"
calcInput=0
first_char="+"
actual_num=0
temp=0
calcinputonly=0
signArr=()
max_length=0
max_lengthx=0
x=0
delid=0
reversesign=0
newcalc=0
entriex=0
delmode=0
subtotalArrX=()
signArrX=()
while true;do
date=$(date +"%F")
echo ""
echo ""
echo -e "\r\rPaper Tape Calculator Pro. Date:$date"
echo "Enter input: "
read calcInput
first_char="${calcInput:0:1}"
calcinputonly="${calcInput:1}"
clear


if [[ "$first_char" == "x" ]];then
exit
fi
if [ "$first_char" == "e" ];then
del 
fi

function clearall {

entries=0
entriesx=0
actual_num=0
subtotalArr=()
totalArr=()
numberArr=()
absArr=()
signArr=()
subtotalArrX=()
signArrX=()
clear
}

function printtofile {
date=$(date +"%F-%H-%M-%S")
echo -e "Printed contents to file\r\r"
echo ""

printx
echo -e $(printx) > "papertape_$date.txt"

}


function del {
delid=$(cut -c 2- <<< "$calcInput")

delmode=0
          
           # Re-index the array to remove the gap
           unset absArr[$delid]
           # Re-index the array to remove the gap
           absArr=()

           unset subtotalArr[$delid]
           # Re-index the array to remove the gap
           subtotalArrX=("${subtotalArr[@]}")
        

           unset signArr[$delid]
           # Re-index the array to remove the gap
           signArrX=("${signArr[@]}")
       
      
entriesx=$((entries - 1))
entries=0
echo "ID $delid has been deleted"

for (( i=0 ; i < $entriesx ; i++ ));do

actual_num=${subtotalArrX[i]}
subtotalArr[$entries]=$actual_num
prev=$(( entries - 1 ))


if [ $entries == 0 ];then


if [[ "${signArrX[i]}" != "p" ]] && [[ "${signArrX[i]}" != "m" ]];then
absArr[$entries]=$(printf "%.2f" $(echo "scale=2; 0 ${signArrX[i]} $actual_num" | bc))

fi
fi
if [ $entries -gt 0 ];then



if [[ "${signArrX[i]}" != "p" ]] && [[ "${signArrX[i]}" != "m" ]];then
absArr[$entries]=$(printf "%.2f" $(echo "scale=2; ${absArr[prev]} ${signArrX[i]} $actual_num" | bc))
fi


if [[ "${signArrX[i]}" == "p" ]] ;then


absArr[$entries]=$(printf "%.2f" $(echo "scale=2; ${absArr[prev]} + (${absArr[prev]} * $actual_num / 100)" | bc))

fi


if [[ "${signArrX[i]}" == "m" ]] ;then


absArr[$entries]=$(printf "%.2f" $(echo "scale=2; ${absArr[prev]} - (${absArr[prev]} * $actual_num / 100)" | bc))

fi



fi

signArr[$entries]=${signArrX[i]}

((entries++))
done
printx
}

function calcnorm {

actual_num=$(printf %.2f $(cut -c 2- <<< "$calcInput"))
subtotalArr[$entries]=$actual_num
prev=$(( entries - 1 ))


if [  $entries == 0 ];then
absArr[$entries]=$(printf "%.2f" $(echo "scale=2; 0 $1 $actual_num" | bc))
fi

if [ $entries -gt 0 ];then


if [ "$first_char" != "p" ] && [ "$first_char" != "m" ] && [ "$first_char" != "e" ];then

norm=$(printf "%.2f" $(echo "scale=2; ${absArr[prev]} $1 $actual_num" | bc))
absArr[$entries]=$norm

fi

if [ "$first_char" == "p" ] ;then



absArr[$entries]=$(printf "%.2f" $(echo "scale=2;  ${absArr[prev]} + (${absArr[prev]} * $actual_num / 100)" | bc))

fi


if [ "$first_char" == "m" ] ;then


absArr[$entries]=$(printf "%.2f" $(echo "scale=2; ${absArr[prev]} - (${absArr[prev]} * $actual_num / 100)" | bc))

fi



fi

signArr[$entries]="$1"

((entries++))
printx
}

function printx {
for (( i=0; i < $entries; i++ ));do



for element in "${absArr[@]}"; do
  length="${#element}"
  if [ "$length" -gt "$max_length" ]; then
    max_length="$length"
  fi
done

for element in "${subtotalArr[@]}"; do
  length="${#element}"
  if [ "$length" -gt "$max_lengthx" ]; then
    max_lengthx="$length"
  fi
done

if [  $max_length -gt $max_lengthx ]; then
x="$max_length"
else  
x="$max_lengthx"
fi
y="${#subtotalArr[$i]}"
z="${#absArr[$i]}"
addspacessub=$((x - y))
addspacestot=$((x - z))
spacessub=$(printf "%*s%s" "$addspacessub" "")
spacestot=$(printf "%*s%s" "$addspacestot" "")
echo -e "\rID:$i   Sub-Total: $spacestot${absArr[$i]}   Entry: ${signArr[$i]}$spacessub${subtotalArr[$i]}"
done
#clearall

}


if [ "$first_char" == "$plus" ] || [ "$first_char" == "$minus" ] || [ "$first_char" == "/" ] || [ "$first_char" == "$mult" ] || [ "$first_char" == "p" ] || [ "$first_char" == "m" ] || [ "$first_char" == "f" ] || [ "$first_char" == "c" ];then



if [ "$first_char" == "+" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "+"
fi

if [ "$first_char" == "-" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "-"
fi


if [ "$first_char" == "*" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "*"
fi

if [ "$first_char" == "/" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "/"
fi


if [ "$first_char" == "p" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "p"
fi

if [ "$first_char" == "m" ] && [[ "$calcinputonly"  =~ ^-?[0-9.]+$ ]];then
calcnorm "m"
fi

if [ "$first_char" == "f" ];then
printtofile
fi

if [ "$first_char" == "c" ];then
clearall
fi


else
echo -e "\rWrong Input?\r\r"
fi


done


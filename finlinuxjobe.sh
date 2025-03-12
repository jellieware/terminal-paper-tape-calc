

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
while [ $calcInput != "q" ];do


read calcInput
first_char="${calcInput:0:1}"
calcinputonly="${calcInput:1}"
clear

if [ "$first_char" == "d" ];then
del 
fi




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


if [  $entries == 0 ];then
absArr[$entries]=$actual_num
fi
if [ $entries -gt 0 ];then
absArr[$entries]=$((absArr[$prev] ${signArrX[i]} $actual_num))
fi

signArr[$entries]=${signArrX[i]}

((entries++))
done
}

function calcnorm {

actual_num=$(cut -c 2- <<< "$calcInput")
subtotalArr[$entries]=$actual_num
prev=$(( entries - 1 ))


if [  $entries == 0 ];then
absArr[$entries]=$actual_num
fi
if [ $entries -gt 0 ];then
absArr[$entries]=$((absArr[$prev] $1 actual_num))
fi

signArr[$entries]="$1"

((entries++))

}

function print {
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
echo "ID:$i   Sub-Total: $spacestot${absArr[$i]}    Entry: ${signArr[$i]} $spacessub${subtotalArr[$i]}"
done
#clearall
}


if [ "$first_char" == "$plus" ] || [ "$first_char" == "$minus" ] || [ "$first_char" == "$divide" ] || [ "$first_char" == "$mult" ];then


if [[ $calcinputonly =~ ^[0-9]+$ ]]; then

if [ "$first_char" == "+" ];then
calcnorm "+"
fi

if [ "$first_char" == "-" ];then
calcnorm "-"
fi


if [ "$first_char" == "*" ];then
calcnorm "*"
fi

if [ "$first_char" == "/" ];then
calcnorm "/"
fi

print


else
echo "Try Again!"
fi
else
echo "Try Again!"
fi


done

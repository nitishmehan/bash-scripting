read -p "Enter your Number: " n
if [ $n == 100 ] || [[ $n -ge 10 && $n -le 50 ]] #[ $n -ge 10 -a $n -le 50 ]
then 
echo "condition met"
else
echo "fuck off"
fi
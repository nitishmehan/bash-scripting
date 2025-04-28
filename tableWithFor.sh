read -p "Enter Your Number " n
if [ $n -le 0 ]
then 
echo invalid number
exit 1
fi
temp=$(seq 1 10)
for ((i=1;i<=10;i++))
# for i in $temp 
do
p=$((n*i))
echo "$n x $i = $p"
done
read -p "Enter you Number " n
count=0
while [ $n -gt 0 ]
do
((count++))
n=$((n/10))
done
echo $count
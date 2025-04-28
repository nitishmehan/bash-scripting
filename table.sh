read -p "Enter the Number " n
i=1
while [ $i -le 10 ]
do
product=$((i*n))
echo "$n x $i = $product"
i=$((i+1))
done
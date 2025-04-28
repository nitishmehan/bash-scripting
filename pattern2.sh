read -p "Enter Number of Rows " n
read -p "Enter Number " a
if [[ $((a%2)) == 0 ]]
then 
echo "Invalid Number"
exit 1
fi

for ((i=1;i<=n;i++))
do 
    for ((j=1;j<=i;j++))
    do 
    echo -n "$a "
    a=$((a+2))
    done
echo
done
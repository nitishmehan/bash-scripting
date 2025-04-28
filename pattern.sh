read -p "Enter your Number " n
for ((i=1;i<=n;i++))
do 
    for ((j=1;j<=i;j++))
    do
    echo -n "* "
    done
echo
done

for ((i=n;i>=0;i--))
do 
    for ((j=1;j<=i;j++))
    do
    echo -n "* "
    done
echo
done

a=10
b=10
if [ $a -eq $b ] #or == 
then 
echo a is equal to b
else
echo b is not equal to a
fi

c="Nitish"
d="Nitish"
if [ $c == $d ]
then
echo a is b
elif [ $c != $d ]
then
echo a is not b
fi

read -p "Enter a number: " a
if [ `expr $a % 2` == 0 ]
then 
echo Even
else 
echo Odd
fi
read -p "Enter your Word " word
temp=`echo $word | rev`
if [ "$temp" == "$word" ]
then
echo Pallindrome
else
echo Not Pallindrome
fi
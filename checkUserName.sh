read -p "Enter your username: " name
user=`grep -w "$name" /etc/passwd`
# echo $user
if [ -n "$user" ]    #[ "$user" != '' ] #[ ! -z $user ]
then
echo User Exist
else 
echo User Does Not Exist
fi
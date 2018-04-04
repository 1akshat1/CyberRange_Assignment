#!/bin/bash


if [ ! $# == 3 ]; #Check input parameters
then
echo "Usage: ./run [USER ID] [new_key.pub] [ip.txt]"
exit
elif [[ $2 == *.pub && $3 == ip.txt ]]
then
USER=$1
key=$(cat $2)
ip_address=$3
else
echo "Wrong input file/Does not exit"
exit
fi

#Loop through provided IP addresses and ssh each

cat $ip_address | while read output;
do 
ip=$output
echo "SSHing $ip"
#Run the group of commands on the trusted server
ssh -n -l ${USER} ${ip} bash -c "'
hostname
hostname -I | cut -f 1 -d \" \"
stat --format=mtime:%y\|ctime:%z\|atime:%x .ssh/authorized_keys
echo $key >> .ssh/authorized_keys
cat .ssh/authorized_keys | tail -1
'" >out.txt #Put the information on console to a text file

if [ $? -eq 0 ]; then
echo "Success $ip"
paste -d ',' - - - - < out.txt >>out.csv #convert the text file to csv file
else
echo "Failure $ip"
fi
done


#!/bin/bash


if [ ! $# == 2 ]; #Check input parameters
then
echo "Usage: ./run [new_key.pub] [ip.txt]"
exit
elif [[ $1 == *.pub && $2 == ip.txt ]]
then
key=$(cat $1)
ip_address=$2
else
echo "Wrong input file/Does not exit"
echo "Usage: ./run [new_key.pub] [ip.txt]"
exit
fi

#Loop through provided IP addresses and ssh each

cat $ip_address | while read user ip;
do 
echo "SSHing $ip"
#Run the group of commands on the trusted server
ssh -n -l ${user} ${ip} bash -c "'
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

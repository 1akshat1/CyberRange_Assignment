Cyber Range Assignment #1

The run.sh script logs into the remote machines, gathers basic information and adds another key to the SSH authorized key file.

It is assumed that trust exists between host device and the remote device and hence no password is required to login. 

Usage: ./run.sh [new_key.pub] [ip.txt]

You can replace new_key.pub with your public key and ip.txt with your list of user names and ip addresses.

#!/bin/bash
# Requires a server list for the first part of the for loop!!!
# Log into each server in your server list

for i in $(cat list of servers)
do
    echo
    echo $i
    ssh $i 
	for I in $(ls /home)
    do
	    if [[ $(id -u $i) ]] > 500
        then
            chage -d 0 $i 
			echo $i
        fi
    done
done
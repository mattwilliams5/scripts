#!/bin/bash

# This script takes another file called printer_list which you should update with all the printers names
# You will also have to update the port numbers....for now

if [ `whoami` != 'root' ]
then
    echo "Must be root to run this script!"
    exit 1
fi

for i in $(cat printer_list)
do
	echo
	echo $i
    lpadmin -p $i -v socket://172.23.157.80:48000 -E -P /usr/share/ppd/HP/hp-laserjet_p3010_series-ps.ppd.gz
	lpstat -t | grep -i $i
	echo
done


    
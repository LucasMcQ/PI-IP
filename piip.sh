#!/bin/bash

#Author: Lucas McQuiston
#File  : piip.sh
#Date  : January 2, 2017


#################################piip.sh#######################################

#This bash script will find the ip address of a raspberry pi and save the ip
#address to a file that other programs or scripts can use if the ip address of
#the raspberry pi changes. If this script is ran with the argument "-c", then
#the script will connect to the raspberry pi.

###############################################################################



#Get the current ip address of the current system you are on.
HOST_NAME="$(hostname -I)"

#This will get the ip addresses of all of the active ports, and use grep to get
#the lines with the ip address, and then it uses grep again to just retrive all
#of the ip addresses of the line.
NMAP_OUTPUT="$(nmap -sn "${HOST_NAME}"/24 | grep "Nmap scan" | grep -o -E '[0-9.]+')"


#This will loop through all of the ip addresses.
while read -r line; do

	#Save the ip address of the raspberry pi into a file named "piip".
	echo "${line}" > piip

	#Save the command to connect to the raspberry pi into a file named
	#pi_connect.sh.
	echo "ssh -q -tt pi@"${line}"" > pi_connect.sh

	#A connection is attempted to be made to the raspberry pi.
	ssh -q -tt pi@"${line}" exit
	
	#If the connection attempt was successful, we are done.
	if [ $? -eq 0 ]
	then
		echo "The IP address above were not checked."
		echo "Raspberry pi found! IP="${line}""
		break
	else
		echo "Not a raspberry pi! IP="${line}""
	fi

done <<< "$NMAP_OUTPUT"



ARG="-c"	#The "connection" argument signifies that the user would like to connect to their raspberry pi.

#Compare arg[1] to -c, if they match then the script will connect to the raspberry pi.
if [ "$1" == "$ARG" ]; then
	bash pi_connect.sh
fi


echo "The contents of the file \"piip\" will contain the ip address of your raspberry pi."
echo "Run the script \"pi_connect.sh\" to connect to your raspberry pi."

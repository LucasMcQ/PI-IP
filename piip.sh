#!/bin/bash

#################################piip.sh#######################################

#Author: Lucas McQuiston
#File: piip.sh
#Date Modified: January 6, 2017

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

CONNECTION_SUCCESS=0		#If this is equal to 1, then the raspberry pi ip address has been found.

PI_USERNAME=pi			#The default username of the raspberry pi is 'pi'
CONNECTION_FLAG="-c"		#The "connection" argument signifies that the user would like to connect to their raspberry pi.
ARGC=$#				#The quantity of command line arguments



#This will cange the username that is used to connect to the raspberry pi
#if the user of the script typed the username of the raspberry pi on the
#command line.
if [[ ${ARGC} -eq 2 && "${1}" == "${CONNECTION_FLAG}" ]]; then
	PI_USERNAME="${2}"

elif [[ ${ARGC} -eq 2 && "${2}" == "${CONNECTION_FLAG}" ]]; then
	PI_USERNAME="${1}"

elif [[ ${ARGC} -eq 1  && "${1}" != "${CONNECTION_FLAG}" ]]; then
	PI_USERNAME="${1}"
fi


#This will loop through all of the ip addresses.
while read -r ip; do

	#Save the ip address of the raspberry pi into a file named "piip".
	echo "${ip}" > piip

	#Save the command to connect to the raspberry pi into a file named
	#pi_connect.sh.
	echo "ssh -q -tt "${PI_USERNAME}"@"${ip}"" > pi_connect.sh

	#A connection is attempted to be made to the raspberry pi.
	ssh -q -tt "${PI_USERNAME}"@"${ip}" exit
	
	#If the connection attempt was successful, we are done.
	if [ $? -eq 0 ]; then

		echo "The IP address above were not checked."
		echo ""
		echo "Raspberry pi found! IP="${ip}""
	
		CONNECTION_SUCCESS=1		#A successful connection was made with the raspberry pi.

		break

	else
		echo "Not a raspberry pi! IP="${ip}""
	fi

done <<< "${NMAP_OUTPUT}"


#Compare arg[1] to -c, if they match then the script will connect to the raspberry pi.
if [[ "${1}" == "${CONNECTION_FLAG}" || "${2}" == "${CONNECTION_FLAG}" ]]; then
	bash pi_connect.sh
fi


#If the connection was established with the raspberry pi, then info about the ip adress will be printed out.
if [ ${CONNECTION_SUCCESS} -eq 1 ]; then
	echo "The contents of the file \"piip\" will contain the ip address of your raspberry pi."
	echo "Run the script \"pi_connect.sh\" to connect to your raspberry pi."
else
	echo "Connection was not established with the raspberry pi."
fi

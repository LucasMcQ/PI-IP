#!/bin/bash

#################################piip.sh#######################################

#Author: Lucas McQuiston
#File: piip.sh
#Date Modified: January 7, 2017

#This bash script will find the ip address of a raspberry pi and save the ip
#address to a file that other programs or scripts can use if the ip address of
#the raspberry pi changes. If this script is ran with the argument "-c", then
#the script will connect to the raspberry pi.

###############################################################################

CONNECTION_SUCCESS=0			#If this is equal to 1, then the raspberry pi ip address has been found.
PI_HOSTNAME=raspberrypi			#The default host name of the raspberry pi is 'raspberrypi'
PI_USERNAME=pi				#The default username of the raspberry pi is 'pi'
CONNECTION_FLAG="-c"			#The "connection" argument signifies that the user would like to connect to their raspberry pi.
ARGC=$#					#The quantity of command line arguments


#This will cange the username that is used to connect to the raspberry pi
#if the user of the script typed the username of the raspberry pi on the
#command line.
if [[ ${ARGC} -eq 3 && "${1}" == "${CONNECTION_FLAG}" ]]; then
	PI_HOSTNAME="${2}"
	PI_USERNAME="${3}"

elif [[ ${ARGC} -eq 3 && "${3}" == "${CONNECTION_FLAG}" ]]; then
	PI_HOSTNAME="${1}"
	PI_USERNAME="${2}"

elif [[ ${ARGC} -eq 2  && "${1}" != "${CONNECTION_FLAG}" ]]; then
	PI_HOSTNAME="${1}"
	PI_USERNAME="${2}"
fi

#This will use the ping command with the hostname of the raspberry pi then use the cut command
#to get to the ip address field, then use grep to extract the ip address of the raspberry pi.
IP="$(ping "${PI_HOSTNAME}".local -c 1 | cut -d ' ' -f3 | grep -o -E '[0-9.]+')"

#If the commands above executed with an error code of 0, then the IP address was successfully obtained.
if [ $? -eq 0 ]; then
	echo "${IP}" > piip
	echo "Raspberry pi found! IP="${IP}""
	echo "The contents of the file \"piip\" will contain the ip address of your raspberry pi."
	CONNECTION_SUCCESS=1		#A successful connection was made with the raspberry pi.
else
	echo "Raspberry pi was not found."
fi

#If the -c argument was entered, the script will then connect to the raspberry pi.
if [[ ${CONNECTION_SUCCESS} -eq 1 && "${1}" == "${CONNECTION_FLAG}" || "${2}" == "${CONNECTION_FLAG}" || "${3}" == "${CONNECTION_FLAG}" ]]; then
	ssh -q -tt "${PI_USERNAME}"@"${IP}"
fi

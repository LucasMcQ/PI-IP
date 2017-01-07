# PI-IP
A shell script that will find the ip address of your raspberry pi, and save it to a file. The script has the option to connect to the raspberry pi.
If the name to login to your raspberry pi is diffrent than "pi", then you are able to specify the name when you run the script. This script probably
will not work as desired if there is more than one device in your home that you can ssh into. If it does work, it probably will not work as I intended
it to work.

This script should work if you only have one device in your home that you can ssh into. I made this script with the intention of just connecting to the
raspberry pi, but I would think it would work for any device you are able to ssh into.

To run piip.sh:

Option #1: This will create a file named "piip" that will have the ip of your raspberry pi, and it will also create a file that
will connect you to your raspberry pi.

To run:
bash piip.sh [optional-name of your raspberry pi]


Option #2: This is the same as option #1 except it will automatically connect you to your raspberry pi.

To run:
bash piip.sh -c [optional-name of your raspberry pi]

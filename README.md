# PI-IP
A shell script that will find the ip address of your raspberry pi, and save it to a file. The script has the option to connect to the raspberry pi.
If the hostname OR the username of your pi is diffrent than the default (HOSTNAME=raspberrypi and USERNAME=pi) then you must specify that when the
script is ran.

example: bash piip.sh [MY HOSTNAME] [MY USERNAME]

The username must follow the hostname inorder to work. Even if only one of either
the hostname or the username is diffrent than the default, then you must specify both of them in the above order.

If your raspberry pi has the default names (HOSTNAME=raspberrypi and USERNAME=pi) then you may run it like:

bash piip.sh ...or... bash piip.sh -c

The -c flag will connect you to your raspberry pi via ssh.

Must have installed: ping


To run piip.sh:

Option #1: This will create a file named "piip" that will have the ip of your raspberry pi, and it will also create a file that
will connect you to your raspberry pi.

To run:
bash piip.sh [[optional-hostname of your raspberry pi] [MANDATORY-username of your raspberry pi]]


Option #2: This is the same as option #1 except it will automatically connect you to your raspberry pi.

To run:
bash piip.sh -c [[optional-hostname of your raspberry pi] [MANDATORY-username of your raspberry pi]]

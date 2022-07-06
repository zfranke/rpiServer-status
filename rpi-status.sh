#!/bin/bash
# This is a script to check the status of the RPI-ZF Server, run restarts, and create log reports for viewing
# Language: bash
# Version: 1.0

# If a txt file is present in the main directory, copy its results to the reports directory as yesterdays date and delete the txt file
if [ -f "rpi-status.txt" ]; then
    cp rpi-status.txt /reports/$(date +%Y-%m-%d)_rpi-status.txt
    rm rpi-status.txt
fi

sleep 5

# Create a rpi-status.txt file
touch rpi-status.txt

#Setup the report header
echo "RPI-ZF Server Status Report" >> rpi-status.txt
echo "---------------------------------" >> rpi-status.txt
echo "Date: $(date)" >> rpi-status.txt
echo "---------------------------------" >> rpi-status.txt

echo " " >> rpi-status.txt

# Get the status of docker, docker containers, node, and the pi itself and echo the results to the txt file
echo "################################################################" >> rpi-status.txt
echo "Docker Status:" >> rpi-status.txt
echo " " >> rpi-status.txt
systemctl status docker >> rpi-status.txt
echo "################################################################" >> rpi-status.txt

echo " " >> rpi-status.txt

echo "################################################################" >> rpi-status.txt
echo "Docker Container Status: " >> rpi-status.txt
docker ps >> rpi-status.txt
echo " " >> rpi-status.txt
echo "################################################################" >> rpi-status.txt

echo " " >> rpi-status.txt

echo "################################################################" >> rpi-status.txt
echo "Node Status: " >> rpi-status.txt
node -v >> rpi-status.txt
echo " " >> rpi-status.txt
echo "################################################################" >> rpi-status.txt

#Run the restart command on the container service portainer
sudo docker container restart portainer

sleep 15

#Send the changes to github and ensure the commit message has todays date
git add .
git commit -m "RPI-ZF Server Status Report $(date +%Y-%m-%d)"
git push

sleep 5


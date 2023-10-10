#!/bin/bash 
{
hostname > /home/made.txt
ps aux | grep azure >> /home/made.txt
sudo yum install nmap -y 
} 2>&1  | tee file.sh

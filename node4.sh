#!/bin/bash
{
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
 chmod +x mariadb_repo_setup
 sudo ./mariadb_repo_setup

yum install maxscale
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-port=3307/tcp --permanent
firewall-cmd --reload
} 2>&1  | tee /home/maxscaleinstall.log

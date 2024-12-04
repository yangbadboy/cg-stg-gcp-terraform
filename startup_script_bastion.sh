#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo sed -i 's/#Port 22/Port 4222/' /etc/ssh/sshd_config
sudo systemctl restart sshd
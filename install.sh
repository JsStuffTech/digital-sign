#!/bin/bash

# Update and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install necessary packages
sudo apt install python3 python3-pip python3-venv nano -y

# Prompt for user input
read -p "Enter the static name for the office door sign: " static_name
read -p "Enter the title for the office door sign: " title

# Enable root login via SSH
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo service ssh restart

# Set up project directory
mkdir -p ~/digital-sign
cd ~/digital-sign

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Flask
pip install flask

# Create necessary folders
mkdir -p static templates

# Copy project files (this assumes you've placed the files in the appropriate locations)
cp /path-to-your-files/* ~/digital-sign/  # Adjust with the actual file path

# Update index.html with the user's input
sed -i "s/Your Static Name/$static_name/" templates/index.html
sed -i "s/Your Title/$title/" templates/index.html

# Set up systemd service
sudo cp digital-sign.service /etc/systemd/system/
sudo systemctl enable digital-sign
sudo systemctl start digital-sign

echo "Installation complete. Your digital sign is now running."

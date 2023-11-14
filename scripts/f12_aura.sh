#!/bin/bash

# ANSI escape codes for background colors
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_WHITE="\e[47m"

# Reset formatting to default
RESET="\e[0m"


# Run iptables...
echo -e "${BG_BLUE}Run iptables...${RESET}"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.227.0.0/16


# Install requirements using apt-get
echo -e "${BG_BLUE}Installing requirements...${RESET}"
apt-get update
apt-get install -y isc-dhcp-relay

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Configure isc-dhcp-relay
# /etc/default/isc-dhcp-relay
file_to_modify="/etc/default/isc-dhcp-relay"
echo -e "${BG_BLUE}Configuring $file_to_modify ...${RESET}"
echo 'SERVERS="192.227.1.1"
INTERFACES="eth1 eth3 eth4"
OPTIONS=
' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify updated successfully.${RESET}"
else
  echo -e "${BG_RED}Error updating $file_to_modify.${RESET}"
  exit 1
fi


#Configure IP forwarding
# /etc/sysctl.conf
echo -e "${BG_BLUE}Configuring /etc/sysctl.conf ...${RESET}"

# Backup the original sysctl.conf file
cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Uncomment the line net.ipv4.ip_forward = 1
sed -i '/^#\s*net\.ipv4\.ip_forward/s/^#//' /etc/sysctl.conf

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Line net.ipv4.ip_forward = 1 uncommented in /etc/sysctl.conf${RESET}"
else
  echo -e "${BG_RED}Error uncommenting the line in /etc/sysctl.conf${RESET}"
fi


# Restarting services
echo -e "${BG_BLUE}Restarting services ...${RESET}"
service isc-dhcp-relay start

echo -e "${BG_MAGENTA}DONE${RESET}"

echo "

 ________       _____     _______     
|\  _____\     / __  \   /  ___  \    
\ \  \__/     |\/_|\  \ /__/|_/  /|   
 \ \   __\    \|/ \ \  \|__|//  / /   
  \ \  \_|         \ \  \   /  /_/__  
   \ \__\           \ \__\ |\________\\
    \|__|            \|__|  \|_______|
                                      
                                      
                                      
"
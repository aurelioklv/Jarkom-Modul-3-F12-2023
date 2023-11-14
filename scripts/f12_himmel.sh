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


# Update resolv.conf
echo -e "${BG_BLUE}Updating resolv.conf...${RESET}"

echo 'nameserver 192.168.122.1
' > /etc/resolv.conf

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}resolv.conf updated successfully.${RESET}"
else
  echo -e "${BG_RED}Error updating resolv.conf.${RESET}"
  exit 1
fi


# Install requirements using apt-get
echo -e "${BG_BLUE}Installing requirements...${RESET}"
apt-get update
apt-get install -y isc-dhcp-server

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Interface setup
# /etc/default/isc-dhcp-server
file_to_modify="/etc/default/isc-dhcp-server"
echo -e "${BG_BLUE}Setting interface at $file_to_modify ...${RESET}"
echo 'INTERFACES="eth0"
' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify updated successfully.${RESET}"
else
  echo -e "${BG_RED}Error updating $file_to_modify.${RESET}"
  exit 1
fi


# Configure isc-dhcp-server
# /etc/dhcp/dhcpd.conf
file_to_modify="/etc/dhcp/dhcpd.conf"
echo -e "${BG_BLUE}Configuring $file_to_modify ...${RESET}"
marker_start="# START_DHCP_CONFIG"
marker_end="# END_DHCP_CONFIG"

script_to_append="
subnet 192.227.1.0 netmask 255.255.255.0 {
}

subnet 192.227.3.0 netmask 255.255.255.0 {
    range 192.227.3.16 192.227.3.32;
    range 192.227.3.64 192.227.3.80;
    option routers 192.227.3.111;
    option broadcast-address 192.227.3.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.227.4.0 netmask 255.255.255.0 {
    range 192.227.4.12 192.227.4.20;
    range 192.227.4.160 192.227.4.168;
    option routers 192.227.4.111;
    option broadcast-address 192.227.4.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
"

# Check if the file exists
if [ -f "$file_to_modify" ]; then
    # Check if the marker exists in the file
    if grep -q "$marker_start" "$file_to_modify" && grep -q "$marker_end" "$file_to_modify"; then
        echo -e "${BG_GREEN}Script already exists in $file_to_modify${RESET}"
    else
        # Append the marker and script to the end of the file
        echo -e "$marker_start\n$script_to_append\n$marker_end" >> "$file_to_modify"
        if [ $? -eq 0 ]; then
            echo -e "${BG_GREEN}Script appended to $file_to_modify${RESET}"
        else
            echo -e "${BG_RED}Error appending script to $file_to_modify${RESET}"
        fi
    fi
else
    echo -e "${BG_RED}File $file_to_modify not found. Please update the script with the correct path.${RESET}"
fi


# Restarting services
echo -e "${BG_BLUE}Restarting services ...${RESET}"
service isc-dhcp-server stop
service isc-dhcp-server start

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
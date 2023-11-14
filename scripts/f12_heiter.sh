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
apt-get install -y bind9

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Update named.conf.local
echo -e "${BG_BLUE}Updating /etc/bind/named.conf.local ...${RESET}"

echo 'zone "riegel.canyon.f12.com" {
        type master;
        file "/etc/bind/f12/riegel.canyon.f12.com";
};

zone "granz.channel.f12.com" {
        type master;
        file "/etc/bind/f12/granz.channel.f12.com";
};
' > /etc/bind/named.conf.local

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}/etc/bind/named.conf.local updated successfully.${RESET}"
else
  echo -e "${BG_RED}Error updating /etc/bind/named.conf.local${RESET}"
  exit 1
fi


# Making directories
echo -e "${BG_BLUE}Configuring files ...${RESET}"
directories=("f12")
base_directory="/etc/bind"

for dir in "${directories[@]}"; do
    mkdir "$base_directory/$dir"
    if [ -d "$base_directory/$dir" ]; then
        echo -e "${BG_GREEN}Directory '$base_directory/$dir' created successfully.${RESET}"
    else
        echo -e "${BG_RED}Failed to create directory '$base_directory/$dir'.${RESET}"
    fi
done


# Configuring riegel.canyon.f12.com
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.f12.com. root.riegel.canyon.f12.com. (
			    2023110101    ; Serial
                        604800        ; Refresh
                        86400         ; Retry
                        2419200       ; Expire
                        604800 )      ; Negative Cache TTL
;
@               IN      NS      riegel.canyon.f12.com.
@               IN      A       192.227.4.1 ; IP Lugner
www             IN      CNAME   riegel.canyon.f12.com.
' > /etc/bind/f12/riegel.canyon.f12.com

# Configuring granz.channel.f12.com
echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.f12.com. root.granz.channel.f12.com. (
			    2023110101    ; Serial
                        604800        ; Refresh
                        86400         ; Retry
                        2419200       ; Expire
                        604800 )      ; Negative Cache TTL
;
@               IN      NS      granz.channel.f12.com.
@               IN      A       192.227.3.1 ; IP Fern
www             IN      CNAME   granz.channel.f12.com.
' > /etc/bind/f12/granz.channel.f12.com


# Restarting services
echo -e "${BG_BLUE}Restarting services ...${RESET}"
service bind9 restart

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

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
apt-get install -y mariadb-server

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Allowing worker to access the database
file_to_modify="/etc/mysql/my.cnf"
echo -e "${BG_BLUE}Updating $file_to_modify ...${RESET}"

echo '[client-server]

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address
' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify updated successfully.\n Please create user for the database${RESET}"
else
  echo -e "${BG_RED}Error updating $file_to_modify.${RESET}"
fi


# Restarting services
echo -e "${BG_CYAN}Restarting services ...${RESET}"
service mysql restart

echo -e "${BG_MAGENTA}DONE${RESET}"
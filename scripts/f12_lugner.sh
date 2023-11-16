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
apt-get install -y wget unzip nginx php php-fpm htop

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Downloading file
cd /root
echo -e "${BG_BLUE}Download and unziping...${RESET}"
wget -O 'granz.channel.yyy.com.zip' 'https://drive.usercontent.google.com/download?id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1'
unzip granz.channel.yyy.com.zip
mv modul-3/* /var/www/html
echo -e "${BG_GREEN}File moved to /var/www/html${RESET}"


# Configuring nginx
# /etc/nginx/sites-available/default
file_to_modify="/etc/nginx/sites-available/default"
echo -e "${BG_BLUE}Configuring $file_to_modify${RESET}"
echo 'server {

listen 80;

root /var/www/html;

index index.php index.html index.htm;
server_name _;

location / {
        try_files $uri $uri/ /index.php?$query_string;
}

# pass PHP scripts to FastCGI server
location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.3-fpm.sock;
}

location ~ /\.ht {
        deny all;
}

error_log /var/log/nginx/jarkom_error.log;
access_log /var/log/nginx/jarkom_access.log;
}' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify configured successfully.${RESET}"
else
  echo -e "${BG_RED}Error configuring $file_to_modify.${RESET}"
fi


# Restarting services
echo -e "${BG_CYAN}Restarting services ...${RESET}"
service php7.3-fpm start
service nginx restart

echo -e "${BG_MAGENTA}DONE${RESET}"
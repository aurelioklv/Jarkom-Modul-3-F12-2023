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

echo 'nameserver 192.227.1.2
nameserver 192.168.122.1
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
apt-get install -y nginx apache2-utils

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Configuring nginx
# /etc/nginx/sites-available/lb-jarkom
file_to_modify="/etc/nginx/sites-available/lb-jarkom"
echo -e "${BG_BLUE}Configuring $file_to_modify${RESET}"
echo 'upstream backend  {
server 192.227.3.1 weight=1; #IP Lugner
server 192.227.3.2 weight=2; #IP Linie
server 192.227.3.3 weight=4; #IP Lawine
}

server {
        listen 80;
        server_name granz.channel.f12.com;

        location / {
                include /etc/nginx/conf.d/ip-restrictions.conf;

                proxy_pass http://backend;
                proxy_set_header    X-Real-IP $remote_addr;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header    Host $http_host;

                auth_basic "Administrator'\''s Area";
                auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
        }

        location ~ /\.ht {
                deny all;
        }

        location ~ /its {
                proxy_pass https://www.its.ac.id;
        }

        error_log /var/log/nginx/lb_error.log;
        access_log /var/log/nginx/lb_access.log;

}' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify configured successfully.${RESET}"
else
  echo -e "${BG_RED}Error configuring $file_to_modify.${RESET}"
fi


# Unlink default config
echo -e "${BG_BLUE}Unlink defualt Nginx config ...${RESET}"
unlink /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled/
echo -e "${BG_GREEN}Unlink successful${RESET}"


# Configuring ip restriction
file_to_modify="/etc/nginx/conf.d/ip-restrictions.conf"
echo -e "${BG_BLUE}Configuring IP restriction at $file_to_modify${RESET}"
echo 'allow 192.227.3.69;
allow 192.227.3.70;
allow 192.227.4.167;
allow 192.227.4.168;
deny all;' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify configured successfully.${RESET}"
else
  echo -e "${BG_RED}Error configuring ip restriction at $file_to_modify.${RESET}"
fi


# Making benchmark output directory
echo -e "${BG_BLUE}Making benchmark output directory at ~/benchmark ...${RESET}"
mkdir -p ~/benchmark
echo -e "${BG_GREEN}Success. Please use -g ~/benchmark/<filename> for apache benchmark${RESET}"


# Making authentication directory
echo -e "${BG_BLUE}Making rahasiakita and .htpasswd ...${RESET}"
mkdir -p /etc/nginx/rahasiakita
touch /etc/nginx/rahasiakita/.htpasswd
htpasswd -b /etc/nginx/rahasiakita/.htpasswd netics ajkf12
echo -e "${BG_GREEN}rahasiakita and .htpasswd created.${RESET}"


# Restarting services
echo -e "${BG_BLUE}Restarting services ...${RESET}"
service nginx restart

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

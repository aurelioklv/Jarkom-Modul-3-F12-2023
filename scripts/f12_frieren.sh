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
cd /root
echo -e "${BG_BLUE}Installing requirements...${RESET}"
apt-get update
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
apt-get install php8.0-mbstring php8.0-xml php8.0-cli php8.0-common php8.0-intl php8.0-opcache php8.0-readline php8.0-mysql php8.0-fpm php8.0-curl unzip wget -y
apt-get install -y git mariadb-client nginx
wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}Requirements installed successfully.${RESET}"
else
  echo -e "${BG_RED}Error installing requirements.${RESET}"
  exit 1
fi


# Setting up project
echo -e "${BG_BLUE}Setting up project.${RESET}"
cd /var/www
git clone https://github.com/martuafernando/laravel-praktikum-jarkom
cd laravel-praktikum-jarkom
composer update
composer install
echo -e "${BG_GREEN}The project was set up successfully${RESET}"


# Copying .env
file_to_modify="/var/www/laravel-praktikum-jarkom/.env"
echo -e "${BG_BLUE}Configuring $file_to_modify${RESET}"
echo 'APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

LOG_CHANNEL=stack
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=debug

DB_CONNECTION=mysql
DB_HOST=192.227.2.1
DB_PORT=3306
DB_DATABASE=kelompokf12
DB_USERNAME=kelompokf12
DB_PASSWORD=qwe123

BROADCAST_DRIVER=log
CACHE_DRIVER=file
FILESYSTEM_DISK=local
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

MEMCACHED_HOST=127.0.0.1

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=smtp
MAIL_HOST=mailpit
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_HOST=
PUSHER_PORT=443
PUSHER_SCHEME=https
PUSHER_APP_CLUSTER=mt1

VITE_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
VITE_PUSHER_HOST="${PUSHER_HOST}"
VITE_PUSHER_PORT="${PUSHER_PORT}"
VITE_PUSHER_SCHEME="${PUSHER_SCHEME}"
VITE_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"' > "$file_to_modify"

if [ $? -eq 0 ]; then
  echo -e "${BG_GREEN}$file_to_modify configured successfully.${RESET}"
else
  echo -e "${BG_RED}Error configuring $file_to_modify.${RESET}"
fi


# Configuring nginx
# /etc/nginx/sites-available/default
file_to_modify="/etc/nginx/sites-available/default"
echo -e "${BG_BLUE}Configuring $file_to_modify${RESET}"
echo 'server {

listen 8003;

root /var/www/laravel-praktikum-jarkom/public;

index index.php index.html index.htm;
server_name _;

location / {
        try_files $uri $uri/ /index.php?$query_string;
}

# pass PHP scripts to FastCGI server
location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.0-fpm.sock;
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


# DB migration
echo -e "${BG_BLUE}Starting db migration${RESET}"
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage
php artisan migrate
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret
php artisan cache:clear
echo -e "${BG_GREEN}DB migration done${RESET}"


# Restarting services
echo -e "${BG_CYAN}Restarting services ...${RESET}"
service php8.0-fpm start
service nginx restart

echo -e "${BG_MAGENTA}DONE${RESET}"
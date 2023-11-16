
ab -n 100 -c 10 -p register.json -T application/json http://192.227.4.1:8001/api/auth/register
ab -n 100 -c 10 -p login.json -T application/json http://192.227.4.1:8001/api/auth/login

curl -X POST -H "Content-Type: application/json" -d @login.json http://192.227.4.1:8001/api/auth/login > login_output.txt
token=$(cat login_output.txt | jq -r '.token')
ab -n 100 -c 10 -H "Authorization: Bearer $token" http://192.227.4.1:8001/api/me

ab -n 100 -c 10 -p login.json -T application/json http://riegel.canyon.f12.com/api/auth/login


# Script 1
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 4
pm.start_servers = 1
pm.min_spare_servers = 1
pm.max_spare_servers = 4' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart


# Script 2
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 15
pm.start_servers = 5
pm.min_spare_servers = 4
pm.max_spare_servers = 8' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart


# Script 2
echo '[www]
user = www-data
group = www-data
listen = /run/php/php8.0-fpm.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off

; Choose how the process manager will control the number of child processes.

pm = dynamic
pm.max_children = 50
pm.start_servers = 15
pm.min_spare_servers = 10
pm.max_spare_servers = 20' > /etc/php/8.0/fpm/pool.d/www.conf

service php8.0-fpm restart
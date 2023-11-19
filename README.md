# Jarkom-Modul-3-F12-2023

| Nama | NRP |
| ----------- | ----------- |
| Aurelio Killian Lexi Verrill | 5025211126 |
| Rano Noumi Sulistyo | 5025211185 | 

## Daftar Isi

- [Topologi](#topologi)
- [Konfigurasi](#konfigurasi)
- [Prerequisite](#prerequisite)
- [Soal 0](#soal-0)
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)

## Topologi

<p align="center">
  <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/d83e6846-ee1d-4b93-8e22-f44790901967" alt='Topologi' />
</p>

## Konfigurasi

<details>

<summary>Aura</summary>

```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.227.1.111
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 192.227.2.111
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 192.227.3.111
    netmask 255.255.255.0

auto eth4
iface eth4 inet static
    address 192.227.4.111
    netmask 255.255.255.0
```   

</details>

<details>

<summary>Himmel</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.1.1
	netmask 255.255.255.0
	gateway 192.227.1.111
```   

</details>

<details>

<summary>Heiter</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.1.2
	netmask 255.255.255.0
	gateway 192.227.1.111
```   

</details>

<details>

<summary>Denken</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.2.1
	netmask 255.255.255.0
	gateway 192.227.2.111
```   

</details>

<details>

<summary>Eisen</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.2.2
	netmask 255.255.255.0
	gateway 192.227.2.111
```   

</details>

<details>

<summary>Lugner</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.3.1
	netmask 255.255.255.0
	gateway 192.227.3.111
```   

</details>

<details>

<summary>Linie</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.3.2
	netmask 255.255.255.0
	gateway 192.227.3.111
```   

</details>

<details>

<summary>Lawine</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.3.3
	netmask 255.255.255.0
	gateway 192.227.3.111
```   

</details>

<details>

<summary>Fern</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.4.1
	netmask 255.255.255.0
	gateway 192.227.4.111
```   

</details>

<details>

<summary>Flamme</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.4.2
	netmask 255.255.255.0
	gateway 192.227.4.111
```   

</details>

<details>

<summary>Frieren</summary>

```
auto eth0
iface eth0 inet static
	address 192.227.4.3
	netmask 255.255.255.0
	gateway 192.227.4.111
```   

</details>

<details>

<summary>Client (Revolte, Richter, Stark, Sein)</summary>

```
auto eth0
iface eth0 inet dhcp
```   

</details>

## Prerequisite

<details>

<summary>Aura</summary>

1. Jalankan command berikut
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.227.0.0/16
```

2. Install isc-dhcp-relay
```
apt-get update
apt-get install -y isc-dhcp-relay
```

3. Masukkan konfigurasi berikut pada ```/etc/default/isc-dhcp-relay```
```
SERVERS="192.227.1.1"
INTERFACES="eth1 eth3 eth4"
OPTIONS=
``` 

4. Uncomment ```net.ipv4.ip_forward = 1``` pada ```/etc/sysctl.conf``` kemudian restart ```isc-dhcp-relay```

</details>

<details>

<summary>Semua node kecuali client dan aura</summary>

1. Tambahkan isi ```/etc/resolv.conf``` dari Aura pada tiap node
```
nameserver 192.168.122.1
```

</details>

## Soal 0
> Register domain berupa riegel.canyon.yyy.com untuk worker Laravel dan granz.channel.yyy.com untuk worker PHP, mengarah pada worker yang memiliki IP [prefix IP].x.1.

1. Install bind9 pada **Heiter**
```
apt-get update
apt-get install -y bind9
```

2. Tambahkan zone berikut pada ```/etc/bind/named.conf.local```
```
zone "riegel.canyon.f12.com" {
        type master;
        file "/etc/bind/f12/riegel.canyon.f12.com";
};

zone "granz.channel.f12.com" {
        type master;
        file "/etc/bind/f12/granz.channel.f12.com";
};
```

3. Buat file ```/etc/bind/f12/riegel.canyon.f12.com``` dan ```/etc/bind/f12/granz.channel.f12.com```.

4. Masukkan konfigurasi berikut pada file yang bersesuaian
```
;
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
@               IN      A       192.227.4.1 ; IP Fern
www             IN      CNAME   riegel.canyon.f12.com.

```

```
;
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
@               IN      A       192.227.3.1 ; IP Lugner
www             IN      CNAME   granz.channel.f12.com.

```

5. Restart bind9

6. Lakukan test
```
ping riegel.canyon.f12.com
ping granz.channel.f12.com
```

<p align="center">
  <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/61581cf2-ae64-40e6-a8fb-42c70ff76fdc" alt='Soal 0' />
</p>


## Soal 1
> Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

1. Install isc-dhcp-server pada **Himmel**
```
apt-get update
apt-get install -y isc-dhcp-server
```

2. Masukkan konfigurasi berikut pada ```/etc/default/isc-dhcp-server```
```
INTERFACES="eth0"
```

3. Buat subnet berikut pada ```/etc/dhcp/dhcpd.conf```
```
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
```

4. Restart isc-dhcp-server
```
service isc-dhcp-server stop
service isc-dhcp-server start
```

5. Client akan mendapat IP dari DHCP Server (Himmel). Cek dengan mematikan dan menghidupkan kembali node Client.

## Soal 2
> Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80

1. Tambahkan baris ```range 192.227.3.16 192.227.3.32;``` dan ```range 192.227.3.64 192.227.3.80;``` di dalam blok ```subnet 192.227.3.0 netmask 255.255.255.0``` pada ```/etc/dhcp/dhcpd.conf``` **Himmel**
```
subnet 192.227.3.0 netmask 255.255.255.0 {
    range 192.227.3.16 192.227.3.32;
    range 192.227.3.64 192.227.3.80;
    option routers 192.227.3.111;
    option broadcast-address 192.227.3.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}
```

## Soal 3
> Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168

1. Tambahkan baris ```range 192.227.4.12 192.227.4.20;``` dan ```range 192.227.4.160 192.227.4.168;``` di dalam blok ```subnet 192.227.4.0 netmask 255.255.255.0``` pada ```/etc/dhcp/dhcpd.conf``` **Himmel**
```
subnet 192.227.4.0 netmask 255.255.255.0 {
    range 192.227.4.12 192.227.4.20;
    range 192.227.4.160 192.227.4.168;
    option routers 192.227.4.111;
    option broadcast-address 192.227.4.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
```

## Soal 4
> Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

1. Masukkan konfigurasi DNS Forwarding berikut pada **Heiter**
```
options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      auth-nxdomain no;    # conform to RFC1035
      listen-on-v6 { any; };
}; 
```

2. Client berhasil mendapatkan nameserver 192.227.1.2 secara otomatis dari DHCP Server (Heiter) dan dapat terhubung ke internet

<p align="center">
  <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/712f349c-db90-45f3-83a4-f88383cee962" alt='Soal 4' />
</p>

## Soal 5
> Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit

1. Tambahkan baris ```default-lease-time 180;``` dan ```max-lease-time 5760;``` di dalam blok ```subnet 192.227.3.0 netmask 255.255.255.0``` pada ```/etc/dhcp/dhcpd.conf``` **Himmel**
```
subnet 192.227.3.0 netmask 255.255.255.0 {
    range 192.227.3.16 192.227.3.32;
    range 192.227.3.64 192.227.3.80;
    option routers 192.227.3.111;
    option broadcast-address 192.227.3.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}
```

2. Tambahkan baris ```default-lease-time 720;``` dan ```max-lease-time 5760;``` di dalam blok ```subnet 192.227.4.0 netmask 255.255.255.0``` pada ```/etc/dhcp/dhcpd.conf``` **Himmel**
```
subnet 192.227.4.0 netmask 255.255.255.0 {
    range 192.227.4.12 192.227.4.20;
    range 192.227.4.160 192.227.4.168;
    option routers 192.227.4.111;
    option broadcast-address 192.227.4.255;
    option domain-name-servers 192.227.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}
```

## Soal 6
> Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3.

1. Install beberapa tools
```
apt-get update
apt-get install -y wget unzip nginx php php-fpm htop
```

2. Download file dan unzip
```
wget -O 'granz.channel.yyy.com.zip' 'https://drive.usercontent.google.com/download?id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1'
unzip granz.channel.yyy.com.zip
mv modul-3/* /var/www/html
```

3. Masukkan konfigurasi berikut pada ```/etc/nginx/sites-available/default```
```
server {

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
}
```

4. Restart service
```
service php7.3-fpm start
service nginx restart
```

5. Akses website dari client atau worker
```
lynx localhost
lynx granz.channel.f12.com
```

<p align="center">
  <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/b3ffb2cc-fdd6-45cf-b353-8b734c19cb4f" alt='Soal 6' />
</p>

## Soal 7
> Kepala suku dari Bredt Region memberikan resource server sebagai berikut:
> - Lawine, 4GB, 2vCPU, dan 80 GB SSD.
> - Linie, 2GB, 2vCPU, dan 50 GB SSD.
> - Lugner 1GB, 1vCPU, dan 25 GB SSD.
> aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second.

1. Ubah konfiguarsi ```/etc/bind/f12/granz.channel.f12.com``` pada **Heiter** untuk menuju ke IP Eisen kemudian restart bind9
```
;
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
@               IN      A       192.227.2.2 ; IP Eisen
www             IN      CNAME   granz.channel.f12.com.

```

2. Pada **Eisen**, masukkan konfigurasi berikut pada ```/etc/nginx/sites-available/lb-php```
```
upstream backendphp  {
server 192.227.3.1 weight=1; #IP Lugner
server 192.227.3.2 weight=4; #IP Linie
server 192.227.3.3 weight=8; #IP Lawine
}

server {
        listen 80;
        server_name granz.channel.f12.com;

        location / {
                include /etc/nginx/conf.d/ip-restrictions.conf;

                proxy_pass http://backendphp;
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

        error_log /var/log/nginx/lb_php_error.log;
        access_log /var/log/nginx/lb_php_access.log;

}
```

3. Restart nginx Eisen

4. Lakukan benchmark dari Client
```
ab -n 1000 -c 100 http://granz.channel.f12.com/
```

<p align="center">
  <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Weighted Round Robin' />
</p>

## Soal 8
> Buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer

1. Ubah block ```upstream backendphp``` pada ```/etc/nginx/sites-available/lb-php``` **Eisen** untuk menggunakan algoritma tertentu. Pastikan untuk restart nginx sebelum melakukan benchmark
```
# Weighted Round Robin
upstream backendphp  {
server 192.227.3.1 weight=1; #IP Lugner
server 192.227.3.2 weight=2; #IP Linie
server 192.227.3.3 weight=4; #IP Lawine
}
```
```
# Round Robin
upstream backendphp  {
server 192.227.3.1; #IP Lugner
server 192.227.3.2; #IP Linie
server 192.227.3.3; #IP Lawine
}
```
```
# Least Connection
upstream backendphp  {
least_conn;
server 192.227.3.1; #IP Lugner
server 192.227.3.2; #IP Linie
server 192.227.3.3; #IP Lawine
}
```
```
# IP Hash
upstream backendphp  {
ip_hash;
server 192.227.3.1; #IP Lugner
server 192.227.3.2; #IP Linie
server 192.227.3.3; #IP Lawine
}
```
```
# Generic Hash
upstream backendphp  {
hash $request_uri consistent;
server 192.227.3.1; #IP Lugner
server 192.227.3.2; #IP Linie
server 192.227.3.3; #IP Lawine
}
```

2. Lakukan benchmark dari Client
```
ab -n 200 -c 10 http://granz.channel.f12.com/
```
- Weighted Round Robin
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Weighted Round Robin' />
    </p>
    
- Round Robin
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Round Robin' />
    </p>

- Least Connection
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Least Connection' />
    </p>

- IP Hash
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='IP Hash' />
    </p>

- Generic Hash
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Generic Hash' />
    </p>

## Soal 9
> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire

1. Comment beberapa server pada blok ```upstream backendphp``` untuk mengatur banyaknya worker yang bekerja kemudian restart nginx
```
# Round Robin
upstream backendphp  {
server 192.227.3.1; #IP Lugner
# server 192.227.3.2; #IP Linie
# server 192.227.3.3; #IP Lawine
}
```

2. Lakukan benchmark dari Client
```
ab -n 100 -c 10 http://granz.channel.f12.com/
```

- 1 Worker
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Round Robin 1 Worker' />
    </p>

- 2 Worker
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Round Robin 2 Worker' />
    </p>

- 3 Worker
    <p align="center">
    <img src="https://repository-images.githubusercontent.com/211751560/9f445f80-e35e-11e9-9977-bd2a8c863c24" alt='Round Robin 3 Worker' />
    </p>


## Soal 10
> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/rahasisakita/

1. Tambahkan konfigurasi berikut pada blok ```location /``` pada ```/etc/nginx/sites-available/lb-php``` kemudian restart nginx
```
auth_basic "Administrator's Area";
auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
```

2. Buat direktori ```rahasiakita``` dan file ```.htpasswd``` di dalamnya

3. Daftarkan sebuah username dan password pada file tersebut
```
htpasswd -b /etc/nginx/rahasiakita/.htpasswd netics ajkf12
```

4. Akses website dari Client menggunakan Lynx. Client akan diminta untuk memasukkan username dan password untuk mengaksesnya.


<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/c680249e-7e33-4bb5-9c3e-d7b8ad0bba6c" alt='Auth' />
</p>

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/91c30f4e-82c1-4d00-ac71-148b6bc81002" alt='Auth' />
</p>

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/bde9e369-4559-4783-92a0-f36104c5f5d2" alt='Auth' />
</p>

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/a4751d7a-5983-4f8c-8e2c-f5261de42c27" alt='Auth' />
</p>

## Soal 11
> Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju halaman https://www.its.ac.id

1. Buat sebuah block ```location ~ /its``` pada ```/etc/nginx/sites-available/lb-php``` **Eisen** kemudian restart nginx
```
location ~ /its {
        proxy_pass https://www.its.ac.id;
}
```

2. Akses website dari Client
```
lynx granz.channel.f12.com/its
lynx granz.channel.f12.com/loremipsum/its
```

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/1bc7b796-41ec-43e5-a93d-ec19f91e1266" alt='Proxy Pass' />
</p>

## Soal 12
> Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP].3.69, [Prefix IP].3.70, [Prefix IP].4.167, dan [Prefix IP].4.168.

1. Buat sebuah file untuk menyimpan restriksi IP. Dalam hal ini ```/etc/nginx/conf.d/ip-restrictions.conf``` yang berisi sebagai berikut
```
allow 192.227.3.69;
allow 192.227.3.70;
allow 192.227.4.167;
allow 192.227.4.168;
deny all;
```

2. Include file tersebut pada block ```location /``` pada ```/etc/nginx/sites-available/lb-php``` **Eisen** kemudian restart nginx
```
location / {
        include /etc/nginx/conf.d/ip-restrictions.conf;

        proxy_pass http://backendphp;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    Host $http_host;

        auth_basic "Administrator's Area";
        auth_basic_user_file /etc/nginx/rahasiakita/.htpasswd;
}
```

3. Akses website dari Client. Client dengan IP yang tidak memenuhi persyaratan tidak dapat mengakses website ```granz.channel.f12.com```

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/8b214cdd-f874-49f7-b90c-b7f0d824c580" alt='IP Restriction' />
</p>

## Soal 13
> Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren, Flamme, dan Fern. 

1. Install mariadb-server pada Denken
```
apt-get update
apt-get install -y mariadb-server
```

2. Masukkan konfigurasi berikut pada ```/etc/mysql/my.cnf```
```
[client-server]

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address
```

3. Restart mysql

4. Jalankan command mysql lalu buat beberapa user dan database
```
mysql -u root -p
```
```
CREATE USER 'kelompokf12'@'%' IDENTIFIED BY 'qwe123';
CREATE USER 'kelompokf12'@'localhost' IDENTIFIED BY 'qwe123';
CREATE DATABASE kelompokf12;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf12'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokf12'@'localhost';
FLUSH PRIVILEGES;
```

5. Pada worker Laravel, install mariadb-client

6. Akses server database Denken dari worker Laravel
```
mysql -u kelompokf12 -h 192.227.2.1 -p -D kelompokf12
```

<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/7fe07a6b-7ee7-44e0-b4f3-2219cbb89b1c" alt='Database Server' />
</p>
<p align="center">
    <img src="https://github.com/aurelioklv/Jarkom-Modul-3-F12-2023/assets/87407047/5601da2c-b353-4409-a747-a357ad1f1078" alt='Database Client' />
</p>
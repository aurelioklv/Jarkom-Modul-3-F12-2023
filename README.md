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

3. Buat file ```/etc/bind/f12/riegel.canyon.f12.com``` dan ```/etc/bind/f12/granz.channel.f12.com"```.

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

1. Client berhasil mendapatkan nameserver 192.227.1.2 secara otomatis dari DHCP Server (Heiter)

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
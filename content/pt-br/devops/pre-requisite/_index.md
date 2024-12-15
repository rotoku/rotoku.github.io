---
title: "Pre-Requisite"
linkTitle: "Pre-Requisite"
date: 2024-11-25
weight: 16
---

---------------
---------------
---------------

# Pre-Requisite

## Linux Basics
## Setup Lab Environment
```
### RPM (Red Hat Package Manager)
rpm -i telnet.rpm # Install
rpm -e telnet # Uninstall
rpm -qa telnet # Query
### YUM (/etc/yum.repos.d)
yum update
yum install ansible
yum repolist
yum remove ansible

### Services
service httpd start
OR 
systemctl start httpd

systemctl stop httpd
systemctl status httpd

systemctl status docker
```

```/etc/systemd/system/my_app.service 
[Unit]
Description=My Application

[Service]
ExecStart=/usr/bin/python3 /opt/code/my_app.py
Restart=always

[Install]
WantedBy=multi-user.target
```

```
systemctl daemon-reload ## reload services created
systemctl start my-app
systemctl reload my-app
systemctl restart my-app
sudo systemctl enable my-app ## add on startup
sudo systemctl disable my-app ## remove on startup
systemctl edit my-app
### specific to user
/usr/lib/systemd/system

sudo systemctl get-default
graphical.target
sudo systemctl set-default multi-user.target
sudo systemctl list-units --all

sudo journalctl -u docker.service
```

## Linux Networking Basics
```
ip link
ip addr
ip addr add 192.168.1.10/24 dev eth0
sudo ip link set dev eth0 up
sudo ip r add default via 172.16.238.1

ip route
ip route add 192.168.1.0/24 via 192.168.2.1

### Permitir encaminhamento de pacote via interface de redes distintas
cat /proc/sys/net/ipv4/ip_forward
0: disable
1: enable

cat /etc/sysctl.conf
net.ipv4.ip_forward=1

sudo ip addr add 172.16.238.15/24 dev eth0
ip addr

sudo ip addr add 172.16.238.16/24 dev eth0
ip addr

sudo ip addr add 172.16.239.15/24 dev eth0
ip addr

sudo ip addr add 172.16.239.16/24 dev eth0
ip addr

sudo ip addr add 172.16.239.10/24 dev eth0
ip addr

ip route
sudo ip route add 172.16.239.0/24 via 172.16.238.10

ip route
sudo ip route add 172.16.238.0/24 via 172.16.239.10

ping -c 4 app01
ping -c 4 app02
ping -c 4 app03
ping -c 4 app04
```

```
.deb:
- ubuntu
- debian
- linux mint

.rpm:
- rhel
- centos
- fedora
```

## Package Managers
```
- dpkg (debian, ubuntu, PureOS)
    - dpkg -i telnet.deb # install
    - dpkg -r telnet.deb # uninstall
    - dpkg -l telnet.deb # list
    - dpkg -s telnet.deb # status
    - dpkg -p <path to file> # verify
- apt (Advanced Package Tool)[+] "/etc/apt/sources.list"
    - apt update # refresh the repository
    - apt upgrade # upgrade the packages
    - apt edit-sources
    - apt install telnet
    - apt remove telnet
    - apt search telnet
- apt-get[-]
- rpm
    - rpm -ivh telnet.rpm # install
    - rpm -e telnet.rpm # uninstall
    - rpm -Uvh telnet.rpm # upgrade
    - rpm -q telnet.rpm # query
    - rpm -Vf telnet.rpm # verify
- yum
    - yum repolist # list repos add into repo
    - yum provides scp # who provider the tech
    - yum install maven # install
    - yum remove maven # uninstall
    - yum search maven # search
    - yum update maven # update single package
    - yum update # update all packages
- dnf
```

## apt-get vs apt
- apt is more friendly and is possible to see progress
- find packages is easier, because we use the same command

## File Types:
drwxr-xr-x 2 rkumabe rkumabe 4.0K Dec  4 17:59 Downloads
brw-rw----   1 root    disk        8,     1 Dec  4 18:28 sda1
crw-rw-rw-   1 root    tty         5,     2 Dec  4 18:32 ptmx
lrwxrwxrwx   1 root    root              15 Dec  3 14:05 stdin -> /proc/self/fd/0
-rw-r--r--  1 rkumabe rkumabe  807 Mar 31  2024 .profile
srw-rw----  1 root              docker    0 Dec  3 14:05 docker.sock=

- Directory "d"
- Regular File "-"
- Character Device "c"
- Link "l"
- Socket File "s"
- Pipe "p"
- Block Device "b"

## Viewing File Sizes
```
du -sk /mnt/DATA/git/rotoku/rotoku.github.io (kilobytes)
du -sh /mnt/DATA/git/rotoku/rotoku.github.io (user readable)
```

## Archiving Files
```
tar -cf test.tar file1 file2 file3 (c = compress, f = filename)

tar -tf test.tar (usado para ver o conteúdo do tarball file)

tar -xf test.tar (extract content)

tar -zcf test.tar file1 file2 file3 (c = compress, f = filename, z = zip)
```

## Compressing
```
bzip2 teste.img
4k

gzip teste.img
100k

xz teste.img
16k
```

## Uncompressing
```
bunzip2 teste.img.bz2

gunzip teste.img.gz

unxz teste.img.xz
```

## List content on compressing file
```
zcat teste.img.gz
bzcat teste.img.bz2
xzcat teste.img.xz
```

## Searching for Files and Directories
```
sudo apt install locate
locate pod-definition.yaml
updatedb

find . -name pod-definition.yaml
find . -type f -name pod-definition.yaml

grep "Pod" pod-definition.yaml
grep -i "pod" pod-definition.yaml # ignore case sensitive
grep -r "Pod" pod-definition.yaml # recursive
grep -v "Pod" pod-definition.yaml # ignore the word
grep -w "Pod" pod-definition.yaml # entire word
grep -vw "pod" pod-definition.yaml # Ignore pod words

grep A1 "Pod" pod-definition.yaml # after line and the line
grep B1 "Pod" pod-definition.yaml # before line and the line
```

## IO Redirection
- Standard Input
    - 
- Standard Output
    - 
- Standard Error
    - find . -name pod-definition.yaml 2>error.txt
- Command Line Pipes
    - kubectl get pods -n develop | grep frontend
    - echo $SHELL | tee shell.txt # print content from SHELL variable and create file shell.txt, with we add flag -a in tee command, is possible to append output into shell.txt file


## Vi Editor
- command mode (:)
    - dd (cut)
    - yy (copy)
    - p (paste)
    - d3d (delete 3 lines)
    - u (undo)
    - Ctrl + r (redo)
    - /line
        - n (next)
        - N (previous)
    - :5
    - :w (write)
    - :q (quite)
    - :wq (write and quit)
    - :q! (quit without save)
- insert mode (i,o,a)
- last line (esc)

## Account Type
- root (0)
- user (1001)
- system account (500 - 1000)
- service account (500 - 1000)

## Access Control Files
```
cat /etc/sudoers
cat /etc/passwd
cat /etc/shadow
cat /etc/group
```

## Managing Users
```
useradd bob # create user
passwd bob  # set password

useradd -u 1009 -g 1009 -d /home/bob -s /bin/bash -c "lamiso Project Member" bob

userdel bob

groupadd -g 1011 developer

groupdel developer

useradd -u 1010 -g 1010 -d /home/john -s /bin/sh john
```

## File Permissions and Ownership
```
- rwx   rwx     r-x
  owner group   others
  u     g       o

Files:
|r|read|4|
|w|write|2|
|x|execute|1| 
chmod <permissions> file
chmod u+rwx main.py
chmod 0-rwx main.py
chmod 660 main.py

Directories:
|r|read|4|
|w|write|2|
|x|execute|1| 
|-|no permission|0|
chown owner:group file
chown rkumabe:rkumabe /home/bob
```

## ssh and scp
```
ssh <hostname or ip address>
ssh <user>@<hostname or ip address>
ssh -l <user> <hostname or ip address>
ssh -i '~/.ssh/id_rsa' <user>@<hostname or ip address>
```

```
ssh-keygen -t rsa
ssh-copy-id <user>@<hostname or ip address>
cat ~/.ssh/authorized_keys
```

```
scp /home/rkumabe/Download/main.py centos:/home/rkumabe
scp -pr /home/rkumabe/Download/main.py centos:/home/rkumabe # prevent the permission
```

## IP Tables
```
sudo apt install iptables
sudo iptables -L

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy DROP)
target     prot opt source               destination               

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination 


IP Tables follow a chain

iptables -A INPUT -p tcp -s 172.16.238.187 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

iptables -A OUTPUT -p tcp -d 172.16.238.11 --dport 5432 -j ACCEPT
iptables -A OUTPUT -p tcp -d 172.16.238.15 --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j DROP
iptables -A OUTPUT -p tcp --dport 80 -j DROP

iptables -I OUTPUT -p tcp -d 172.16.238.100 --dport 443 -j ACCEPT # -I flag insert the rule in the top

iptables -D OUTPUT 5 # Delete Rules

32768 - 60999
```

|Option|Description|
|------|------|
|-A|Add Rule|
|-p|Protocol|
|-s|Source|
|-d|Destination|
|--dport|Destination Port|
|-j|Action to take|

## Storage
```
ls -l /dev/ | grep "^b"
lsblk


|Major Number|Device Type|
|------------|------------|
|1|RAM|
|3|HARD DISK or CD ROM|
|6|PARALLEL PRINTERS|

sudo fdisk -l /dev/nvme0n1

### Partition Types:
- Primary (pode ser usada para inicializar um sistema operacional, tradicionalmente, os discos eram limitados a não mais que quatro partições primárias por disco.)
- Extended (uma partição estendida é um tipo de partição que não pode ser usada sozinha, mas pode hospedar partições lógicas.)
- Logical ()


MBR: Master Boot Record
GPT: GUID Partition Table, é um esquema de particionamento mais recente que foi criado para resolver as limitações do MBR.

sudo gdisk /dev/nvme0n1
```

## FileSystem
```
- ext2 - 2 TB - 4 TB - Supports Compression - Supports Linux Permissions - Long Crash Recovery
- ext3 - 2 TB - 4 TB - Uses Journal - backwards Compatible
- ext4 - 16 TB - 1 Exabyte - Uses Journal - Uses chksum for Journal - backwards Compatible

# Working with ext4

mkfs.ext4 /dev/sdb1
mkdir /mnt/ext4
mount /dev/sdb1 /mnt/ext4
mount | grep /dev/sdb1
df -hP | grep /dev/sdb1

## add on boot
echo "/dev/sdb1 /mnt/ext4 ext4 rw 0 0" >> /etc/fstab

Dump: 0 = Ignore, 1 = Take backup
Pass: 0 = Ignore, 1 or 2 = FSCK filesystem check enforced
```

## External Storage DAS, NAS and SAN
```
- DAS: Direct Attached Storage.
    - Block Storage
    - Fast and Reliable
    - Affordable
    - Dedicated to single host
    - Ideal for small business

- NAS: Network Attached Storage.
    - NFS / CIFS.
    - Reasonably Fast and Reliable.
    - File Based Storage.
    - Shared Storage.
    - Not suitable for OS Install.
    - Ideal for large business

- SAN: Storage Area Network. (Database, Virtualization)
    - FC or iSCSI.
    - Block Storage.
    - Fast, Secure and Reliable.
    - High Availability.
    - Expensive.
    - business critical workloads.
```

## NFS (Network File System)
```/etc/exports
/software/repos 10.61.35.201 10.61.35.202 10.61.35.203
```

```
exportfs -a
exportfs -o 10.61.35.201:/software/repos
mount 10.61.112.101:/software/repos /mnt/software/repos
```

## LVM (Logical Volume Manager)
```
sudo apt install lvm2
pvcreate /dev/sdb
vgcreate caleston_vg /dev/sdb
pvdisplay
vgdisplay
lvcreate -L 1G -n vol1 caleston_vg
lvs
mkfs.ext4 /dev/caleston_vg/vol1
mkdir -t ext4 /dev/caleston_vg/vol1 /mnt/vol1
vgs
lvresize -L +1G -n /dev/caleston_vg/vol1
df -hP /mny/vol1
resize2fs /dev/caleston_vg/vol1
df -hP /mny/vol1
```

```
iptables -A INPUT -p tcp -s 172.16.238.187 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.238.187 --dport 80 -j ACCEPT
iptables -A INPUT -j DROP

iptables -A OUTPUT -p tcp -d 172.16.238.15 --dport 5432 -j ACCEPT

iptables -A OUTPUT -p TCP -d 172.16.238.15 --dport 80 -j ACCEPT

iptables -A OUTPUT -p tcp --dport 80 -j DROP
iptables -A OUTPUT -p tcp --dport 443 -j DROP
iptables -I OUTPUT -p tcp -d google.com --dport 443 -j ACCEPT
```

```
sudo mkfs.ext4 /dev/vdb
sudo mkdir /mnt/data
sudo  mount /dev/vdb /mnt/data
```

```
sudo mkdir /mnt/media
sudo mkfs.ext4 /dev/mapper/caleston_vg-data
sudo mount /dev/mapper/caleston_vg-data /mnt/media/

sudo lvresize -L +500M -n  /dev/mapper/caleston_vg-data
sudo resize2fs  /dev/mapper/caleston_vg-data
```


## Java
```

```

## Python
```
pip install requests --upgrade
```

## Git
0. Install Git

1. Initialize a Git Repository
```
git init
```

2. Configure File to Track
```
git status
git add .
```

3. Git Tracks Changes
```
git status
```

4. Stage Changes
```
git add .
```

5. Commit Changes
```
git commit -m "feat: first commit"
```

## Remote Git Repository
```
git remote add <NAME> https://github.com/<USERNAME>/<PROJECT>.git
git push -u <NAME> <BRANCH>
git pull
git fetch
git clone https://github.com/<USERNAME>/<PROJECT>.git
```

## Web Server
- httpd
- nginx
- Apache Tomcat

## Database
- MySQL
- MongoDB

## Security
- SSL (Secure Socket Layer)/TLS
    - (-) Symmetric Encryption
    - (+) Asymmetric Encryption (pair of keys, public and private key)
        - ssh-keygen -t rsa
        - ssh-copy-id <user>@<hostname or ip address>

## YAML
```
k get pods -o jsonpath="{$.items[0].spec.containers[1].name}"
k get pods -o jsonpath="{$.items[0].spec.containers[?(@.image == 'nginx')].name}"
k get pods -o jsonpath="{$.items[0].status.qosClass}"

```

## [2 Tier Applications](https://github.com/kodekloudhub/learning-app-ecommerce)
- Conhecido também como uma aplicação monolito
- LAMP (PHP + Apache httpd + MySQL)
    - Linux CentOS + Firewall

## Lab Setup

- https://pm2.keymetrics.io/docs/usage/quick-start/
- https://gunicorn.org/

```
sudo su -
yum install -y mariadb-server
systemctl restart mariadb
systemctl enable mariadb
```

```
mysql
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
CREATE USER 'ecomuser'@'%' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'%';
FLUSH PRIVILEGES;
```

```
mysql < /opt/db-load-script.sql
```

```
yum update -y && yum install -y httpd php php-mysqlnd
```

```
mysql -u root
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'P@ssw0rd123';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('P@ssw0rd123');

use kk_db;
CREATE USER 'kk_user'@'localhost' IDENTIFIED BY 'S3cure#3214';
GRANT ALL PRIVILEGES ON *.* TO 'kk_user'@'localhost';
FLUSH PRIVILEGES;
```

## Install MongoDB
```/etc/yum.repos.d/mongodb-org-8.0.repo
[mongodb-org-8.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/8.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-8.0.asc
```

```
yum update -y && yum install -y mongodb-org
```

```
systemctl start mongod
systemctl enable mongod
```
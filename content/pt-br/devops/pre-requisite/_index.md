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
systemctl daemon-reload
systemctl start my-app
sudo systemctl enable my-app


### specific to user
/usr/lib/systemd/system
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
sudo systemctl get-default
graphical.target
sudo systemctl set-default multi-user.target
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
```
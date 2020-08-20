# Nextcloud Backup
## About
Strategy for back up Nextcloud and the User Data.
Backup 1: Backup User data, Nextcloud system data and Database to netwerk drive time controlled
Backup 2: Backup User data to external hard-disk every time the disk is plugged in
## Backup 1
### Install packages
1. Cifs Network Mount
```
$ sudo apt-get install cifs-utils keyutils
```
### Required files
1. Log in data for network drive
Create .credentials file in /root:
```
$ sudo nano /root/.credentials
```
Put your log in in it:
```
username:YOUR-USERNAME
password:YOUR-PASSWORD
```
2. Create Backup Folder in /mnt like
```
$ mkdir /mnt/backup_data
```
3. Create backup_data.sh in /root like
```
$ sudo nano /root/backup_data.sh
```
## Backup 2

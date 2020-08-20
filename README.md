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
$ sudo nano /root/backup_net_drive.sh
```
## Backup 2
### Required files
1. Create rule file that detects the harddrive and runs the script for backup
```
$ sudo nano /etc/udev/rules.d/50-backup.rules
```
2. Create Backup script
```
$ sudo nano /root/backup_mobil.sh
```


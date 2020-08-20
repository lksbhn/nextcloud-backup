#!/bin/bash
#
#
#
#Create Log
/usr/bin/logger Backup Mobil - Start am `date`

#Create Log in Cloud
echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
echo $(date)": Mounten der Backup Festplatte WD." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt

#Mount the Network Drive
/bin/mount -t cifs //192.168.178.22/K3Backup/02_Cloud -o credentials=~/.smbcredentials /mnt/backup_data

#If drive is mounted
if mountpoint -q /mnt/backup_data
then
    #Create Log in Cloud
    echo $(date)": Mounten erfolgreich." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt

    #Create Log
    /usr/bin/logger Backup Daten - Nextcloud Daten

    #Data Backup
    /usr/bin/rsync -rtv --del --modify-window=2 /mnt/nextclouddata/clouddata /mnt/backup_data/01_data 
    
    #Nextcloud System Backup
    /usr/bin/rsync -rtv --del --modify-window=2 /var/www/html /mnt/backup_data/02_system 

    #Force to sync the data
    /bin/sync

    #Database Backup
    mysqldump --single-transaction -h localhost -u nextcloud -p lukas nextcloud > /mnt/backup_data/03_database/db_backup_`date +"%Y%m%d"`.sql

    #Unmount
    /bin/umount /mnt/backup_data

    #If drive is still mounted
    if mountpoint -q /mnt/backup_data 
    then
        #Create Log in Cloud
        echo $(date)": Unmounten erfolglos! Abbruch." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
        echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
        #End Log
        /usr/bin/logger Backup Daten mit unmount error - Ende am `date`
    else
        #Create Log in Cloud
        echo $(date)": Unmounten erfolgreich." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
        echo $(date)": Backup erfolgreich abgeschlossen." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
        echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
        #End Log
        /usr/bin/logger Backup Daten - Ende am `date`
    fi

else #If first mounting attempt is unsuccessful
    #Create Log in Cloud
    echo $(date)": Mounten erfolglos! Abbruch." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    #End Log
    /usr/bin/logger Backup Daten mit Mount Error- Ende am `date`
fi
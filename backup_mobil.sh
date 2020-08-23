#!/bin/bash
#
#
#
#Start des Log Eintrags
/usr/bin/logger Backup Mobil - Start am `date`

#Backup Start Log in Cloud
echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
echo $(date)": Mobil Backup wird gestartet." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt


#Mounten
/bin/mount -t auto /dev/$1 /mnt/backup_mobil

if mountpoint -q /mnt/backup_mobil
then
    echo $(date)": Mounten erfolgreich" >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    echo $(date)": Mounten erfolgreich"
    #Backup
    /usr/bin/logger Backup Mobil - Nextcloud Daten
    #Daten
    /usr/bin/rsync -rtv --del --modify-window=2 /mnt/nextclouddata/clouddata /mnt/backup_mobil/clouddata
    echo $(date)": Datenbackup  erfolgreich" >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    #Installationsverzeichnis
    #/usr/bin/rsync -rtv --del --modify-window=2 /var/www/html /mnt/backup_mobil/installver 
    #echo $(date)": Install verzeichnis erfolgreich" >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt

    #
    /bin/sync

    #Datenbank speichern
    #mysqldump --single-transaction -h localhost -u nextcloud -p lukas nextcloud > /mnt/backup_mobil/db_backup_`date +"%Y%m%d"`.sql

    #Unmounten
    /bin/umount /mnt/backup_mobil
    echo $(date)": Unmounten erfolgreich" >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    echo $(date)": Unmounten erfolgreich"
    #Piepen
    beep -f130 -l100 -n -f262 -l100 -n -f330 -l100 -n -f392 -l100 -n -f523  -l100 -n -f660 -l100 -n -f784 -l300 -n -f660 -l300 -n -f146 -l100 -n -f262 -l100 -n -f311 -l1$

    #End Log
    /usr/bin/logger Backup Mobil - Ende am `date`

    #Backup End Log in Cloud
    echo $(date)": Mobil Backup wird beendet." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt

else #If first mounting attempt is unsuccessful
    #Create Log in Cloud
    echo $(date)": Mounten erfolglos! Abbruch." >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    echo ------------------------------------------------------------ >> /mnt/nextclouddata/clouddata/__groupfolders/12/Log/Backup.txt
    #End Log
    /usr/bin/logger Mobil Backup mit Mount Error Ende am `date`
fi

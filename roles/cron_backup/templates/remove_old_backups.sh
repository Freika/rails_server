find /home/deploy/var/www/{{ app_name }}/shared/backups -type f -mtime +8 -exec rm -v {} \;

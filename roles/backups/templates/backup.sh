pg_dump --no-owner {{ app_name }}_production > backups/`date +"%H:%M_%d_%m_%Y"`.sql -U {{ app_name }}

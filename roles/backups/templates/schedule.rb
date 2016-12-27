every 5.minutes do
  command "backup perform -t {{ app_name }} --config-file /home/deploy/var/www/{{ app_name }}/backups/config.rb"
end

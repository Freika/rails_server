# encoding: utf-8

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#

require 'yandex/disk/backup/storage'

Model.new(:{{ app_name }}, 'Description for {{ app_name }} backup') do
  database PostgreSQL do |db|
    db.name               = "{{ app_name }}_production"
    db.username           = "{{ app_name }}"
    db.password           = "{{ postgres_password }}"
    db.host               = "localhost"
    db.port               = 5432
    # db.socket             = "/tmp/pg.sock"
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 7
    # local.keep       = Time.now - 2592000 # Remove all backups older than 1 month.
  end

  compress_with Gzip

  store_with Yandex::Disk do |disk|
    disk.access_token = "{{ yandex_disk_access_token }}"
    disk.path         = '/backups/'
    disk.keep         = 5
  end

  # notify_by Mail do |mail|
  #   mail.on_success           = true
  #   mail.on_warning           = true
  #   mail.on_failure           = true

  #   mail.from                 = "sender@email.com"
  #   mail.to                   = "receiver@email.com"
  #   mail.cc                   = "cc@email.com"
  #   mail.bcc                  = "bcc@email.com"
  #   mail.reply_to             = "reply_to@email.com"
  #   mail.address              = "smtp.gmail.com"
  #   mail.port                 = 587
  #   mail.domain               = "your.host.name"
  #   mail.user_name            = "sender@email.com"
  #   mail.password             = "my_password"
  #   mail.authentication       = "plain"
  #   mail.encryption           = :starttls
  # end
end

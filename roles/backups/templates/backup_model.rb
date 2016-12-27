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

Model.new(:{{ app_name }}, 'Description for {{ app_name }} backup') do
  database PostgreSQL do |db|
    db.name               = "{{ app_name }}_production"
    db.username           = "{{ app_name }}"
    db.password           = "{{ postgres_password }}"
    db.host               = "localhost"
    db.port               = 5432
    # db.socket             = "/tmp/pg.sock"
  end

  compress_with Gzip

  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = "{{ aws_key }}"
    s3.secret_access_key = "{{ aws_secret_key }}"
    # Or, to use a IAM Profile:
    # s3.use_iam_profile = true

    s3.region             = '{{ aws_region }}'
    s3.bucket             = '{{ aws_bucket_name }}'
    s3.path               = 'backups'
    s3.keep               = 30
  end

  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true

    # The integration token
    slack.webhook_url = '{{ slack_webhook_url }}'

    ##
    # Optional
    #
    # The channel to which messages will be sent
    # slack.channel = 'my_channel'
    #
    # The username to display along with the notification
    # slack.username = 'my_username'
    #
    # The emoji icon to use for notifications.
    # See http://www.emoji-cheat-sheet.com for a list of icons.
    # slack.icon_emoji = ':ghost:'
    #
    # Change default notifier message.
    # See https://github.com/backup/backup/pull/698 for more information.
    # slack.message = lambda do |model, data|
    #   "[#{data[:status][:message]}] #{model.label} (#{model.trigger})"
    # end
  end
end

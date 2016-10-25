# Purpose

Automated script to setup new server and deploy Rails application along with databse dump.


## Preparation

1. Execute within your rails app directory: `git clone git@github.com:Freika/rails_server.git server`
2. Open file `server/hosts` and replace values with your own. User and database passwords should be encrypted (http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module)
3. Update `server/roles/upload_db/templates/database.yml` with your credentials
4. Update `server/roles/nginx/templates/nickshaker` with your domain and app name in path.
5. Place you postgres database dump as `server/app_name.sql`. Dump must be created with `pg_dump app_name < app_name.sql`
5. Update IP address of your server in `config/deploy/production.rb` and set user value to `deploy`.


## hosts file
Create file `hosts` in root dir of ansible script. Here is an example:

```
[rails]
IP_ADDRESS

[rails:vars]
app_name=APP_NAME
user_password=PASSWORD          # (encrypted in md5)
monit_user=MONIT_USERNAME
monit_password=MONIT_PASSWORD   # (plain text)
ruby_version=2.3.1
gmail_user=GMAIL_EMAIL_ADDRESS
gmail_password=GMAILPLAIN_TEXT_PASSWORD
monit_allowed_ip=MONIT_ALLOWED_IP
```

## Usage

1. Run `ansible-playbook server/python.yml server/server.yml -i server/hosts` to setup users and all necessary software
2. Run `cap production deploy:check` to create necessary infrastructure for capistrano 3
3. Run `ansible-playbook server/app.yml -i server/hosts` to create Nginx virtual host for your app, create database for it and upload database dump on server.
4. Run `cap production deploy`. If it failed because if not found active support 5, just run it one more time.
5. You are awesome!

## Deploying application to already configured server

Just run steps from 2 to 5 from Usage. You'll also want to update files from Preparation as appropriate.

## Todo

- Creating swap 2gb (user can set variable)
- Creating backups for postgres databases every 24 hours
- Uploading daily backups via WebDAV
- Setup Fail2ban

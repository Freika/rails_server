# What is this?

This is an automated script to help you setup new server and deploy Rails application along with database dump.

# What it does?

This script goes through full server configuration process. For now it does next things (in order of applying):

### python.yml

- Installs Python2 in order to allow Ansible do all the work
- Installs pip, python packet manager

### server.yml

- Creates `deploy` user which is our main user for application deployments
- Configures `zsh` and `oh-my-zsh` for both `root` and `deploy` users
- Installs `vim` and `htop`
- Installs `monit` for server state monitoring and notifications (RAM, HDD, etc)
- Installs `nginx` with `passenger` to serve your Rails applications
- Installs `Redis`
- Installs `Ruby`
- Installs `PostgreSQL`

### app.yml

- Configures Nginx to server your Rails application
- Creates PostgreSQL database and user for your Rails application
- Uploads database dump and restores it on server

## Requirements:
Ubuntu 16.04 or newer

## Preparation

1. Execute within your rails app directory: `git clone git@github.com:Freika/rails_server.git server`
2. Open file `server/hosts` and replace values with your own. User and database passwords should be [encrypted](http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module)
3. Update `server/roles/nginx/templates/nginx_virtual_host` with your domain.
4. Place you postgres database dump at `server/app_name.sql`. Dump must be created with following command: `pg_dump --no-owner app_name > app_name.sql`
5. Update IP address of your server in `config/deploy/production.rb` and set user value to `deploy`.
6. Install roles from ansible-galaxy:
```
ansible-galaxy install manala.git manala.zsh mashimom.oh-my-zsh pgolm.monit geerlingguy.passenger DavidWittman.redis rvm_io.rvm1-ruby ANXS.postgresql kamaln7.swapfile
```


## hosts file
Create file `hosts` in root directory of ansible script. Here is an example:

```
[rails]
IP_ADDRESS                      # Your server IP address

[rails:vars]
app_name=APP_NAME               # Your application name
user_password=PASSWORD          # Password for user deploy, encrypted in md5
monit_user=MONIT_USERNAME       # Username for monit
monit_password=MONIT_PASSWORD   # Password for monit, plain text
ruby_version=2.3.1              # Ruby version
gmail_user=user@gmail.com       # Gmail account email for monit notifications
gmail_password=GMAIL_PASSWORD   # Gmail account password for monit notifications
monit_allowed_ip=0.0.0.0        # Allowed IP for monit sign in
postgres_password=00000000      # Your app database password (for database.yml)
swap_size=2GB                   # Swapfile size
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

- Creating backups for postgres databases every 24 hours
- Uploading daily backups via WebDAV
- Setup Fail2ban

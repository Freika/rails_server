## Preparation

1. Execute within your rails app directory: `git clone git@github.com:Freika/rails_server.git server`
2. Open file `server/hosts` and replace values with your own. User and database passwords should be encrypted (http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module)
3. Update `server/roles/upload_db/templates/database.yml` with your credentials
4. Update `server/roles/nginx/templates/nickshaker` with your domain and app name in path.
3. Update IP address of your server in `config/deploy/production.rb` and set user value to `deploy`.

## Usage

1. Run `ansible-playbook server/python.yml server/rails_server.yml -i server/hosts` to setup users and all necessary software
2. Run `cap production deploy:check` to create necessary infrastructure for capistrano 3
3. Run `ansible-playbook server/db.yml -i server/hosts` to upload `database.yml` and your database dump. It will also apply your dump to your database on server
4. Run `cap production deploy`. If it failed because if not found active support 5, just run it one more time.
5. You are awesome!

## Usage

Create file hosts, example:

```
[rails]
SERVER_IP_ADDRESS
```

Run
```
ansible-playbook python.yml rails_server.yml -i hosts
```

User: `deploy`

Password: `00000000`

from app dir: `cap production deploy:check`

From `config/server` run: `ansible-playbook nginx.yml -i hosts` to upload database.yml

from app dir `pg_dump DB_NAME > DB_NAME.sql`

upload: `scp DB_NAME.sql deploy@HOST:/home/deploy/var/www/APP_NAME/current/DB_NAME.sql
DB_NAME.sql`

restore db: `psql DB_NAME < DB_NAME.sql`

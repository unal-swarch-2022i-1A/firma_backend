# Data bases

## Host setup
### Postgres
```bash
sudo apt install postgresql postgresql-contrib
sudo -u postgres psql -c "SELECT version();"
```
#### Conexión CLI
Por defecto en la instalación se crea el usuario `postgres` en el host para conexión *Peer authentication*
```bash
sudo -u postgres psql
```
Podemos conectarnos con un usuario creado con `psql -U Username DatabaseName`, pero antes debemos cambiar en `pg_hba.conf` la autenticación *Peer authentication* por *Password authentication* de los demás usuarios
```conf
local   all             all                                md5
```
```bash
psql -U firma firma_user_db
```

#### Import SQL
```bash
psql -h hostname -d databasename -U username -f file.sql
```
#### Export SQL
TODO

#### Remote connections
1. En `postgresql.conf` poner `listen_addresses = '*'` y reiniciamos el servicio
2. En `pg_hba.conf` poner
	```conf
	host    all             all              0.0.0.0/0                       md5
	host    all             all              ::/0                            md5
	```

### MySQL
```bash
sudo apt install gnupg
cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
sudo dpkg -i mysql-apt-config*
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```

#### Creación de base de datos
Nos conectamos con `sudo mysql -u root -p`
```sql
CREATE DATABASE firma_keys_db;
SHOW databases;
CREATE USER 'firma'@'localhost' IDENTIFIED BY 'firma';
CREATE USER 'firma'@'%' IDENTIFIED BY 'firma';
SELECT host, user, authentication_string FROM mysql.user;
GRANT ALL PRIVILEGES ON firma_keys_db.* TO 'firma'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SHOW GRANTS FOR firma;
```

#### Permitir conexiones remotas
Por defecto MySQL solo permite conexiones dentro del mismo host. Para permitir conexiones remotas necesitamos definir en `/etc/mysql/mysql.conf.d/mysqld.cnf` la propiedad `bind-addresss` en `0.0.0.0`. Luego se reinicia el servicio con `sudo systemctl restart mysql`

#### Exportar desde CLI
```bash
sudo mysqldump -u root -p firma_keys_db > firma_keys_db.sql
```
#### Importar desde CLI
```bash
sudo mysql -u root -p < firma_keys_db.sql
```

### MongoDB
```bash
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update
sudo systemctl start mongod
```

## Docker

### MongoDB
```bash
docker rm -f firma_mongo && \
docker run -d \
    --name firma_mongo \
    -p 27017:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
	-e MONGO_INITDB_ROOT_PASSWORD=secret \
	mongo && \
docker logs --tail 1000 -f firma_mongo    
```

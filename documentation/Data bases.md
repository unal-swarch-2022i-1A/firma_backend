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
sudo apt update
sudo apt install wget
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
#### Mostrar estructura
```SQL
SELECT host, user FROM mysql.user;
USE firma_keys_db;
SHOW TABLES;
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
#### Setup
```bash
sudo apt-get update
sudo apt-get install wget
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl status mongod
sudo systemctl enable mongod
mongosh
```
#### Conexión remota
Cambiar el parámetro `bindIP` en el archivo `mongod.conf` de `127.0.0.1` a `0.0.0.0`:
```bash
sudo nano /etc/mongod.conf
```
```
# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0
```
Reiniciamos el servicio
```bash
sudo systemctl restart mongod
```
## Verificar 
Veriricar por servicios
```bash
systemctl list-units --type=service | grep -E 'mysql|mongo|postgres'
```
Verificar por puertos
```bash
sudo netstat -tulpn | grep -E '3306|27017|5432'
```

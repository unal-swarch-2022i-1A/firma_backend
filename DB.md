# Data bases

## Host steup
### Postgres
```bash
sudo apt install postgresql postgresql-contrib
sudo -u postgres psql -c "SELECT version();"
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

### Creación de base de datos
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

#### Permitir a usuarios remotos
```bash
sudo mysql -u root -p

RENAME USER 'root'@'localhost' TO 'root'@'%';
```

### MongoDB
```bash
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update
sudo systemctl start mongod
```

## Docker

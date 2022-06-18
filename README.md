# Firma Backen

## Documentation
* [Cola de mensajes](./documentation/Message%20Queue.md)
* [Lazanmiento de aplicación dokerizada multi-contenedor](./documentation/Dockerization.md)
* [Conexión al servidor en la nube Google Cloud Project](./documentation/Google%20Cloud%20Project.md)
* [Git y submodulos](./documentation/Git.md)

## Deployment
### Conexión 
Leer primero [Conexión al servidor en la nube Google Cloud Project](./documentation/Google%20Cloud%20Project.md).

Iniciamos la VM
```bash
gcloud compute instances start "firma-backend"
```
Nos conectamos a la shell
```bash
gcloud compute ssh "firma-backend"
```
En la VM vamos a `cd /home/developer/firma_backend` y probamos los servicios en backend con 
```bash
./tests/checkports.sh
```
### Pull changes
```bash
cd /home/developer/firma_backend
git pull
git submodule update --init --recursive
```
### Base de datos
#### Importar firma_user_db:PostgreSQL
```bash
sudo -u postgres psql -f firma_user_ms/firma_user_db/firma_user_db.structure.sql
sudo -u postgres psql -d firma_user_db -f firma_user_ms/firma_user_db/firma_user_db.user.data.sql
```
#### Importar firma_keys_db:MySQL
```bash
sudo mysql -u root -p < firma_keys_ms/firma_keys_db/firma_keys_db.structure.sql
sudo mysql -u root -p < firma_keys_ms/firma_keys_db/firma_keys_db.data.sql
```
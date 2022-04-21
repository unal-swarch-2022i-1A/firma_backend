# firma_backend

## Google Cloud Compute Engine
### SSH
https://cloud.google.com/compute/docs/oslogin/set-up-oslogin

Variables a definir con la información de la cuenta 
* `VM_NAME`: Nombre de la maquina, en este caso `production`.
* `ZONE`: La zona de internet desde donde se lanza: `us-east1-b`.
* `PRINCIPAL`: Se puede obtener desde la CLI con `gcloud iam service-accounts list` o es el mismo usuario `user:micorreo@unal.edu.co`.

Habilitar [OS Login](https://cloud.google.com/compute/docs/oslogin) para administrar acceso SSH
```bash
gcloud compute instances add-metadata $VM_NAME --metadata enable-oslogin=TRUE --zone=$ZONE
```

Dar permiso de `osLogin` al 
```bash
ROLE='roles/compute.osLogin'
gcloud compute instances add-iam-policy-binding $VM_NAME --zone=$ZONE --member=$PRINCIPAL --role=$ROLE
```

```bash
KEY_FILE_PATH=~/.ssh/swarch
USER='faroseroc_unal_edu_co'
ssh-keygen -t rsa -f $KEY_FILE_PATH -C $USER -b 2048
cat $KEY_FILE_PATH 
gcloud compute os-login ssh-keys add --key-file=$KEY_FILE_PATH.pub
```

```bash
EXTERNAL_IP=35.231.164.201
ssh -i $KEY_FILE_PATH $USER@$EXTERNAL_IP
```

## Git
https://git-scm.com/book/en/v2/Git-Tools-Submodules

Agregar un repostirio como submodulo a otro repositorio
```bash
git clone https://MASTER_PROJECT
cd MASTER_PROJECT
git submodule add https://SUB_PROJECT 
```

Inicializar un repositorio con submodulos
```bash
git clone --recurse-submodules https://MASTER_PROJEC
```

## Data bases
```
sudo apt install postgresql postgresql-contrib
sudo -u postgres psql -c "SELECT version();"
sudo apt install gnupg
cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
sudo dpkg -i mysql-apt-config*
sudo apt update
sudo apt install mysql-server
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update
sudo systemctl start mongod
```


## Docker
https://docs.docker.com/engine/install/debian/
https://docs.docker.com/compose/install/
### Post-install para no-root
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

``` 
### Enlazar una shell a contenedor
```bash
docker ps
docker exec -it NOMBRE_CONTENEDOR /bin/bash

```
### Docker Compose

## Github Page Jekyll/Ruby
Para la página de documantación pública https://unal-swarch-2022i-1a.github.io/

```bash
cd $HOME
sudo apt-get update 
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 3.1.2
rbenv global 3.1.2
ruby -v
``` 

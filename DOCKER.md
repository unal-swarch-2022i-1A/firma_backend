# Docker
Paso a paso para dockerización:

## 0. Requerimientos

**Hyper-V:** https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v

**WSL-2:** https://docs.microsoft.com/en-us/windows/wsl/install

## 1. Instalación

**Docker Engine:** https://docs.docker.com/engine/install/debian/
```bash
docker -v
```
**Docker Compose:** https://docs.docker.com/compose/install/
```bash
docker-compose -v
```

## 2. Post-install para no-root (Linux)

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
``` 

## 3, RUN: Correr la imagen Hola mundo o MySQL
Toda *imagen* que esta en ejecución es *contenedor*.
Basicamente el comando `docker run` nos permite lanzar una imagen de algun repositorio o una imagen que hayamos compilado.
https://docs.docker.com/engine/reference/run/

Listar las imagenes que tenemnos en local (ya sean compiladas o descargadas):
```bash
docker image ls
```

Correr y descargar imagen `Hello world` la cual es una imagen de prueba. No es necesario hacer el `docker pull`, `docker run` automáticamente la descarga, sin embargo acá lo utilizamos con fines pedagógicos:
```bash
docker pull hello-world
docker run hello-world
```

Correr MySQL con variables de entorno con la opción `-e`. Le aisgnamos un nombre al contendedor con `--name` para poder encontrarlo con `docker ps`. La opción `-d` permite correr el contenedor en suegundo plano. Mapeamos el puerto interno del contenedor a un puerto del anfitrión con `-p [local]:[container]`
```bash
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3360:3360 -d mysql
```

Si queremos enlazar un directorio del host a un directorio del contenedor usamos la opción `-v`. Nota solo se pueden utilizar rutas absolutas:
```bash
docker run \
  --name some-mysql  \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -v source=$(pwd),target=/app \
  mysql
```
El parámetro target debe ser ruta absoluta
https://docs.docker.com/storage/volumes/

## 4. BUILD: Compilar una imagen
**Dockerfile**: Indica al compilador de docker como personalizar una imagen
https://docs.docker.com/engine/reference/builder/

```bash
docker build -t [etiqueta_de_imagen] .
```

Antes de correr **eliminar** el contenedor si existe
```bash
docker rm -f [nombre_contenedor] 
```

Y luego si hacer 
```
docker run -it --name [nombre_contenedor] --mount source=src,target=/usr/src/app/src [etiqueta_de_imagen]
```



## 5.  Componer una imagen
https://docs.docker.com/compose/

## Lanzamiento

```bash
git submodule update --init
docker-compose --project-name "firma" build
docker-compose --project-name "firma" up --detach
```

## Enlazar una shell a contenedor

```bash
docker ps
docker exec -it NOMBRE_CONTENEDOR /bin/bash

```

## Eliminar contenedores
```bash
docker rm -f firma_signing_ms firma_user_ms firma_storage_ms firma_keys_ms...
```
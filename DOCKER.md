# Docker
Toda *imagen* que esta en ejecución es *contenedor*.
Paso a paso para dockerización:

## Instalación de docker 
### 0. Requerimientos

**Hyper-V:** https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v

**WSL-2:** https://docs.microsoft.com/en-us/windows/wsl/install

### 1. Instalación

**Docker Engine:** https://docs.docker.com/engine/install/debian/
```bash
docker -v
```
**Docker Compose:** https://docs.docker.com/compose/install/
```bash
docker-compose -v
```

### 2. Post-install para no-root (Linux)

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
``` 
## Docker BUILD
El archivo por defecto llamado `Dockerfile` indica al compilador de docker engine como personalizar una imagen
https://docs.docker.com/engine/reference/builder/

```bash
docker build -t [etiqueta_de_imagen] .
```

Antes de correr una imagen se debe **eliminar** el contenedor si existe
```bash
docker rm -f [nombre_contenedor] 
```

## Docker RUN
Basicamente el comando `docker run` nos permite lanzar una imagen de algun repositorio o una imagen que hayamos compilado.
https://docs.docker.com/engine/reference/run/

Listar las imagenes que tenemnos en local (ya sean compiladas o descargadas):
```bash
docker image ls
```

Para correr una imagen como contenedor simplement corremos
```bash
docker run [etiqueta_imagen]
```

### Enlazar una shell a contenedor
```bash
docker ps
docker exec -it NOMBRE_O_ID_CONTENEDOR /bin/bash
```
de esta manera podemos instalar utilidades como `ping` o `ip`
```bash
apt update
apt install iputils-ping -y
apt install iproute2 -y
```

### Opciones
* `--name` asigna un nombre al contenedor.
* `-e` define una variable de entorno.
* `-d` corre el contenedor en sugundo plano. 
* `-t` corre el contenedor en primer plano: Asigna una terminal.
* `-i` corre el contenedor en primer plano: Mantiene STDIN abierta.
* `-p [host]:[contenedor]` mapea un puerto del contenedor al host.
* `--network="host"` expone la red host (puertos de servicios) dentro del contenedor.
* `-v [host]:[contenedor]`enlaza un directorio del host al contenedor. Las rutas deben ser absolutas.

### Eliminar contenedores
```bash
docker rm -f [NOMBRE_O_ID_CONTENEDOR] [...NOMBRE_O_ID_CONTENEDOR]
```

### Listar puertos
Para listar los puertos en escucha en un contendor:
```bash
sudo nsenter -t $(docker inspect -f '{{.State.Pid}}' NOMBRE_O_ID_CONTENEDOR) -n netstat -tulpn
``` 

### Ejemplo `Hello world` 
Correr y descargar imagen `Hello world` la cual es una imagen de prueba. No es necesario hacer el `docker pull`, `docker run` automáticamente la descarga, sin embargo acá lo utilizamos con fines pedagógicos:
```bash
docker pull hello-world
docker run hello-world
```
### Ejemplo `MySQL server`
Correr MySQL con variables de entorno con la opción `-e`. Le aisgnamos un nombre al contendedor con `--name` para poder encontrarlo con `docker ps`. La opción `-d` permite correr el contenedor en suegundo plano. Mapeamos el puerto interno del contenedor a un puerto del anfitrión con `-p [local]:[container]`

```bash
docker run -d --name my-mysql-app -e MYSQL_ROOT_PASSWORD=123 -p 3360:3360 mysql
```

### Ejmplo `Apache server`
Si queremos enlazar un directorio del host a un directorio del contenedor usamos la opción `-v`. Nota solo se pueden utilizar rutas absolutas. Con `--network="host"` hacemos accesibles los puertos del host desde el contenedor

```bash
docker run -dit --name my-apache-app -v "$PWD":/usr/local/apache2/htdocs/ -p 80:80 httpd
sudo nsenter -t $(docker inspect -f '{{.State.Pid}}' my-apache-app) -n netstat -tulpn
docker rm -f my-apache-app
docker run -dit --name my-apache-app -v "$PWD":/usr/local/apache2/htdocs/ --network="host" httpd
sudo nsenter -t $(docker inspect -f '{{.State.Pid}}' my-apache-app) -n netstat -tulpn
```

### Ejmplo `PHhpMyAdmin + MySQL en host`
Con antelación tenemos un servidor MySQL corriendo en el host en `0.0.0.0:3306` y un usuario MySQL `firma@%` con contraseña `firma`. 
```bash
telnet localhost 3306
```

Para correr el contenedor
```bash
docker run -dit --name phpmyadmin \
    -e PMA_HOST=host.docker.internal \
    --add-host=host.docker.internal:host-gateway \
    -p 8080:80 \
    phpmyadmin
docker exec -it phpmyadmin /bin/bash
```

Comprobamos conexión con los siguientes comandos o en http://localhost:8080
```bash
apt update && apt install iputils-ping iproute2 telnet -y
ip a
ping host.docker.internal -c 4
telnet host.docker.internal 3306
```


### Logs
```bash
docker logs --tail 1000 -f [nombre del contenedor]
```

## Docker-compose
*TODO* 
https://docs.docker.com/compose/

Mapear un hostname a la ip del host
```yaml
extra_hosts:
- "host.docker.internal:host-gateway"
```

### Lanzamiento
```bash
docker-compose --project-name "firma" down
docker-compose --project-name "firma" build
docker-compose --project-name "firma" up --detach
docker-compose --project-name "firma" logs -f --tail 1000 
```



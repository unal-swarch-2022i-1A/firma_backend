# Docker
https://docs.docker.com/engine/install/debian/
https://docs.docker.com/compose/install/
## Post-install para no-root
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

``` 
## Lanzamiento
```bash
docker-compose --project-name "firma" up --detach
docker exec -it firma_signing_ms /bin/bash
```

## Enlazar una shell a contenedor
```bash
docker ps
docker exec -it NOMBRE_CONTENEDOR /bin/bash

```

## Eliminar contenedores
```bash
docker rm -f firma_signing_ms firma_user_ms ...
```
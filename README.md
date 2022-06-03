# Firma Backend

* [Cola de mensajes](MQ.md)
* [Lazanmiento de aplicación dokerizada multi-contenedor](DOCKER.md)
* [Conexión al servidor en la nube Google Cloud Project](GCP.md)

##  Submodulos Git
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

Actualizar un submodulo vacio
```bash
git submodule update --init
```

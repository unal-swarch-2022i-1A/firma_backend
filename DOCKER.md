# Docker
## Lanzamiento
```bash
docker-compose --project-name "firma" up --detach
docker exec -it firma_signing_ms /bin/bash
docker rm -f firma_signing_ms firma_user_ms ...
```
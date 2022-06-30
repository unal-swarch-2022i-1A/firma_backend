# Ports check
```bash
./tests/checkports.sh 
```
## Local images

```bash
docker-compose --file "docker-compose.local.yml" --project-name "firma_test" down && \
docker-compose --file "docker-compose.local.yml" --project-name "firma_test" up --detach && \
docker-compose --file "docker-compose.local.yml" --project-name "firma_test" logs -f --tail 1000 
```

## Github Packages

```bash
docker-compose --file "docker-compose.ghcr.yml" --project-name "firma_ghcr" down
docker-compose --file "docker-compose.ghcr.yml" --project-name "firma_ghcr" up --detach && \
docker-compose --file "docker-compose.ghcr.yml" --project-name "firma_ghcr" logs -f --tail 1000 
```

## Lab7 - Performance
```bash
docker-compose --file "docker-compose.lab7.yml" --project-name "1A_lab7" down
docker-compose --file "docker-compose.lab7.yml" --project-name "1A_lab7" build
docker-compose --file "docker-compose.lab7.yml" --project-name "1A_lab7" up --detach
docker-compose --file "docker-compose.lab7.yml" --project-name "1A_lab7" logs -f --tail 1000 
```

```bash
docker-compose --file 'docker-compose.lab7.yml'  --project-name  '1a_lab7' stop
docker-compose --file 'docker-compose.lab7.yml'  --project-name  '1a_lab7' start
```

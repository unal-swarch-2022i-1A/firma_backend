# Ports check
```bash
./tests/checkports.sh 
```

## Lab7 - Performance
```bash
docker-compose --file "docker-compose.lab7.yml" --project-name "firma_lab7" down
docker-compose --file "docker-compose.lab7.yml" --project-name "firma_lab7" build
docker-compose --file "docker-compose.lab7.yml" --project-name "firma_lab7" up --detach
docker-compose --file "docker-compose.lab7.yml" --project-name "firma_lab7" logs -f --tail 1000 
```
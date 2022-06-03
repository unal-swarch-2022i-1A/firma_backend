#!/bin/bash
docker-compose -p "firma" down
docker-compose -p "firma" build
docker-compose -p "firma" up --detach
docker-compose -p "firma" logs -f --tail 1000 
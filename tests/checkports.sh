#!/bin/bash
# Colores
RED='\033[0;31m'
GREEN='\033[0;32m' 
BLUE='\033[0;34m' 

NC='\033[0m' # No Color
# Verificar puertos
checkport () {
    str="${2} ${BLUE}${3}${NC}... "
    if echo $1 | grep -q $3; then
        str="${str} ${GREEN}funciona${NC}.\n"
    else
        str="${str} ${RED}no funciona${NC}.\n"
    fi
    #printf "$str"
}
# Consutla de puertos
netstat=$(sudo netstat -tulpn | awk '{print $4}' | grep -oP '(?<=:)[0-9]*$')

declare -A services
services['MySQL DB']='3306'
services['Postgres DB']='5432'
services['Mongo DB']='5432'
services['Users MS']='8090'
services['Docs MS']='8091'
services['Signing MS']='8092'
services['Verification MS']='8093'
services['API Gateway']='8093'
services['Message Qeue']='5672'
services['Message Qeue UI']='15672'
services['Web application HTTP']='80'
services['Web application HTTPS']='443'

declare -a response
for service in "${!services[@]}"
do
    checkport "$netstat" "${service}" "${services[$service]}"
    response+=("${str}")
    #response=(${response[@]} )     
done
# Ordenar alfabeticamente
readarray -t sorted < <(printf '%s\0' "${response[@]}" | sort -z | xargs -0n1)
# Mostrar resultado
for r in "${sorted[@]}"; do printf "$r"; done
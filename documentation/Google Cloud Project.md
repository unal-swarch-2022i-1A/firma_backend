# Google Cloud Project (GPC)
## Google Cloud CLI
Definimos la zona por defecto
```bash
gcloud config set compute/zone 'us-east1-b'
```

Definimos el proyecto
```bash
gcloud config set project 'unal-swarch-2022i-1a'
```

Para ver la información de una máquina
```bash
gcloud compute instances describe "firma-backend"
```
## Conexión remota
### Por medio de Gogle Cloud CLI
```bash
gcloud compute ssh "firma-backend"
```
o
```bash
gcloud compute ssh --zone "us-east1-b" "firma-backend"  --project "unal-swarch-2022i-1a"
```
### Por medio de SSH
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
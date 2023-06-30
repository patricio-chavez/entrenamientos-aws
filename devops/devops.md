# Prácticas en AWS Devops

## Instala las herramientas requeridas para el entrenamiento según tu Sistema Operativo
- AWS CLI (Command Line Interface): La AWS CLI es una herramienta de línea de comandos que permite interactuar con los servicios de AWS desde la línea de comandos. Puedes instalarla siguiendo las instrucciones oficiales de [AWS](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

- Git: Git es un sistema de control de versiones distribuido ampliamente utilizado. Te permite gestionar el control de versiones de tu código y colaborar de manera efectiva con otros desarrolladores. Puedes descargar Git desde el sitio web oficial de [Git](https://git-scm.com/downloads).

- kubectl: kubectl es una herramienta de línea de comandos utilizada para interactuar con clústeres de Kubernetes. Te permite desplegar y gestionar aplicaciones en clústeres de Kubernetes. Puedes instalar kubectl siguiendo la documentación oficial de [Kubernetes](https://kubernetes.io/docs/tasks/tools/).

- eksctl: eksctl es una herramienta de línea de comandos para crear, gestionar y operar clústeres de Amazon Elastic Kubernetes Service (EKS). Simplifica el proceso de creación y administración de clústeres EKS. Puedes instalar eksctl siguiendo las instrucciones en la documentación oficial de [eksctl](https://eksctl.io/).

- Helm: Un gestor de paquetes para Kubernetes que facilita la implementación y gestión de aplicaciones en clústeres de Kubernetes. Puedes instalar helm desde el sitio oficial de [HELM](https://helm.sh/docs/intro/install/).

- Docker/Podman: Docker es una plataforma para desarrollar, enviar y ejecutar aplicaciones en contenedores y Podman es compatible con los estándares OCI, lo que significa que puedes trabajar con imágenes y contenedores en formato OCI. Esto permite una interoperabilidad fluida con otras herramientas y plataformas que también siguen estos estándares. Para instalar cada una de estas herramientas te puede dirigiar a [Docker](https://docs.docker.com/get-docker/) y/o [Podman](https://podman.io/docs/installation).


## Configura las credenciales para interactuar con AWS ejecutando
```shell
aws configure
```

## Instancia un cluster AWS Elastic Kubernetes Service (EKS)
```shell
eksctl create cluster --name cluster-eks --region us-east-1 --zones us-east-1a,us-east-1b,us-east-1c --node-type t2.micro
```

## Crea un repositorio en AWS Code Commit para alojar el código de nuestra aplicación cloud native
```shell
cat << EOF > crear_repo.sh
#!/bin/bash

NOMBRE_REPO="mi-repositorio"
aws codecommit create-repository --repository-name $NOMBRE_REPO
EOF
```

### Modificamos los permisos y lo ejecutamos
```shell
chmod +x crear_repo.sh && ./crear_repo.sh
```

### Para interactuar con el repositorio sin necesidad de ingresar contraseñas puedes utilizar una clave SSH
#### Crea una nueva clave dejando los valores por defecto
```shell
ssh-keygen -t rsa -b 4096 -f ~/.ssh/codecommit_rsa
```

#### Sube la clave a AWS IAM teniendo en cuenta el usuario con el que ingresas a AWS, para este ejemplo, cloud_user
```shell
aws iam upload-ssh-public-key --user-name cloud_user --ssh-public-key-body file://~/.ssh/codecommit_rsa.pub
```

#### Exporta el ID de la clave pública de SSH ya que lo necesitaras para finalizar la configuración de acceso
```shell
export SSHKEYID=$(aws iam list-ssh-public-keys --user-name cloud_user | grep -oP '(?<="SSHPublicKeyId": ")[^"]+' | awk 'NR==1')
echo $SSHKEYID
```

#### Agrega las siguientes líneas en el fichero config de SSH. Por defecto se encuentra en home/.ssh
```shell
cat << EOF >> ~/.ssh/config
Host git-codecommit.*.amazonaws.com
  User $SSHKEYID
  IdentityFile ~/.ssh/codecommit_rsa
EOF
```

#### (OPCIONAL) En caso de no existir previamente se puede crear y luego agregar las líneas descriptas
```shell
touch ~/.ssh/config
```
## Clona el repositorio para comenzar comenzar a agregar el código de nuestra aplicación
```shell
git clone ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/mi-repositorio
```

## Muévete al directorio descargado
```shell
cd mi-repositorio
```

## Siempre es buena idea comenzar con descripción creando un README
```shell
cat << EOF > README.md
Código de mi increíble aplicación que correrá en Kubernetes!"
EOF
```

## Sube el fichero a AWS Code Commit
```shell
git add README.md
git commit -m "README agregado"
git status
git push origin main

```
## Ya puedes interactuar con AWS Code Commit. Felicitaciones!

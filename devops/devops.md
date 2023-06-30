# Prácticas en AWS Devops

## Instala las herramientas requeridas para el entrenamiento según tu Sistema Operativo
- AWS CLI (Command Line Interface): La AWS CLI es una herramienta de línea de comandos que permite interactuar con los servicios de AWS desde la línea de comandos. Puedes instalarla siguiendo las instrucciones oficiales de AWS.

- Git: Git es un sistema de control de versiones distribuido ampliamente utilizado. Te permite gestionar el control de versiones de tu código y colaborar de manera efectiva con otros desarrolladores. Puedes instalar Git desde el sitio web oficial de Git.

- kubectl: kubectl es una herramienta de línea de comandos utilizada para interactuar con clústeres de Kubernetes. Te permite desplegar y gestionar aplicaciones en clústeres de Kubernetes. Puedes instalar kubectl siguiendo la documentación oficial de Kubernetes.

- eksctl: eksctl es una herramienta de línea de comandos para crear, gestionar y operar clústeres de Amazon Elastic Kubernetes Service (EKS). Simplifica el proceso de creación y administración de clústeres EKS. Puedes instalar eksctl siguiendo las instrucciones en la documentación oficial de eksctl.

- Helm: Un gestor de paquetes para Kubernetes que facilita la implementación y gestión de aplicaciones en clústeres de Kubernetes.

- Docker/Podman: Docker es una plataforma para desarrollar, enviar y ejecutar aplicaciones en contenedores y Podman es compatible con los estándares OCI, lo que significa que puedes trabajar con imágenes y contenedores en formato OCI. Esto permite una interoperabilidad fluida con otras herramientas y plataformas que también siguen estos estándares.

## Configura las credenciales programáticas ejecutando
```shell
aws configure
```

## Instancia un cluster EKS Elastic Kubernetes Service
```shell
eksctl create cluster --name cluster-eks --region us-east-1 --zones us-east-1a,us-east-1b,us-east-1c --node-type t2.micro
```

## Creamos un repositorio para alojar el código que correrá sobre el cluster de Kubernetes
### Esta vez lo crearemos mediante un script
```shell
cat << EOF > crear_repo.sh
#!/bin/bash

repo_name="mi-repositorio"
aws codecommit create-repository --repository-name $repo_name
EOF
```

### Modificamos los permisos y lo ejecutamos
```shell
chmod +x crear_repo.sh && ./crear_repo.sh
```


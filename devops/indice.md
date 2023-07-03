# Prácticas Devops en Amazon Web Services (AWS)

## Herramientas requeridas
- Accede a una AWS Sandbox de [A Cloud Guru](https://learn.acloud.guru/cloud-playground/cloud-sandboxes).
- Loguéate y abre una terminal CloudShell.
- Configura el acceso programático tomando las credenciales de la bienvenida a AWS Sandbox y la región de la Cloud Console (Ej: us-east-1).
```shell
aws configure
```

- eksctl: eksctl es una herramienta de línea de comandos para crear, gestionar y operar clústeres de Amazon Elastic Kubernetes Service (EKS). Simplifica el proceso de creación y administración de clústeres EKS. Puedes instalar eksctl siguiendo las instrucciones en la documentación oficial de [eksctl](https://eksctl.io/).

- Helm: Un gestor de paquetes para Kubernetes que facilita la implementación y gestión de aplicaciones en clústeres de Kubernetes. Puedes instalar helm desde el sitio oficial de [HELM](https://helm.sh/docs/intro/install/).

- Docker/Podman: Docker es una plataforma para desarrollar, enviar y ejecutar aplicaciones en contenedores y Podman es compatible con los estándares OCI, lo que significa que puedes trabajar con imágenes y contenedores en formato OCI. Esto permite una interoperabilidad fluida con otras herramientas y plataformas que también siguen estos estándares. Para instalar cada una de estas herramientas te puede dirigiar a [Docker](https://docs.docker.com/get-docker/) y/o [Podman](https://podman.io/docs/installation).

## [AWS Code Commit](codecommit.md)
### [Prepara tu sistema operativo](codecommit.md#Prepara-tu-Sistema-Operativo)
### [Crea tu primer repositorio](codecommit.md#Crea-tu-primer-repositorio)
### [Sube código](codecommit.md#Sube-código)

## [AWS EKS](eks.md)
### [Despliega un cluster](eks.md#Despliega-un-cluster-EKS)
### [Configura el acceso programático](eks.md#Configura-el-kubeconfig)
### Depliega una aplicación
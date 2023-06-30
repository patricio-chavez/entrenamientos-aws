# Prácticas Devops en Amazon Web Services (AWS)

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

## [AWS Code Commit](codecommit.md)
### Prepara tu sistema operativo
### Crea tu primer repositorio
### Sube código

## [AWS EKS](eks.md)
### Despliega un cluster
### Configura el acceso programático
### Depliega una aplicación
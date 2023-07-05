#!/bin/bash


# Actualiza los paquetes sin solicitar confirmación
sudo yum update -y

# Instala openssl
sudo yum install openssl -y

# Instala curl
sudo yum install curl -y

# Instala jq
sudo yum install openssl -y

# Descarga y configura eksctl
echo "Descargando eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Mueve eksctl al directorio /usr/local/bin
echo "Instalando eksctl..."
sudo mv /tmp/eksctl /usr/local/bin

# Verifica la versión de eksctl instalada
echo "Versión de eksctl instalada:"
eksctl version

# Descarga helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

# Modifica los permisos del fichero
chmod 700 get_helm.sh

# Realiza la verificación de seguridad con openssl e instala HELM
./get_helm.sh

# Verifica la versión de helm instalada
helm version

# Configura usuario de git
echo "Configurando git..."
git config --global user.email "$(whoami)@entrenamientos-aws.com"
git config --global user.name "$(whoami)"

# Inicia el entrenamiento desde el HOME
cd $HOME
echo "¡Ya está todo preparado para que empieces a entrenar!"
#!/bin/bash

# Verifica si curl y jq están instalados
if ! command -v curl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  echo "Instalando curl y jq..."
  sudo apt-get update
  sudo apt-get install curl jq -y
fi

# Descarga y configura eksctl
echo "Descargando eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Mueve eksctl al directorio /usr/local/bin
echo "Instalando eksctl..."
sudo mv /tmp/eksctl /usr/local/bin

# Verifica la versión de eksctl instalada
echo "Versión de eksctl instalada:"
eksctl version

# Inicia el entrenamiento desde el HOME
cd $HOME
echo "Ya está todo preparado para que empieces a entrenar!"
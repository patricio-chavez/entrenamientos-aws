#!/bin/bash

# Eliminar repositorio en CodeCommit
echo "Eliminando repositorio en CodeCommit..."
NOMBRE_REPO="mi-repositorio"
aws codecommit delete-repository --repository-name $NOMBRE_REPO

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Repositorio eliminado exitosamente de CodeCommit."
else
  echo "Error al eliminar el repositorio de CodeCommit."
fi

# Eliminar configuración del archivo ~/.ssh/config
echo "Eliminando configuración del archivo ~/.ssh/config..."
sed -i '/Host git-codecommit.*.amazonaws.com/,/IdentityFile/d' ~/.ssh/config

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Configuración eliminada correctamente del archivo ~/.ssh/config."
else
  echo "Error al eliminar la configuración del archivo ~/.ssh/config."
fi

# Eliminar clave pública de AWS IAM
echo "Eliminando clave pública de AWS IAM..."
export SSHKEYID=$(aws iam list-ssh-public-keys --user-name cloud_user | grep -oP '(?<="SSHPublicKeyId": ")[^"]+' | awk 'NR==1')
aws iam delete-ssh-public-key --user-name cloud_user --ssh-public-key-id $SSHKEYID

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Clave pública eliminada exitosamente de AWS IAM."
else
  echo "Error al eliminar la clave pública de AWS IAM."
fi

# Eliminar clave SSH y clave pública local
echo "Eliminando clave SSH y clave pública local..."
rm -f ~/.ssh/codecommit_rsa ~/.ssh/codecommit_rsa.pub

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Clave SSH y clave pública local eliminadas correctamente."
else
  echo "Error al eliminar la clave SSH y clave pública local."
fi

echo "Proceso de eliminación de configuración para CodeCommit completado."

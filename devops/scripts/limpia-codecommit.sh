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

# Eliminar clave pública de AWS IAM
echo "Eliminando clave pública de AWS IAM..."
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

echo "Proceso de eliminación de configuración para CodeCommit completado."

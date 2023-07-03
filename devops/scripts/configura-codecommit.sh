#!/bin/bash

# Generar clave SSH
echo "Generando clave SSH..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/codecommit_rsa

# Verificar si la generación fue exitosa
if [ $? -eq 0 ]; then
  echo "Generación de clave SSH exitosa."
else
  echo "Error al generar la clave SSH."
  exit 1
fi

# Subir la clave pública a AWS IAM
echo "Subiendo la clave pública a AWS IAM..."
aws iam upload-ssh-public-key --user-name cloud_user --ssh-public-key-body "file://~/.ssh/codecommit_rsa.pub"

# Verificar si la carga fue exitosa
if [ $? -eq 0 ]; then
  echo "Carga de clave pública exitosa en AWS IAM."
else
  echo "Error al cargar la clave pública en AWS IAM."
  exit 1
fi

# Obtener el SSHKeyId
echo "Obteniendo el SSHKeyId..."
export SSHKEYID=$(aws iam list-ssh-public-keys --user-name cloud_user | grep -oP '(?<="SSHPublicKeyId": ")[^"]+' | awk 'NR==1')

# Mostrar el valor de SSHKEYID
echo "SSHKEYID: $SSHKEYID"

# Agregar la configuración al archivo ~/.ssh/config
echo "Agregando configuración al archivo ~/.ssh/config..."
cat << EOF >> ~/.ssh/config
Host git-codecommit.*.amazonaws.com
  User $SSHKEYID
  IdentityFile ~/.ssh/codecommit_rsa
EOF

echo "Configuración agregada correctamente al archivo ~/.ssh/config."

# Crear un repositorio en CodeCommit
echo "Creando repositorio en CodeCommit..."
NOMBRE_REPO="mi-repositorio"
aws codecommit create-repository --repository-name $NOMBRE_REPO

# Verificar si la creación fue exitosa
if [ $? -eq 0 ]; then
  echo "Repositorio creado exitosamente en CodeCommit."
else
  echo "Error al crear el repositorio en CodeCommit."
  exit 1
fi
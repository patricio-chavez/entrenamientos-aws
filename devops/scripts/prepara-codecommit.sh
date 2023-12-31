#!/bin/bash

# Generar clave SSH
echo "Generando clave SSH..."
ssh-keygen -q -t rsa -b 4096 -f ~/.ssh/codecommit_rsa -N ""

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

# Agregar la configuración al fichero ~/.ssh/config
echo "Agregando configuración al fichero ~/.ssh/config..."
cat << EOF >> ~/.ssh/config
Host git-codecommit.*.amazonaws.com
User $SSHKEYID
IdentityFile ~/.ssh/codecommit_rsa
EOF

chmod 600 ~/.ssh/config

echo "Configuración agregada correctamente al fichero ~/.ssh/config."

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

# Clonar el repositorio
echo "Clonando el repositorio..."
rm -Rf $HOME/mi-repositorio
cd $HOME && sleep 10
yes | git clone ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/$NOMBRE_REPO

# Verificar si el clonado fue exitoso
if [ $? -eq 0 ]; then
  echo "Clonado del repositorio exitoso."
else
  echo "Error al clonar el repositorio."
  exit 1
fi

# Cambiar al directorio del repositorio
echo "Cambiando al directorio del repositorio..."
cd $NOMBRE_REPO

# Crear fichero README.md
echo "Creando fichero README.md..."
cat << EOF > README.md
Código de mi increíble aplicación que correrá en Kubernetes!"
EOF

echo "Fichero README.md creado correctamente."

# Añadir rama main
git checkout -b main

# Añadir README.md al repositorio
echo "Añadiendo README.md al repositorio..."
git add README.md
git status

# Realizar el commit
echo "Realizando commit..."
git commit -m "README agregado"

# Realizar el push al repositorio remoto
echo "Realizando el push al repositorio remoto..."
git push origin main

cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de configuración para CodeCommit completado."

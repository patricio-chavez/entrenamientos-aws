#!/bin/bash

# Comando para crear un usuario en IAM
export NOMBRE_USUARIO="cloud_automation"
echo "Creando usuario en IAM: $NOMBRE_USUARIO"
aws iam create-user --user-name $NOMBRE_USUARIO

# Verificar si la creación fue exitosa
if [ $? -eq 0 ]; then
  echo "Usuario creado exitosamente en IAM."
else
  echo "Error al crear el usuario en IAM."
  exit 1
fi

# Comando para crear las llaves de acceso programático
SALIDA=$(aws iam create-access-key --user-name cloud_automation --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output text)
read -r ACCESS_KEY_ID SECRET_ACCESS_KEY <<< "$SALIDA"

# Imprimo los valores solamente para verificar, en Producción no es recomendable mostrar las claves
export ACCESS_KEY_ID=$ACCESS_KEY_ID
export SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY

echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"

cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de AWS IAM completado."
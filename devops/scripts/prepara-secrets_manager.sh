#!/bin/bash

# Guardar las credenciales en un secreto
NUMERO_ALEATORIO=$(shuf -i 10000000-99999999 -n 1)
NOMBRE_SECRETO=credenciales-automation-$NUMERO_ALEATORIO
aws secretsmanager create-secret --name $NOMBRE_SECRETO --secret-string '{"ACCESS_KEY_ID": "'"$ACCESS_KEY_ID"'", "SECRET_ACCESS_KEY": "'"$SECRET_ACCESS_KEY"'"}'

# Obtener el Access Key ID y Secret Access Key
echo "Obteniendo las credenciales de acceso..."
CREDENCIALES=$(aws iam create-access-key --user-name $NOMBRE_USUARIO)

# Validar si se obtuvieron las credenciales
if [ $? -eq 0 ]; then
  echo "Credenciales de acceso obtenidas exitosamente."
else
  echo "Error al obtener las credenciales de acceso."
  exit 1
fi

# Extraer el Access Key ID y Secret Access Key de la salida JSON
ACCESS_KEY_ID=$(echo $CREDENCIALES | jq -r '.AccessKey.AccessKeyId')
SECRET_ACCESS_KEY=$(echo $CREDENCIALES | jq -r '.AccessKey.SecretAccessKey')

# Validar si se obtuvieron los valores de Access Key ID y Secret Access Key
if [ -z "$ACCESS_KEY_ID" ] || [ -z "$SECRET_ACCESS_KEY" ]; then
  echo "Error al extraer las credenciales de acceso."
  exit 1
fi

# Mostrar los valores de Access Key ID y Secret Access Key
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"

echo "Proceso de preparación de AWS Secrets Manager completado."

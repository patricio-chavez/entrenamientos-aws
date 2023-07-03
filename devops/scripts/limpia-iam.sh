#!/bin/bash

# Verificar si el usuario ya existe
NOMBRE_USUARIO="cloud_automation"

aws iam get-user --user-name $NOMBRE_USUARIO >/dev/null 2>&1
if [ $? -eq 0 ]; then
  echo "El usuario $NOMBRE_USUARIO ya existe en IAM."
else
  echo "El usuario $NOMBRE_USUARIO no existe en IAM. No se realizará ninguna acción."
  exit 1
fi

# Obtener las Access Key del usuario
echo "Obteniendo todas las Access Key del usuario..."
ACCESS_KEYS=$(aws iam list-access-keys --user-name $NOMBRE_USUARIO --query "AccessKeyMetadata[].AccessKeyId" --output text)

# Verificar si existen Access Key para el usuario
if [[ -z "$ACCESS_KEYS" ]]; then
  echo "No se encontraron Access Key para el usuario $NOMBRE_USUARIO en IAM. No se realizará ninguna acción."
  exit 1
fi

# Eliminar las Access Key del usuario
echo "Eliminando las Access Key del usuario $NOMBRE_USUARIO en IAM..."
for ACCESS_KEY in $ACCESS_KEYS; do
  aws iam delete-access-key --user-name $NOMBRE_USUARIO --access-key-id $ACCESS_KEY
done

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Access Key del usuario $NOMBRE_USUARIO eliminadas exitosamente en IAM."
else
  echo "Error al eliminar las Access Key del usuario $NOMBRE_USUARIO en IAM."
  exit 1
fi

# Eliminar el usuario de IAM
echo "Eliminando el usuario $NOMBRE_USUARIO de IAM..."
aws iam delete-user --user-name $NOMBRE_USUARIO

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Usuario $NOMBRE_USUARIO eliminado exitosamente de IAM."
else
  echo "Error al eliminar el usuario $NOMBRE_USUARIO de IAM."
  exit 1
fi

echo "Proceso de limpieza de IAM completado."
#!/bin/bash

# Obtener los ARN de los secretos
SECRET_ARNS=$(aws secretsmanager list-secrets --query "SecretList[?starts_with(Name, 'credenciales-automation-')].ARN" --output text)

# Verificar si existen secretos para eliminar
if [[ -z "$SECRET_ARNS" ]]; then
  echo "No se encontraron secretos para eliminar con el prefijo 'credenciales-automation-'. No se realizará ninguna acción."
  exit 1
fi

# Eliminar los secretos
echo "Eliminando los secretos con el prefijo 'credenciales-automation-'..."
for SECRET_ARN in $SECRET_ARNS; do
  aws secretsmanager delete-secret --secret-id $SECRET_ARN
done

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Secretos con el prefijo 'credenciales-automation-' eliminados exitosamente."
else
  echo "Error al eliminar los secretos con el prefijo 'credenciales-automation-'."
  exit 1
fi

echo "Proceso de eliminación de secretos de Secrets Manager completado."

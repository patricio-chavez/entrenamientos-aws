#!/bin/bash

# Eliminar repositorio en CodeCommit
echo "Eliminando todos los secretos que comiencen con credenciales-automation..."
aws secretsmanager list-secrets --query "SecretList[?starts_with(Name, 'credenciales-automation')].ARN" --output text | xargs -I {} aws secretsmanager delete-secret --secret-id {}

# Verificar si la eliminación fue exitosa
if [ $? -eq 0 ]; then
  echo "Secretos eliminados exitosamente de Secrets Manager."
else
  echo "Error al eliminar secretos de Secrets Manager."
fi

echo "Proceso de eliminación de secretos de Secrets Manager completado."

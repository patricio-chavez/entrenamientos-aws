#!/bin/bash

# Guardar las credenciales en un secreto
export NUMERO_ALEATORIO=$(shuf -i 10000000-99999999 -n 1)
export NOMBRE_SECRETO=credenciales-automation-$NUMERO_ALEATORIO
aws secretsmanager create-secret --name $NOMBRE_SECRETO --secret-string '{"ACCESS_KEY_ID": "'"$ACCESS_KEY_ID"'", "SECRET_ACCESS_KEY": "'"$SECRET_ACCESS_KEY"'"}'

# Recuperar las credenciales en un secreto
aws secretsmanager get-secret-value --secret-id $NOMBRE_SECRETO

cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de AWS Secrets Manager completado."

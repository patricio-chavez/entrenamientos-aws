#!/bin/bash

# Variables necesarias
echo "Configurando variables para EKS..."
export CLUSTER='cluster-eks'
export AWS_REGION='us-east-1'

# Eliminar OpenID Connect
echo "Eliminando OpenID Connect..."
providers=$(aws iam list-open-id-connect-providers --query 'OpenIDConnectProviderList[].Arn' --output text)
for provider in $providers; do
    aws iam delete-open-id-connect-provider --open-id-connect-provider-arn "$provider"
done

# Eliminar el cluster EKS
echo "Elimiando el cluster EKS..."
eksctl delete cluster --name $CLUSTER --region $AWS_REGION

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de limpieza de EKS completado."

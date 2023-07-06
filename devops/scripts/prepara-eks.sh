#!/bin/bash

# Variables necesarias
echo "Configurando variables para EKS..."
export CLUSTER='cluster-eks'
export AWS_REGION='us-east-1'
export ZONAS='us-east-1a,us-east-1b,us-east-1c'
export TIPO_INSTANCIA='t3.medium'

# Crear el cluster EKS
echo "Creando el cluster EKS..."
eksctl create cluster --name $CLUSTER --region $AWS_REGION --zones $ZONAS --node-type $TIPO_INSTANCIA

# Configurar kubeconfig
echo "Actualizando el kubeconfig..."
aws eks update-kubeconfig --name $CLUSTER --region $AWS_REGION

# Configurar OpenID Connect
echo "Configurando OpenID Connect..."
eksctl utils associate-iam-oidc-provider --cluster $CLUSTER --region $AWS_REGION --approve

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de EKS completado."
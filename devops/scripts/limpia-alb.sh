#!/bin/bash

# Variables necesarias
echo "Configurando variables para AWS ALB Controller..."
export CLUSTER='cluster-eks'

# Eliminar AWS LoadBalancer Controller
echo "Eliminando AWS LoadBalancer Controller..."
helm uninstall aws-load-balancer-controller -n kube-system

# Eliminar la cuenta de servicio para ALB Controller
echo "Eliminando la cuenta de servicio para AWS ALB Controller"
eksctl delete iamserviceaccount \
  --cluster=$CLUSTER \
  --namespace=kube-system \
  --name=aws-load-balancer-controller

# Eliminar el repositorio de HELM EKS
echo "Eliminando el repositorio de HELM EKS..."
helm repo remove eks

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de limpieza de AWS ALB Controller completado."

#!/bin/bash

# Variables necesarias
echo "Configurando variables para AWS ALB Controller..."
export CLUSTER='cluster-eks'

# Obtener el ARN de la política para el AWS LoadBalancer Controller
echo "Obteniendo el ARN de la política para el AWS LoadBalancer Controller"
export ARN_AWSLoadBalancerControllerIAMPolicy=$(aws iam list-policies --query 'Policies[?PolicyName==`AWSLoadBalancerControllerIAMPolicy`].Arn' --output text)
echo "ARN_AWSLoadBalancerControllerIAMPolicy=$ARN_AWSLoadBalancerControllerIAMPolicy"

# Crear una cuenta de servicio para ALB Controller
echo "Creando una cuenta de servicio para AWS ALB Controller"
eksctl create iamserviceaccount \
  --cluster=$CLUSTER \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=$ARN_AWSLoadBalancerControllerIAMPolicy \
  --approve

# Configurar repositorio de HELM
echo "Configurando el repositorio de HELM EKS..."
helm repo add eks https://aws.github.io/eks-charts
helm repo update

# Instalar AWS LoadBalancer Controller
echo "Instalando AWS ALB Controller..."
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=$CLUSTER \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

# Verificar el estado del deployment
echo "Verificando el deployment..."
kubectl get deployment -n kube-system aws-load-balancer-controller

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de AWS ALB Controller completado."

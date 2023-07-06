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

# Verificar la instalación
echo "Verificando el despliegue..."
contador=0
TIMEOUT=600  # Límite de tiempo en segundos
INTERVALO=5  # Intervalo de espera en segundos

while [ $contador -lt $TIMEOUT ]; do
    status=$(kubectl get deployment aws-load-balancer-controller -n kube-system -o jsonpath='{.status.conditions[?(@.type=="Available")].status}')
    if [ "$status" == "True" ]; then
        echo "El despliegue de External DNS ya está listo."
        break
    fi
    echo "Esperando la disponibilidad del despliegue de External DNS..."
    sleep $INTERVALO
    contador=$((contador + INTERVALO))
done

if [ $contador -ge $TIMEOUT ]; then
    echo "Error: El despliegue de External DNS superó el tiempo límite de espera."
    exit 1
fi

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de AWS ALB Controller completado."

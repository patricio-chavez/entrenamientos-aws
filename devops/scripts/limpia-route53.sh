#!/bin/bash

# Variables necesarias
echo "Configurando variables para EKS..."
export CLUSTER='cluster-eks'
export ESPACIO_NOMBRES_DNS='external-dns'
export NOMBRE_CUENTA_SERVICIO_DNS='external-dns'

# Eliminar ExternalDNS
echo "Eliminando ExternalDNS..."
kubectl delete deployment external-dns -n $ESPACIO_NOMBRES_DNS

# Eliminar el rol y el rol de asociación
echo "Eliminando el rol y el rol de asociación para ExternalDNS..."
kubectl delete clusterrole external-dns
kubectl delete clusterrolebinding external-dns-viewer

# Eliminar la cuenta de servicio
echo "Eliminando la cuenta de servicio para ExternalDNS..."
eksctl delete iamserviceaccount --cluster $CLUSTER --name $NOMBRE_CUENTA_SERVICIO_DNS --namespace $ESPACIO_NOMBRES_DNS

# Eliminar la política de ExternalDNS
echo "Eliminando la política de ExternalDNS..."
aws iam delete-policy --policy-arn $(aws iam list-policies --query 'Policies[?PolicyName==`AllowExternalDNSUpdates`].Arn' --output text)

# Eliminar el espacio de nombres (namespace)
echo "Eliminando el espacio de nombres (namespace) dedicado a ExternalDNS..."
kubectl delete namespace $ESPACIO_NOMBRES_DNS

echo "Proceso de limpieza de Route 53 completado."

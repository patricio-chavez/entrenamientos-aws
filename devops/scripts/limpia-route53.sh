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
kubectl delete clusterrolebinding external-dns-viewer --ignore-not-found=true

# Eliminar la cuenta de servicio
echo "Eliminando la cuenta de servicio para ExternalDNS..."
eksctl delete iamserviceaccount --cluster $CLUSTER --name $NOMBRE_CUENTA_SERVICIO_DNS --namespace $ESPACIO_NOMBRES_DNS

# Eliminar el espacio de nombres (namespace)
echo "Eliminando el espacio de nombres (namespace) dedicado a ExternalDNS..."
kubectl delete namespace $ESPACIO_NOMBRES_DNS --ignore-not-found=true

echo "Proceso de limpieza de Route 53 completado."

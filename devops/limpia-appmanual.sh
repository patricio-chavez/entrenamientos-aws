#!/bin/bash

# Variables necesarias
echo "Configurando variables para desplegar la aplicación estática en forma manual..."
export ESPACIO_NOMBRES_APLICACION_MANUAL="despliegue-manual"
export SERVICIO_APLICACION_MANUAL="servicio-aplicacion-estatica"
export NOMBRE_DESPLIEGUE="aplicacion-estatica"
export CONFIGMAP_APLICACION_MANUAL="aplicacion-estatica"
export NOMBRE_INGRESO="ingreso-aplicacion-estatica"

# Eliminar el Ingress
echo "Eliminando el Ingress $NOMBRE_INGRESO..."
kubectl delete ingress $NOMBRE_INGRESO -n $ESPACIO_NOMBRES_APLICACION_MANUAL

# Eliminar el Deployment
echo "Eliminando el Deployment $NOMBRE_DESPLIEGUE..."
kubectl delete deployment $NOMBRE_DESPLIEGUE -n $ESPACIO_NOMBRES_APLICACION_MANUAL

# Eliminar el ConfigMap
echo "Eliminando el ConfigMap $CONFIGMAP_APLICACION_MANUAL..."
kubectl delete configmap $CONFIGMAP_APLICACION_MANUAL -n $ESPACIO_NOMBRES_APLICACION_MANUAL

# Eliminar el Service
echo "Eliminando el Service $SERVICIO_APLICACION_MANUAL..."
kubectl delete service $SERVICIO_APLICACION_MANUAL -n $ESPACIO_NOMBRES_APLICACION_MANUAL

# Eliminar el Namespace
echo "Eliminando el Namespace $ESPACIO_NOMBRES_APLICACION_MANUAL..."
kubectl delete namespace $ESPACIO_NOMBRES_APLICACION_MANUAL

# Eliminar ficheros
echo "Eliminando ficheros..."
rm -rf ingreso-aplicacion-estatica.yaml
rm -rf despliegue-aplicacion-estatica.yaml
rm -rf configmap-aplicacion-estatica.yaml
rm -rf servicio-aplicacion-estatica.yaml
rm -rf namespace-aplicacion-estatica.yaml

# Eliminar directorio codigo
echo "Eliminando directorio codigo..."
rm -Rf $HOME/mi-repositorio/codigo

cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de eliminación de Aplicación estática manual completado."

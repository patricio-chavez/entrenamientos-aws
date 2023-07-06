#!/bin/bash

# Variables necesarias
echo "Configurando variables para EKS..."
export CLUSTER='cluster-eks'
export AWS_REGION='us-east-1'
export ESPACIO_NOMBRES_DNS='external-dns'
export NOMBRE_CUENTA_SERVICIO_DNS='external-dns'

# Obtener el ARN de la política de ExternalDNS existente
echo "Obteniendo el ARN de la política de ExternalDNS existente..."
export ARN_POLICY_DNS=$(aws iam list-policies --query 'Policies[?PolicyName==`AllowExternalDNSUpdates`].Arn' --output text)
echo $ARN_POLICY_DNS

# Crear un espacio de nombres dedicado a ExternalDNS
echo "Creando un espacio de nombres (namespace) dedicado..."
kubectl create namespace $ESPACIO_NOMBRES_DNS

# Crear una cuenta de servicios para ExternalDNS
echo "Creando una cuenta de servicios para ExternalDNS..."
eksctl create iamserviceaccount --cluster $CLUSTER --name $NOMBRE_CUENTA_SERVICIO_DNS --namespace $ESPACIO_NOMBRES_DNS --attach-policy-arn $ARN_POLICY_DNS --approve --override-existing-serviceaccounts

# Crear un rol para ExternalDNS
echo "Creando el rol para ExternalDNS..."
cat << EOF > ExternalDNS-cluster-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: external-dns
  labels:
    app.kubernetes.io/name: external-dns
rules:
  - apiGroups: [""]
    resources: ["services","endpoints","pods","nodes"]
    verbs: ["get","watch","list"]
  - apiGroups: ["extensions","networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get","watch","list"]
EOF
kubectl apply -f ExternalDNS-cluster-role.yaml

# Asociar el cluster role de ExternalDNS
echo "Asociando el rol para ExternalDNS..."
cat << EOF > ExternalDNS-cluster-role-binding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: external-dns-viewer
  labels:
    app.kubernetes.io/name: external-dns
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: external-dns
subjects:
  - kind: ServiceAccount
    name: external-dns
    namespace: ${EXTERNALDNS_NS}
EOF
kubectl apply -f ExternalDNS-cluster-role-binding.yaml

# Listas las zonas hosteadas en Route 53
echo "Listando todas las zonas hosteadas en Route 53..."
aws route53 list-hosted-zones --query 'HostedZones[].Name'



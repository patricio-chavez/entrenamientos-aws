#!/bin/bash

# Variables necesarias
echo "Configurando variables para EKS..."
export CLUSTER='cluster-eks'
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

# Listar las zonas hosteadas en Route 53
echo "Listando todas las zonas hosteadas en Route 53..."
aws route53 list-hosted-zones --query 'HostedZones[].Name'


# Exportar solo la primera zona listada
echo "Exportando el nombre de la primera zona y dominio..."
export NOMBRE_ZONA=$(aws route53 list-hosted-zones --query 'HostedZones[0]'.Name)
export DOMINIO=ana-solution.com=$(aws route53 list-hosted-zones --query 'HostedZones[0]'.Name | cut -d'"' -f2 | sed 's/\.$//')

echo "NOMBRE_ZONA=$NOMBRE_ZONA"
echo "DOMINIO=$DOMINIO"

# Obtener el AWS Account ID
echo "Obteniendo el AWS Account ID..."
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID"

# Configurar ExternalDNS
echo "Configurando ExternalDNS..."
cat << EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns
  namespace: $ESPACIO_NOMBRES_DNS
  labels:
    app.kubernetes.io/name: external-dns
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app.kubernetes.io/name: external-dns
  template:
    metadata:
      labels:
        app.kubernetes.io/name: external-dns
    spec:
      serviceAccountName: $NOMBRE_CUENTA_SERVICIO_DNS
      containers:
        - name: external-dns
          image: k8s.gcr.io/external-dns/external-dns:v0.12.2
          args:
            - --source=ingress
            - --source=service            
            - --provider=aws
            - --policy=sync
            - --aws-zone-type=public
            - --registry=txt
            - --txt-owner-id=external-dns
EOF

# Verificar la instalación
echo "Verificando el despliegue..."
kubectl get deployment external-dns -n $ESPACIO_NOMBRES_DNS 

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de Route 53 completado."

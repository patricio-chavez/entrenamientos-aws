#!/bin/bash

# Crear el usuario cloud_automation en IAM
export NOMBRE_USUARIO="cloud_automation"
echo "Creando usuario en IAM: $NOMBRE_USUARIO"
aws iam create-user --user-name $NOMBRE_USUARIO

# Verificar si la creación fue exitosa
if [ $? -eq 0 ]; then
  echo "Usuario creado exitosamente en IAM."
else
  echo "Error al crear el usuario en IAM."
  exit 1
fi

# Crear las llaves de acceso programático
SALIDA=$(aws iam create-access-key --user-name cloud_automation --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output text)
read -r ACCESS_KEY_ID SECRET_ACCESS_KEY <<< "$SALIDA"

# Almacenar las llaves en variables 
export ACCESS_KEY_ID=$ACCESS_KEY_ID
export SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY

# Imprimir los valores solamente para verificar en el entrenamiento. En Producción no es recomendable mostrar las claves
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"

# Crear la política para el AWS LoadBalancer Controller
echo "Creando la política para AWS LoadBalancer Controller..."
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.7/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

# Crear la una política para ExternalDNS
echo "Creando la política para ExternalDNS..."
cat << EOF > external-dns-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF

aws iam create-policy --policy-name "AllowExternalDNSUpdates" --policy-document file://external-dns-policy.json

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de AWS IAM completado."
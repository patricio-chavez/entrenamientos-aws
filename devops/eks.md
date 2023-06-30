# Prácticas Devops en Amazon Web Services (AWS)
## Amazon Elastic Kubernetes Service (EKS)

## Despliega un cluster EKS {#despliega-un-cluster-eks}

### Configura variables para facilitar la reutilización
```shell
export CLUSTER='cluster-eks'
export REGION='us-east-1'
export ZONAS='us-east-1a,us-east-1b,us-east-1c'
export TIPO_INSTANCIA='t2.micro'
```

### Crea el cluster EKS
```shell
eksctl create cluster --name $CLUSTER --region $REGION --zones $ZONAS --node-type $TIPO_INSTANCIA
```
## Configura el acceso programático {#configura-el-acceso-programatico}
```shell
aws eks update-kubeconfig --name $CLUSTER --region $REGION
```

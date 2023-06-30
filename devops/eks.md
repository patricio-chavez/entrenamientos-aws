# Prácticas Devops en Amazon Web Services (AWS)
## Amazon Elastic Kubernetes Service (EKS)

### Despliega un cluster
```shell
eksctl create cluster --name cluster-eks --region us-east-1 --zones us-east-1a,us-east-1b,us-east-1c --node-type t2.micro
```
### Configura el acceso programático
```shell
aws eks update-kubeconfig --name 
```

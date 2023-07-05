# Prácticas Devops en Amazon Web Services (AWS)
## Amazon Route 53

Amazon Route 53 es un servicio de Sistema de Nombres de Dominio (DNS) altamente escalable y confiable ofrecido por Amazon Web Services (AWS). Como servicio de DNS administrado, Route 53 proporciona la capacidad de registrar y administrar los nombres de dominio para tus aplicaciones y recursos en la nube.

Este servicio te permite asociar tus nombres de dominio a diferentes recursos de AWS, como instancias de Amazon EC2, balanceadores de carga de Elastic Load Balancing, buckets de Amazon S3 y muchos otros servicios. También puedes crear registros de DNS para realizar el enrutamiento del tráfico hacia tus recursos.

Además de las funcionalidades de DNS tradicionales, Amazon Route 53 también ofrece servicios avanzados, como la administración de zonas alojadas privadas, la capacidad de monitorear y registrar la salud de tus recursos con healthchecks y la integración con otros servicios de AWS para una gestión y configuración automatizadas.

### ExternalDNS

El controlador ExternalDNS es una herramienta que permite la automatización de la configuración de registros DNS externos. Con ExternalDNS, puedes asociar automáticamente los nombres de dominio de tus servicios en Kubernetes con registros DNS externos, como aquellos administrados por Amazon Route 53.

Puedes definir archivos de configuración declarativos que especifiquen los nombres de dominio y las reglas de enrutamiento para tus servicios en Kubernetes. El controlador ExternalDNS se encargará de mantener la correspondencia entre los servicios y los registros DNS externos, creando o actualizando los registros DNS según sea necesario.

### Crea una cuenta de servicio para ExternalDNS

En IAM (Identity and Access Management) una de las políticas creadas tuvo como objetivo permitir acciones a la cuenta de servicio de ExternalDNS sobre Route 53. Es momento de configurarla y como primera paso recupera el identificador ARN para luego mapearlo a la cuenta de servicio.

```shell
export ARN_POLICY_DNS=$(aws iam list-policies --query 'Policies[?PolicyName==`AllowExternalDNSUpdates`].Arn' --output text)
echo $ARN_POLICY_DNS
```

Define un espacio de nombres para el controlador utilizando kubectl. Un namespace actúa como un contenedor virtual que permite agrupar y separar aplicaciones, servicios y otros recursos relacionados en un entorno de Kubernetes. Proporciona un ámbito aislado para los recursos, lo que significa que los nombres de los recursos pueden ser reutilizados en diferentes namespaces sin conflictos.

Los namespaces también pueden ser utilizados para aplicar políticas de seguridad y de acceso basadas en roles (RBAC), lo que permite controlar los permisos y el acceso a los recursos dentro de un namespace específico.

```shell
export ESPACIO_NOMBRES_DNS='external-dns'
kubectl create namespace $ESPACIO_NOMBRES_DNS
```


Para crear una cuenta de servicio en tu clúster de Amazon EKS y asignarle una política de IAM, puedes utilizar el siguiente comando:

```shell
export NOMBRE_CUENTA_SERVICIO_DNS='external-dns'
export ESPACIO_NOMBRES_DNS='external-dns'
export CLUSTER='cluster-eks'

eksctl create iamserviceaccount --cluster $CLUSTER --name $NOMBRE_CUENTA_SERVICIO_DNS --namespace $ESPACIO_NOMBRES_DNS --attach-policy-arn $ARN_POLICY_DNS --approve --override-existing-serviceaccounts
```
El parámetro --approve indica que se debe aprobar la creación de la cuenta de servicio sin requerir confirmación adicional.


[Volver](indice.md)
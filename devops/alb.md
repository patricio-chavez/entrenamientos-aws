# Prácticas Devops en Amazon Web Services (AWS)
## Elastic Load Balancing

Elastic Load Balancing (ELB) es un servicio de balanceo de carga altamente escalable y administrado ofrecido por Amazon Web Services (AWS). Proporciona una solución eficiente para distribuir el tráfico de red de manera equilibrada entre múltiples instancias o servicios en la nube.

- Application Load Balancer (ALB): Es un balanceador de carga a nivel de aplicación que opera en la capa 7 del modelo OSI. Permite enrutamiento basado en contenido y soporta características avanzadas, como la terminación SSL/TLS, el enrutamiento basado en URL, la inyección de encabezados HTTP y la autenticación de usuarios.

- Network Load Balancer (NLB): Es un balanceador de carga a nivel de conexión de capa 4 que permite la distribución de tráfico en tiempo real a través de puertos específicos. Proporciona un alto rendimiento y una baja latencia, siendo ideal para aplicaciones que requieren un alto rendimiento y una conexión persistente, como aplicaciones de streaming o juegos en línea.

- Classic Load Balancer: Es la versión anterior de ELB, que aún es compatible para los usuarios existentes. Proporciona un balanceo de carga a nivel de transporte (capa 4) y es adecuado para aplicaciones que no requieren características avanzadas a nivel de aplicación.

### AWS ALB Controller
El controlador de balanceador de carga de AWS (AWS Load Balancer Controller) es una herramienta que permite gestionar y configurar balanceadores de carga en entornos de AWS de manera automatizada y basada en infraestructura como código.

Con el controlador de balanceador de carga de AWS, puedes definir y administrar fácilmente los balanceadores de carga de aplicación de AWS, como el balanceador de carga de aplicación (ALB) y el balanceador de carga de red (NLB), utilizando archivos de configuración declarativos.

Esta práctica DevOps permite automatizar el proceso de aprovisionamiento y configuración de balanceadores de carga, facilitando la implementación y el escalado de aplicaciones en la nube de AWS. Al utilizar el controlador de balanceador de carga de AWS, puedes garantizar la disponibilidad y el rendimiento de tus aplicaciones al distribuir automáticamente el tráfico entrante entre las instancias y los servicios.

Una de las funcionalidades clave del controlador de balanceador de carga de AWS es su capacidad para manejar el tráfico de entrada utilizando el concepto de "ingress" en Kubernetes. El ingreso (ingress) en Kubernetes permite la exposición de servicios y el enrutamiento del tráfico entrante a través de un balanceador de carga. El controlador de balanceador de carga de AWS se encarga de configurar automáticamente los balanceadores de carga de aplicación de AWS (como el balanceador de carga de aplicación - ALB) para que actúen como el punto de entrada para el tráfico hacia los servicios de Kubernetes.

Para utilizar el controlador de balanceador de carga de AWS, es necesario referenciar la política de IAM que has creado al principio del entrenamiento. Esto permite realizar llamadas a las API de AWS en tu nombre.

Recuerda que los recursos en AWS se referencian de forma unívoca a través del identificador ARN. Puedes obtenerlo listando las políticas de IAM y filtrando por el nombre de la política AWSLoadBalancerControllerIAMPolicy. Luego, asigna el ARN de la política a la variable de entorno ARN_AWSLoadBalancerControllerIAMPolicy utilizando el comando export.

```bash
export ARN_AWSLoadBalancerControllerIAMPolicy=$(aws iam list-policies --query 'Policies[?PolicyName==`AWSLoadBalancerControllerIAMPolicy`].Arn' --output text)
echo "ARN_AWSLoadBalancerControllerIAMPolicy=$ARN_AWSLoadBalancerControllerIAMPolicy"
```

### Crea una cuenta de servicio para ALB Controller

Para que el controlador de balanceador de carga de AWS funcione correctamente en tu clúster de Amazon Elastic Kubernetes Service (Amazon EKS), es necesario crear una cuenta de servicio IAM específica. Esto se puede lograr de diversas maneras pero por simplicidad utiliza eksctl.

```bash
eksctl create iamserviceaccount \
  --cluster=$CLUSTER \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=$ARN_AWSLoadBalancerControllerIAMPolicy \
  --approve
```

### Configura el repositorio Helm EKS

Para desplegar el controlador de balanceador de carga de AWS en tu clúster de Amazon Elastic Kubernetes Service (Amazon EKS), necesitarás configurar un repositorio de Helm que contenga los charts necesarios. 

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```

El primer comando, helm repo add, se utiliza para agregar un nuevo repositorio de Helm llamado "eks" y se asigna la URL del repositorio https://aws.github.io/eks-charts. Esto permitirá a Helm acceder y descargar los charts necesarios para el controlador de balanceador de carga de AWS.

El segundo comando, helm repo update, se utiliza para actualizar los repositorios de Helm configurados en tu entorno local. Esto garantiza que Helm tenga la información más actualizada sobre los charts disponibles en los repositorios configurados.

### Despliega el controlador

Una vez que hayas configurado el repositorio de Helm para el controlador de balanceador de carga de AWS, puedes proceder a la instalación del controlador en tu clúster de Amazon Elastic Kubernetes Service (Amazon EKS). 

```shell
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=$CLUSTER \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
```

Se utiliza el chart eks/aws-load-balancer-controller del repositorio configurado previamente. Se especifica el namespace kube-system donde se instalará el controlador. Además, se deshabilita la creación de una nueva cuenta de servicio (serviceAccount.create=false) y se especifica el nombre de la cuenta de servicio existente (serviceAccount.name=aws-load-balancer-controller) que has creado previamente.

### Verifica el despliegue del controlador

Después de haber instalado el controlador de balanceador de carga de AWS en tu clúster de Amazon Elastic Kubernetes Service (Amazon EKS) utilizando Helm, puedes verificar el estado del despliegue del controlador. Esto te permitirá confirmar si el controlador se ha desplegado correctamente y si las réplicas están en funcionamiento.

```shell
kubectl get deployment -n kube-system aws-load-balancer-controller
```
Al ejecutar este comando, obtendrás una salida que muestra detalles importantes sobre el despliegue, como el nombre del despliegue, el estado de las réplicas y la disponibilidad.

Asegúrate de revisar los resultados para confirmar que el controlador de balanceador de carga está en funcionamiento y todas las réplicas están listas y disponibles. Si no se muestra el estado deseado o hay problemas con el despliegue, puedes utilizar otros comandos de diagnóstico, como kubectl logs, para obtener más información y resolver posibles problemas.

[Volver](indice.md)
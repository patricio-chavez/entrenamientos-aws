# Prácticas Devops en Amazon Web Services (AWS)

En este entrenamiento de Prácticas DevOps en Amazon Web Services (AWS), exploraremos cómo integrar el desarrollo y las operaciones de manera eficiente en el entorno de AWS. A medida que las organizaciones buscan mejorar la entrega de software y optimizar sus procesos, DevOps se ha vuelto fundamental. Aprenderemos estrategias, técnicas y mejores prácticas para construir y desplegar aplicaciones en la nube de manera confiable y eficiente.

## Camino de aprendizaje

Este camino de aprendizaje en AWS DevOps te guiará a través de una serie de temas clave que te ayudarán a dominar las prácticas de desarrollo y operaciones en el entorno de Amazon Web Services (AWS). Cada tema aborda una herramienta o servicio específico de AWS con un enfoque práctico fundamental para implementar y gestionar de manera eficiente las soluciones en la nube.

A medida que avanzas en este camino de aprendizaje, aprenderás cómo utilizar AWS Code Commit para gestionar tus repositorios de código de forma segura. Luego, te adentrarás en AWS Identity and Access Management (IAM) para configurar el acceso programático y garantizar la seguridad de tus recursos en AWS. Además, descubrirás cómo utilizar AWS Secrets Manager para almacenar y recuperar de forma segura las credenciales y secretos necesarios en tus aplicaciones.

A continuación, explorarás AWS CloudFormation para desplegar y administrar la infraestructura como código, lo que te permitirá crear y gestionar recursos de manera automatizada y consistente. Te sumergirás en AWS EKS (Elastic Kubernetes Service) para desplegar y gestionar clústeres de Kubernetes en la nube de AWS, y aprenderás a desplegar aplicaciones en este entorno escalable y altamente disponible. Y mucho más!

Sigue este camino de aprendizaje paso a paso, completa los ejercicios prácticos y consolida tus conocimientos en AWS DevOps. 

Indice 

- [Comienza aquí](herramientas.md#Comienza-aquí)
  - [Herramientas requeridas](herramientas.md#Herramientas-requeridas)
  - [Entorno de pruebas](herramientas.md#Entorno-de-pruebas)

- [AWS Code Commit](codecommit.md)
  - [Prepara el sistema operativo](codecommit.md#Prepara-el-sistema-operativo)
  - [Crea tu primer repositorio](codecommit.md#Crea-tu-primer-repositorio)
  - [Sube código](codecommit.md#Sube-código)

- [AWS Identity and Access Management](iam.md)
  - [Crea el usuario cloud_automation](iam.md#Crea-el-usuario-cloud_automation)
  - [Configura el acceso programático](iam.md#Configura-el-acceso-programático)
  - [Crea una política para AWS ALB Controller](iam.md#Crea-una-política-para-AWS-ALB-Controller)
  - [Crea una política para ExternalDNS](iam.md#Crea-una-política-para-ExternalDNS)

- [AWS Secrets Manager](secretsmanager.md)
  - [Resguarda credenciales](secretsmanager.md#Resguarda-credenciales)
  - [Recupera credenciales](secretsmanager.md#Resguarda-recupera)

- [AWS EKS](eks.md)
  - [Lanza un cluster](eks.md#Lanza-un-cluster-EKS)
  - [Aprovecha eksctl](eks.md#Aprovecha-eksctl)
  - [Configura el kubeconfig](eks.md#Configura-el-kubeconfig)
  
- [Elastic Load Balancing](alb.md)
  - [AWS ALB Controller](alb.md#AWS-ALB-Controller)
  - [Crea una cuenta de servicio para ALB Controller](alb.md#Crea-una-cuenta-de-servicio-para-ALB-Controller)
  - [Configura el repositorio Helm EKS](alb.md#Configura-el-repositorio-Helm-EKS)
  - [Despliega el controlador](alb#Despliega-el-controlador)

- [Amazon Route 53](route53.md)
  - [ExternalDNS](route53.md#ExternalDNS)
  - [Crea una cuenta de servicio para ExternalDNS](route53.md#Crea-una-cuenta-de-servicio-para-ExternalDNS)

- [AWS CodeBuild](codebuild.md)
  - Crea tu primer proyecto
  - Verifica el ciclo de vida
  - Revisa los logs

- AWS CodePipeline
  - Crea tu primer primer pipeline
  - Verifica el estado
  - Resguarda la configuración

- Ciclo contínuo
  - Modifica la aplicación
  - Verifica el estado del pipeline
  - Comprueba los resultados

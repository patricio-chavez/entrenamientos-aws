# Prácticas Devops en Amazon Web Services (AWS)
## AWS CloudFormation

AWS CloudFormation es un servicio de administración de infraestructura como código (Infrastructure as Code) que te permite crear y gestionar recursos de AWS de manera automatizada. Con CloudFormation, puedes describir tu infraestructura y aplicaciones en un fichero de plantilla, y luego utilizar ese fichero para crear, actualizar y eliminar recursos de forma segura y predecible.

CloudFormation te brinda la capacidad de definir tus recursos y sus relaciones de manera declarativa, lo que significa que puedes describir cómo deben verse tus recursos y cómo deben interactuar entre sí, en lugar de realizar configuraciones manuales. Esto te permite mantener un control completo sobre tu infraestructura y garantizar la coherencia y la reproducibilidad en todas tus implementaciones.

### Primera plantilla

Para mayor flexibilidad y reutilización al trabajar con AWS CloudFormation, puedes utilizar variables para definir valores que se utilizarán en tu plantilla. Esto te permite cambiar fácilmente esos valores en el futuro sin tener que modificar la plantilla en sí.

En este ejemplo, vamos a crear dos variables: NOMBRE_CLUSTER y AWS_REGION. La variable NOMBRE_CLUSTER contendrá el nombre que deseas asignar a tu clúster de Amazon EKS, y la variable AWS_REGION contendrá la región de AWS en la que deseas crear el clúster.

```shell
export NOMBRE_CLUSTER='mi-cluster-eks'
export AWS_REGION='us-east-1'
```

### Describe la infrastructura en un fichero

Puedes describir tu infraestructura utilizando un fichero YAML en AWS CloudFormation. El formato YAML es legible para humanos y te permite definir los recursos y configuraciones de tu infraestructura de manera estructurada. También puedes utilizar JSON para describir tu infraestructura en AWS CloudFormation. AWS CloudFormation admite tanto YAML como JSON como formatos de plantilla.


```shell
cat << EOF > crear-namespace-cb.yaml
AWSTemplateFormatVersion: "2010-09-09"
Description: Proyecto CodeBuild para crear el espacio de nombres de la Aplicación Demo
Resources:
  Project:
    Type: AWS::CodeBuild::Project    
    Properties:
      Name: CBAPPDemoCrearNS
      Description: Esta plantilla crea el espacio de nombres en el cluster EKS para la aplicaciñón de ejemplo
      ServiceRole: arn:aws:iam::$ROL
      Artifacts:
        Type: no_artifacts
      Environment:
        Type: LINUX_CONTAINER
        ComputeType: BUILD_GENERAL1_SMALL
        Image: aws/codebuild/standard:4.0
        EnvironmentVariables:
          - Name: NOMBRE_CLUSTER
            Type: PLAINTEXT
            Value: $NOMBRE_CLUSTER
          - Name: AWS_REGION
            Type: PLAINTEXT
            Value: $AWS_REGION
          - Name: AWS_ACCESS_KEY_ID
            Type: PLAINTEXT
            Value: !Sub '{{resolve:secretsmanager:cred-pipeline:SecretString:AWS_ACCESS_KEY_ID}}'
          - Name: AWS_SECRET_ACCESS_KEY
            Type: PLAINTEXT
            Value: !Sub '{{resolve:secretsmanager:cred-pipeline:SecretString:AWS_SECRET_ACCESS_KEY}}' 
      Source:
        Location: https://git-codecommit.us-east-1.amazonaws.com/v1/repos/entrenamientos-aws
        Type: CODECOMMIT
        BuildSpec: devops/app-ejemplo/codebuild/namespace/buildspec.yml
      TimeoutInMinutes: 10
EOF
```

[Volver](indice.md)
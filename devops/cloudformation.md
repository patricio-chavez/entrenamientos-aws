# Prácticas Devops en Amazon Web Services (AWS)
## AWS CloudFormation


### Primera plantilla
#### Para mayor flexibilidad y reutilización crea variables
```shell
export NOMBRE_CLUSTER='mi-cluster-eks'
export AWS_REGION='us-east-1'
```

#### Crea una plantilla cuyo resultado final será un Proyecto de AWS CodeBuild

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
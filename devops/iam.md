# Prácticas Devops en Amazon Web Services (AWS)
## AWS Identity and Access Management

IAM (Identity and Access Management) es el servicio de gestión de identidades y accesos de AWS. Con IAM, puedes controlar de manera precisa quién tiene acceso a los recursos de AWS y qué acciones pueden realizar.

IAM te permite crear y gestionar usuarios, grupos y roles, y asignar permisos específicos a cada uno de ellos. Puedes crear políticas de IAM que definen los permisos y acciones permitidas, y luego asociar esas políticas a los usuarios, grupos o roles correspondientes.

Esto te brinda un nivel granular de control sobre quién puede acceder a tus recursos y qué pueden hacer con ellos. Además, IAM ofrece integración con otros servicios de AWS, lo que te permite definir políticas de acceso a nivel de servicio y utilizar identidades federadas para facilitar la gestión de usuarios y permisos.

### Crea el usuario cloud_automation

Para garantizar la seguridad y seguir el principio de menores privilegios, es recomendable crear un usuario separado para automatizar tareas en AWS. En este caso, crearemos un usuario llamado "cloud_automation" que nos permitirá realizar operaciones sin la necesidad de utilizar nuestras credenciales personales.

Para crear el usuario "cloud_automation", ejecuta el siguiente comando:

```shell
aws iam create-user --user-name cloud_automation
```

IAM te mostrará gráficamente el usuario y puedes explorar las opciones para comprobar que aún no tiene ningún privilegio asignado.

<div align="center">
  <img src="imagenes/usuario_cloud_automation.png" alt="Usuario cloud_automation">
</div>

En este momento el usuario no tiene asignados privilegios específicos. A medida que avancemos en las prácticas, iremos otorgando permisos de manera controlada y según las necesidades del usuario para realizar tareas específicas en AWS. Esto nos permite mantener un enfoque de seguridad y cumplir con el principio de menor privilegio.

### Configura el acceso programático del usuario cloud_automation

Para permitir que el usuario "cloud_automation" acceda a AWS de forma programática, necesitamos generar las credenciales de acceso correspondientes. Estas credenciales serán utilizadas para autenticar las solicitudes de API que realice el usuario.

Este comando generará un par de claves de acceso compuesto por una Access Key ID y una Secret Access Key. Para comprobar que están resguardadas y con fines didácticos durante la formación, ya que no podrás recuperar la Secret Access Key posteriormente, las puedes imprimir. Normalmente se exportan e ingestan directamente en el repositorio de claves como AWS Secrets Manager o se resguardan en otro lugar seguro.

```shell
SALIDA=$(aws iam create-access-key --user-name cloud_automation --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output text)
read -r ACCESS_KEY_ID SECRET_ACCESS_KEY <<< "$SALIDA"

# Imprimo los valores solamente para verificar, en Producción no es recomendable mostrar las claves
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"
```

Puedes verificar visualmente las credenciales de acceso programático del usuario "cloud_automation" en la Consola de IAM de AWS. Esto te permitirá confirmar que las claves de acceso se han creado correctamente aunque, lógicamente, no puedas ver la Secret Key.

<div align="center">
  <img src="imagenes/llaves-cloud_automation.png" alt="Llaves usuario cloud_automation">
</div>

Importante: Si por algún motivo no pudiste guardar las llaves en las variables, no te preocupes, bórrala y configura nuevamente el acceso programático. Lo importante es tener el juego de llaves activo, e inclusive, en el futuro verás que es una buena práctica rotar las los juegos de llaves que consiste en cambiar regularmente las claves de acceso utilizadas por los usuarios o servicios para acceder a los recursos de AWS. Esto ayuda a reducir el riesgo de compromiso de las claves y aumenta la seguridad de tus cuentas de AWS.

```shell
Ejecuta el código SOLO si deseas regenerar las llaves -> aws iam delete-access-key --user-name cloud_automation --access-key-id $(aws iam list-access-keys --user-name cloud_automation | jq -r '.AccessKeyMetadata[0].AccessKeyId'
```
## Crea una política para AWS ALB Controller

Crear una política de IAM que otorgará los permisos necesarios al AWS Load Balancer Controller para realizar llamadas a las API de AWS en su nombre. Esta política permitirá al controlador de balanceador de carga interactuar con los servicios de AWS requeridos para su funcionamiento cuando despliegues el ingreso a tu aplicación en EKS.

Descarga la plantilla

```shell
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.7/docs/install/iam_policy.json
```

Genera una política de IAM con la plantilla descargada

```shell
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
```

## Crea una política para ExternalDNS

Crear una política de IAM que otorgará los permisos necesarios ExternalDNS para realizar llamadas a las API de AWS en su nombre. Esta política permitirá al controlador de nombres interactuar con los servicios de AWS Route 53 requeridos para los objetos ingress de Kubernetes a tu aplicación en EKS.

Para trabajar con distintas alternativas, esta vez puedes utilizar el siguiente código con redirección de cat para crear una política de IAM en un archivo llamado "external-dns-policy.json" en lugar de descargarlo con curl:

```shell
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
        "route53:ListHostedZones",Continua con AWS Secrets Manager. También puedes revisar nuevamente el paso anterior AWS Code Commit o volver al Indice
    }
  ]
}
EOF
```

Crea la política de acuerdo al fichero generado previamente:

```shell
aws iam create-policy --policy-name "AllowExternalDNSUpdates" --policy-document file://external-dns-policy.json
```

Continua con [AWS Secrets Manager](secretsmanager.md). También puedes revisar nuevamente el paso anterior [AWS Code Commit](codecommit.md) o volver al [Indice](indice.md)
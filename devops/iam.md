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

### Configura el acceso programático
#### Aprovecha la salida para guardar las llaves en variables
```shell
OUTPUT=$(aws iam create-access-key --user-name cloud_automation --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output text)
read -r ACCESS_KEY_ID SECRET_ACCESS_KEY <<< "$OUTPUT"

# Imprimo los valores solamente para verificar, en Producción no es recomendable mostrar las claves
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"
```

<div align="center">
  <img src="imagenes/llaves-cloud_automation.png" alt="Llaves usuario cloud_automation">
</div>

### Importante: No es posible recuperar la Secret Access Key
#### Si por algún motivo no pudiste guardar las llaves en las variables, no te preocupes, bórrala y configura nuevamente el acceso programático
```shell
aws iam delete-access-key --user-name cloud_automation --access-key-id $(aws iam list-access-keys --user-name cloud_automation | jq -r '.AccessKeyMetadata[0].AccessKeyId'
```

[Volver](indice.md)
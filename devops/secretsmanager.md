# Prácticas Devops en Amazon Web Services (AWS)
## AWS Secrets Manager


### Resguarda credenciales
#### Guarda las credenciales del usuario cloud_automation
```shell
aws secretsmanager create-secret --name credenciales-pipeline --secret-string '{"ACCESS_KEY_ID": "'"$ACCESS_KEY_ID"'", "SECRET_ACCESS_KEY": "'"$SECRET_ACCESS_KEY"'"}'
```

<div align="center">
  <img src="imagenes/secreto-credenciales-pipeline.png" alt="Secreto Credenciales Pipeline">
</div>

### Recupera credenciales
#### Es posible recuperar las credenciales programáticamente pero ten precaución de no exponerlas en forma innecesaria
```shell
aws secretsmanager get-secret-value --secret-id credenciales-pipeline
```

#### Otra manera de recuperarlas, y verificación, es a través de la AWS Management Console

<div align="center">
  <img src="imagenes/secreto-credenciales-awsmc-recuperar.png" alt="Secreto Credenciales Pipeline AWS Management Console">
</div>

<div align="center">
  <img src="imagenes/secreto-credenciales-awsmc-visible.png" alt="Secreto Credenciales Pipeline AWS Management Console">
</div>

[Volver](indice.md)
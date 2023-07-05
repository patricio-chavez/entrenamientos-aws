# Prácticas Devops en Amazon Web Services (AWS)
# Comienza aquí

## Herramientas requeridas

Durante este entrenamiento de Prácticas DevOps en Amazon Web Services (AWS), nos beneficiaremos del uso de la CloudShell, una poderosa herramienta basada en la nube que nos brinda un entorno de línea de comandos preconfigurado y listo para usar. La CloudShell nos permite acceder y administrar nuestros recursos de AWS de manera conveniente, sin necesidad de instalar software adicional en nuestros equipos locales. Instalaremos y configuraremos herramientas adicionales según nuestras necesidades específicas. Estas herramientas complementarias nos ayudarán a automatizar tareas y optimizar la entrega de software en el entorno de AWS. Si sientes curiosidad de ver como se instalan echa un vistazo a prepara-cloudshell.sh que se encuentra dentro del directorio scripts.

## Entorno de pruebas

Para llevar a cabo los ejercicios y prácticas de este entrenamiento, necesitarás acceso a los servicios de AWS. Si no lo tienes aún, puedes solicitar una AWS Sandbox de [A Cloud Guru](https://learn.acloud.guru/cloud-playground/cloud-sandboxes). La AWS Sandbox es un entorno virtualizado y preconfigurado que te permitirá explorar y experimentar con los servicios de AWS de forma segura y sin sorpresas de costos adicionales.

### Configura el acceso programático

Inicia sesión en la consola de administración de AWS y abre una terminal de AWS CloudShell. Puedes encontrarla desde el buscador de servicios o directamente haciendo clic en el ícono de la AWS CloudShell en la esquina inferior izquierda de la consola de administración de AWS. 
La AWS CloudShell se abrirá dentro del espacio de la consola pero para mayor comodidad puedes iniciarla en una pestaña nueva del navegador.

<div align="center">
  <img src="imagenes/iniciar-cloudshell.png" alt="AWS CloudShell">
</div>

Configura el acceso programático tomando las credenciales de la bienvenida a AWS Sandbox y la región de la consola de administración de AWS. Por ejemplo, us-east-1.

```shell
aws configure
```

<div align="center">
  <img src="imagenes/aws-configure.png" alt="AWS CLI">
</div>

Para facilitar la configuración inicial, hemos creado un repositorio en GitHub que contiene los scripts necesarios para instalar y configurar las herramientas requeridas en la AWS CloudShell de forma automatizada. 

Sigue estos pasos para clonar el repositorio y ejecutar los scripts:

```shell
git clone https://github.com/patricio-chavez/entrenamientos-aws.git && cd $HOME/entrenamientos-aws/devops/scripts
chmod +x prepara-cloudshell.sh && ./prepara-cloudshell.sh && cd $HOME

```

### ¡Todo listo! ¡Comencemos la práctica!

¡Felicidades! Ahora tienes todas las herramientas y configuraciones necesarias para comenzar con el entrenamiento. Es el momento de poner en práctica tus habilidades de DevOps y explorar los diferentes escenarios y ejercicios que te presentaremos. Sigue las instrucciones y guías proporcionadas en cada sección y no dudes en experimentar y probar cosas nuevas a medida que avanzas en tu aprendizaje.

Recuerda que puedes consultar la documentación oficial de AWS, buscar en la comunidad de desarrolladores y contar con el apoyo de todos tus compañeros de Realnaut si tienes alguna pregunta o enfrentas algún desafío durante el entrenamiento.

<div style="display: flex; justify-content: space-between;">
  <a href="indice.md" style="align-self: flex-start;">Volver</a>
  <a href="codecommit.md" style="align-self: flex-end;">Continuar</a>
</div>

<div style="display: flex; justify-content: space-between;">
  <div style="text-align: left;">
    <a href="indice.md">Volver</a>
  </div>
  <div style="text-align: right;">
    <a href="siguiente.md">Continuar</a>
  </div>
</div>
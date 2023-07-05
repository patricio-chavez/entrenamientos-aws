# Prácticas Devops en Amazon Web Services (AWS)
## AWS CodeBuild

AWS CodeBuild es un servicio de compilación completamente administrado que permite compilar, probar y generar entregables de forma automática y escalable. Proporciona un entorno de compilación en la nube donde puedes ejecutar tus compilaciones sin tener que administrar la infraestructura subyacente.

Con CodeBuild, puedes configurar fácilmente proyectos basados en eventos, como cambios en el repositorio de código fuente o eventos de push en servicios de control de versiones como AWS CodeCommit o GitHub. El servicio también admite la integración con otros servicios de AWS, lo que te permite ejecutar pruebas automatizadas, generar artefactos de compilación y distribuirlos a servicios como Amazon S3 o AWS CodeDeploy.

CodeBuild utiliza contenedores Docker para proporcionar un entorno de compilación consistente y reproducible. Puedes utilizar las imágenes de Docker proporcionadas por AWS o incluso crear y utilizar tus propias imágenes personalizadas para satisfacer tus necesidades específicas de compilación.

Al aprovechar CodeBuild, puedes automatizar y acelerar tu proceso de compilación, lo que resulta en un flujo de trabajo de desarrollo más eficiente y confiable. Además, al ser un servicio administrado, te libera de la tarea de administrar y escalar la infraestructura de compilación, permitiéndote centrarte en el desarrollo de tu aplicación.

En este entrenamiento lo usaremos en combinación con Code Pipeline para construir, actualizar y destruir la infraestructura y las aplicaciones de manera automatizada.
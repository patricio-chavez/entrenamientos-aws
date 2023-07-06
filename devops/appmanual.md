# Prácticas Devops en Amazon Web Services (AWS)
# Aplicación contenerizada con despliegue manual

Ahora que hemos configurado nuestra infraestructura, es el momento de llevar a cabo un despliegue de aplicaciones sobre Kubernetes utilizando un enfoque moderno y contenerizado.

En este enfoque, en lugar de utilizar el tradicional despliegue en servidores físicos o máquinas virtuales, aprovecharemos la potencia de Kubernetes para crear un entorno altamente escalable y basado en contenedores. Kubernetes nos proporciona características avanzadas de orquestación y administración de contenedores, facilitando el despliegue y el mantenimiento de nuestra aplicación en diferentes entornos.

Si bien esta existen más objetos que nos brindan posibilidades muy ricas, con estos primeros pasos ya obtendremos beneficios como la portabilidad, la automatización y la capacidad de escalar rápidamente nuestra aplicación. 


## ¿Qué necesitamos?

Antes de comenzar, es importante tener en cuenta que en Kubernetes se siguen prácticas basadas en microservicios, en las que múltiples componentes con responsabilidades específicas trabajan de forma desacoplada. Esto nos brinda flexibilidad, escalabilidad y otros beneficios.

Por el momento, nos centraremos en los objetos y despliegues necesarios para alojar nuestra aplicación estática y servir su contenido a través de Internet.

### Crear un espacio de nombres

Para comenzar muévete al directorio $HOME e ingresa al directorio mi-repositorio

```shell
mkdir codigo && cd codigo
```
Importante: Si no lo encuentras puedes volver a clonarlo copiando el enlace de SSH provisto por Code Commit.

<div align="center">
  <img src="imagenes/clonar-mi-repositorio.png" alt="Clonar mi-repositorio">
</div>


Luego define variables

```shell
export NS_APLICACION="app-estatica"
```

Crea un espacio de nombres dedicado para nuestra aplicación estática. Esto nos permitirá aislar y organizar los recursos relacionados con nuestra aplicación.

Crea un fichero que más tarde subirás al repositorio para reutilizarlo.

```shell
cat << EOF > namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $NS_APLICACION
EOF
```


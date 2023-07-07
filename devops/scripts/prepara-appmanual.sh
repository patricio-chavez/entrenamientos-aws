#!/bin/bash

# Variables necesarias
echo "Configurando variables para desplegar la aplicación estática en forma manual..."
export ESPACIO_NOMBRES_APLICACION_MANUAL="despliegue-manual"
export SERVICIO_APLICACION_MANUAL="servicio-aplicacion-estatica"
export NOMBRE_APLICACION_MANUAL="aplicacion-estatica"
export NOMBRE_DESPLIEGUE="aplicacion-estatica"
export CONFIGMAP_APLICACION_MANUAL="aplicacion-estatica"
export NOMBRE_INGRESO="ingreso-aplicacion-estatica"
export DOMINIO=$(aws route53 list-hosted-zones --query 'HostedZones[0]'.Name | cut -d'"' -f2 | sed 's/\.$//')
export HOSTNAME_APLICACION="$NOMBRE_APLICACION_MANUAL.$DOMINIO"

# Cambiar al directorio de código
cd $HOME/mi-repositorio && mkdir codigo && cd codigo

# Crear el Namespace
echo "Creando el Namespace $ESPACIO_NOMBRES_APLICACION_MANUAL..."
cat << EOF > namespace-aplicacion-estatica.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $ESPACIO_NOMBRES_APLICACION_MANUAL
EOF
kubectl apply -f namespace-aplicacion-estatica.yaml

# Crear el Service
echo "Creando el Service $SERVICIO_APLICACION_MANUAL..."
cat << EOF > servicio-aplicacion-estatica.yaml
apiVersion: v1
kind: Service
metadata:
  name: $SERVICIO_APLICACION_MANUAL
  namespace: $ESPACIO_NOMBRES_APLICACION_MANUAL
spec:
  type: NodePort
  selector:
    app: nodejs
  ports:
    - name: http
      port: 3000
      targetPort: 3000
      nodePort: 30053
EOF
kubectl apply -f servicio-aplicacion-estatica.yaml

# Crear el ConfigMap
echo "Creando el ConfigMap $CONFIGMAP_APLICACION_MANUAL..."
cat << EOF > configmap-aplicacion-estatica.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: $CONFIGMAP_APLICACION_MANUAL
  namespace: $ESPACIO_NOMBRES_APLICACION_MANUAL
data:
  index.js: |-
    const http = require('http');
    const os = require('os');
    const hostname = os.hostname();
    let intervalId;
    const server = http.createServer((req, res) => {
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.write(\`
        <html>
          <head>
            <title>Despliegue manual</title>            
          </head>
          <body>
            <h1>Mi primera aplicación estática en Kubernetes!</h1>
            <p>Estoy corriendo sobre el POD: \${hostname}</p>
          </body>
        </html>
      \`);    
      res.end();
    });

    server.listen(3000, () => {
      console.log('Server running at http://localhost:3000/');
    });
EOF
kubectl apply -f configmap-aplicacion-estatica.yaml

# Crear el Deployment
echo "Creando el Deployment $NOMBRE_DESPLIEGUE..."
cat << EOF > despliegue-aplicacion-estatica.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $NOMBRE_DESPLIEGUE
  namespace: $ESPACIO_NOMBRES_APLICACION_MANUAL
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nodejs
  template:
    metadata:
      labels:
        app: nodejs
    spec:
      containers:
        - name: nodejs
          image: node:14-alpine
          command: ["node"]
          args: ["/app/index.js"]
          ports:
            - containerPort: 3000
          volumeMounts:
            - name: app
              mountPath: /app
          env:
            - name: RANDOM_INTERVAL
              value: "200"
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 250m
              memory: 256Mi
      volumes:
        - name: app
          configMap:
            name: $CONFIGMAP_APLICACION_MANUAL
            items:
              - key: index.js
                path: index.js
EOF
kubectl apply -f despliegue-aplicacion-estatica.yaml

# Crear el Ingress
echo "Creando el Ingress $NOMBRE_INGRESO..." 
cat << EOF > ingreso-aplicacion-estatica.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $NOMBRE_INGRESO
  namespace: $ESPACIO_NOMBRES_APLICACION_MANUAL
  annotations:  
    provider: alb
    kubernetes.io/ingress.class: alb   
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/group.name: ingress-demo
    alb.ingress.kubernetes.io/target-type: instance    
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2'    
    external-dns.alpha.kubernetes.io/hostname: $HOSTNAME_APLICACION
spec:
  rules:
    - host: $HOSTNAME_APLICACION
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: $SERVICIO_APLICACION_MANUAL
                port:
                  number: 3000
EOF
kubectl apply -f ingreso-aplicacion-estatica.yaml

# Volver al directorio original
cd $HOME/entrenamientos-aws/devops/scripts

echo "Proceso de preparación de Aplicación estática manual completado."

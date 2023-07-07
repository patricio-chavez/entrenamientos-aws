#!/bin/bash

while true; do
    echo "1. Ejecutar prepara-codecommit.sh"
    echo "2. Ejecutar hasta prepara-iam.sh"
    echo "3. Ejecutar hasta prepara-secretsmanager.sh"
    echo "4. Ejecutar hasta prepara-eks.sh"
    echo "5. Ejecutar hasta prepara-alb.sh"
    echo "6. Ejecutar hasta prepara-route53.sh"
    echo "7. Ejecutar hasta prepara-appmanual.sh"

    read -p "Ingresa el número de la opción deseada (0 para salir): " opcion

    if [ "$opcion" -eq 0 ]; then
        echo "Saliendo del script..."
        break
    fi

    if [ "$opcion" -lt 1 ] || [ "$opcion" -gt 7 ]; then
        echo "Opción inválida. Elige una opción válida del menú."
        continue
    fi

    echo "Ejecutando prepara-codecommit.sh..."
    source prepara-codecommit.sh

    if [ "$opcion" -ge 2 ]; then
        echo "Ejecutando prepara-iam.sh..."
        source prepara-iam.sh        
    fi

    if [ "$opcion" -ge 3 ]; then
        echo "Ejecutando prepara-secretsmanager.sh..."
        source prepara-secretsmanager.sh
    fi

    if [ "$opcion" -ge 4 ]; then
        echo "Ejecutando prepara-eks.sh..."
        source prepara-eks.sh
    fi

    if [ "$opcion" -ge 5 ]; then
        echo "Ejecutando prepara-alb.sh..."
        source prepara-alb.sh
    fi

    if [ "$opcion" -ge 6 ]; then
        echo "Ejecutando prepara-route53.sh..."
        source prepara-route53.sh
    fi

    if [ "$opcion" -ge 7 ]; then
        echo "Ejecutando prepara-appmanual.sh..."
        source prepara-appmanual.sh
    fi

    echo
done

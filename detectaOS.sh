#!/bin/bash

# Asegurarse de que se proporciona una dirección IP como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <direccion_ip>"
    exit 1
fi

# Ejecutar el comando ping
respuesta=$(ping -c 1 $1)

# Extraer el valor TTL de la respuesta
ttl=$(echo "$respuesta" | grep -o 'ttl=[0-9]*' | grep -o '[0-9]*')

if [ -z "$ttl" ]; then
    echo "No se pudo obtener el valor TTL. Asegúrate de que la dirección IP es accesible."
    exit 1
fi

# Determinar el sistema operativo basado en el valor TTL
if [ "$ttl" -le 64 ]; then
    echo "Nos enfrentamos a una máquina Linux/Unix (TTL=$ttl)."
elif [ "$ttl" -le 128 ]; then
    echo "Nos enfrentamos a una máquina Windows (TTL=$ttl)."
else
    echo "El valor TTL ($ttl) no corresponde a los rangos comunes de Linux/Unix o Windows."
fi

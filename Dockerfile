# Usar una versión específica de Alpine para consistencia
FROM alpine:3.18

# Establecer la variable de entorno para la versión de ShellSpec
ENV SHELLSPEC_VERSION=0.28.1

# Actualizar repositorios de paquetes e instalar dependencias necesarias
RUN apk update && \
    apk add --no-cache make bash curl git postgresql-client dos2unix tar findutils

# Descargar y extraer ShellSpec 0.28.1
RUN curl -fsSL https://github.com/shellspec/shellspec/archive/refs/tags/${SHELLSPEC_VERSION}.tar.gz | tar -xz -C /opt && \
    cd /opt/shellspec-${SHELLSPEC_VERSION} && \
    make install

# Asegurar que ShellSpec esté en el PATH
ENV PATH="/usr/local/bin:${PATH}"

# Verificar la instalación de ShellSpec
RUN shellspec --version

# Crear el directorio /app
RUN mkdir -p /app

# Copiar todos los archivos al contenedor
COPY . /app

# Convertir recursivamente los saltos de línea de los archivos de script a formato Unix
RUN find /app -type f \( -name "*.sh" -o -name "*.shellspec" \) -exec dos2unix {} +

# Establecer permisos ejecutables para los scripts si es necesario
RUN chmod +x /app/db_config.sh

# Establecer el directorio de trabajo
WORKDIR /app

# Usar bash como shell por defecto
CMD ["/bin/bash"]


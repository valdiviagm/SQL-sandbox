# Use a specific Alpine version for consistency
FROM alpine:3.18

# Set environment variable for ShellSpec version
ENV SHELLSPEC_VERSION=0.28.1

# Update package repositories and install required packages
RUN apk update && \
    apk add --no-cache make bash curl git postgresql-client dos2unix tar

# Download and extract ShellSpec 0.28.1
RUN curl -fsSL https://github.com/shellspec/shellspec/archive/refs/tags/${SHELLSPEC_VERSION}.tar.gz | tar -xz -C /opt && \
    cd /opt/shellspec-${SHELLSPEC_VERSION} && \
    make install

# Ensure ShellSpec is in PATH
ENV PATH="/usr/local/bin:${PATH}"

# Verify ShellSpec installation
RUN shellspec --version

# Create the /app directory
RUN mkdir -p /app

# Set the working directory
WORKDIR /app

# Use bash as the default shell
CMD ["/bin/bash"]


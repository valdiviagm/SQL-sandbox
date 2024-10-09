# Use a specific Alpine version for consistency
FROM alpine:3.18

# Update package repositories and install required packages
RUN apk update && \
    apk add --no-cache make bash curl git postgresql-client dos2unix

# Install shellspec
RUN echo 'y' | curl -fsSL https://git.io/shellspec | sh -s -- --yes

# Convert line endings of db_config.sh and set execution permissions
RUN dos2unix /app/db_config.sh && \
    chmod +x /app/db_config.sh

# Set PATH to include shellspec binaries
ENV PATH="/root/.local/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Use bash as the default shell
CMD ["/bin/bash"]


FROM alpine:latest

RUN apk add --no-cache make bash curl git postgresql-client dos2unix

COPY db_config.sh /app/db_config.sh

RUN dos2unix /app/db_config.sh && \
    chmod +x /app/db_config.sh && \
    echo 'y' | curl -fsSL https://git.io/shellspec | sh -s -- --yes

ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /app

CMD ["/bin/bash"]


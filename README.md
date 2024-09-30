# Project Setup and Usage Guide

This document provides an overview of how to use the `Makefile` and interact with the PostgreSQL database via JDBC in your development and testing environment.

## Prerequisites
- **Docker**: Ensure Docker is installed on your machine.
- **Make**: The `make` command is required to run the tasks.
- **ShellSpec**: Used for testing.

### Makefile Usage

#### 1. `make setup`
This command sets up the database and runs the setup script defined in `db_config.sh`:

```bash
make setup
```

This runs:
- Starts the PostgreSQL database in Docker.
- Executes the `db_config.sh setup` script to configure the database.

#### 2. `make test`
This command runs the tests using ShellSpec:

```bash
make test
```

This runs:
- Starts the PostgreSQL container.
- Runs the `shellspec` tests.
- Stops and tears down the PostgreSQL container after testing.

#### 3. `make teardown`
This command cleans up the environment by stopping the PostgreSQL container and running the `cleanup` script in `db_config.sh`:

```bash
make teardown
```

This runs:
- Stops the PostgreSQL container.
- Runs `db_config.sh cleanup` to clean up the database.

### No Password Authentication (`POSTGRES_HOST_AUTH_METHOD=trust`)

In the `docker-compose.yml` file, the environment variable `POSTGRES_HOST_AUTH_METHOD=trust` is used. This means PostgreSQL is configured to **trust** local connections and does not require a password for authentication.

You can connect to the PostgreSQL database without specifying a password when using `psql`, JDBC, or any other database client.

#### Example of Connecting with `psql`:
```bash
psql -h localhost -p 5432 -U postgres -d test_db
```

### Example of JDBC Connection

If you are working with JDBC, you can use the following connection string to interact with the PostgreSQL database running in Docker:

```java
String jdbcUrl = "jdbc:postgresql://localhost:5432/test_db";
String username = "postgres";

try (Connection connection = DriverManager.getConnection(jdbcUrl, username, null)) {
    // Perform database operations here
    System.out.println("Connected to the database successfully!");
} catch (SQLException e) {
    e.printStackTrace();
}
```

- **JDBC URL**: `jdbc:postgresql://localhost:5432/test_db` connects to the PostgreSQL database running in Docker.
- **Username**: `postgres` is the default user defined in `docker-compose.yml`.
- **No Password**: Since `POSTGRES_HOST_AUTH_METHOD=trust` is enabled, no password is required.

### Docker Compose Overview

Below is the `docker-compose.yml` configuration for the PostgreSQL service:

```yaml
version: '3.8'

services:
  db:
    image: postgres:14
    container_name: my-postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_DB: test_db
      POSTGRES_HOST_AUTH_METHOD: trust
    ports:
      - "5432:5432"
    volumes:
      - ./db_config.sh:/usr/local/bin/db_config.sh
      - postgres_data:/var/lib/postgresql/data
    networks:
      - postgres-network

volumes:
  postgres_data:

networks:
  postgres-network:
    driver: bridge
```

### Running the Project

1. **Setup the Database**: 
   Run the following command to start the database and set it up:
   ```bash
   make setup
   ```

2. **Run Tests**:
   Run the tests using:
   ```bash
   make test
   ```

3. **Clean up the Environment**:
   Use the following command to tear down the environment:
   ```bash
   make teardown
   ```


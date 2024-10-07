# Project Setup and Usage Guide

This guide helps you set up and run the project using Docker. All required tools, including `make`, `shellspec`, and `psql`, are installed and run inside a Docker container. You only need Docker installed on your local machine.

## Prerequisites

- **Docker**: Ensure Docker is installed on your machine.

### Installing Docker

For both Windows and macOS, you need to install Docker Desktop.

- [Download Docker Desktop](https:g/www.docker.com/products/docker-desktop/) and choose the version suitable for your operating system (Windows or macOS).
- Follow the installation instructions specific to your platform.
- Once Docker Desktop is installed and running, you're ready to proceed.

## Getting Started

1. **Start the Sandbox Container**:

   Inside the project directory, run the following command to enter the container:
   `docker-compose run --rm sandbox`

   This command opens an interactive shell inside the Docker container, where all necessary tools are available.


- **Run Tests**:
  Run the tests using `shellspec`:

  `make test`

If tests are not passed succesfully, a misconfiguration occured and reaching for help is advised.

## Running commands that you can run inside the container

Once you're inside the `sandbox` container, you can use the following `make` commands to manage the project:

- **Setup the Database**:
  Set up the database and configure the environment:
  `make setup`

- **Accessing the Database**:
To enter the database interactive environment and execute SQL commands, you can use the following `psql` command from inside the container:

`psql -h db -p 5432 -U postgres -d test_db`

This connects to the PostgreSQL database running inside the `db` container.

( `exit` command exits database interactive environment )

- **Teardown the Environment**:
  Clean up the database and stop the environment:

  `make teardown`


## Note for SQL Learners

If you're new to SQL, think of this environment as your playground. You don’t need to worry about breaking anything — you can always start over by running `make teardown` to clean up everything and `make setup` to reset the database. This is a safe space for you to experiment, try out queries, and learn without fear. No matter what happens, you can always start fresh, so don't hesitate to play around and explore SQL freely.




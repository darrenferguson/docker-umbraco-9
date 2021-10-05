# Dockerfile for Umbraco 9

Sets up a container with an empty Umbraco 9 installed.

*This is a development* environment - and no way suitable for production.

This runs with linux containers.

## Running

- docker build .
- docker compose up -d

Wait for SQL server and Umbraco to start

Point your browser to localhost - you should be prompted to setup and admin username and password by Umbraco.

## What it does

### Dockerfile

- Install SQL Server 
- Install .NET 5 SDK
- New Umbraco (dotnet new umbraco)

### On startup

- Wait for SQL server to start
- Create an empty database with sqlcmd
- Setup the Umbraco connection string
- Start Umbraco (dotnet run)

## Potential issues

You may need to modify the ports if you have anything on 80, 443 or 8081 locally.

I mapped SQL server to local 8081 as I have a SQL server already on 1433

## Feedback

Please feel free to open an issue

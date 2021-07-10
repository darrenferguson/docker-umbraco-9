#!/bin/bash
/opt/mssql/bin/sqlservr &
chmod +x /app/wait-for-it.sh

/app/wait-for-it.sh localhost:1433 -t 90

sqlcmd -S "127.0.0.1,1433" -Q "CREATE DATABASE umbraco" -U "sa" -P "$SA_PASSWORD"

sed -i.bak 's/umbracoDbDSN\": \"/umbracoDbDSN\": \"server=localhost;database=umbraco;user id=sa;password='"$SA_PASSWORD"'/g' /app/Umb/appsettings.json

dotnet run --project /app/Umb/Umb.csproj --urls "http://0.0.0.0:80;https://0.0.0.0:443"
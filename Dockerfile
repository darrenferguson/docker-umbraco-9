# syntax=docker/dockerfile:1

FROM buildpack-deps:stretch
ENV ACCEPT_EULA y
ENV SA_PASSWORD rJkxK6UB4DXzGdYk38v5
COPY ./app /app
WORKDIR /app
EXPOSE 80
EXPOSE 443
EXPOSE 8081
ENV PATH="/opt/mssql/bin:/opt/mssql-tools/bin:${PATH}"

RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list)"
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"
RUN apt-get update
RUN apt-get install -y mssql-server
RUN apt-get install -y mssql-tools 
RUN wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y dotnet-sdk-5.0
RUN dotnet new -i Umbraco.Templates
RUN dotnet new umbraco -n Umb
ENTRYPOINT /app/startup.sh

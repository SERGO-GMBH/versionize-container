FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN useradd -u 1001 versionize

RUN mkdir /app
RUN mkdir /mount/
RUN apt-get install git
RUN dotnet tool install Versionize --tool-path /app

USER appuser

WORKDIR /mount/

ENTRYPOINT [ "/app/versionize" ]
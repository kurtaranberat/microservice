# escape=`
FROM mcr.microsoft.com/dotnet/sdk:6.0-windowsservercore-ltsc2019 AS build-env
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:/app

# Copy all source code
COPY src/ ./src/

# Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; `
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Node.js and other dependencies using Chocolatey
RUN choco install -y nodejs-lts python3 golang redis-64

# Add tools to PATH
RUN $env:PATH = 'C:\Python39;C:\Python39\Scripts;C:\Program Files\Go\bin;C:\Program Files\Redis;' + $env:PATH

# Build Frontend
WORKDIR C:/app/src/frontend
RUN npm install
RUN npm run build

# Build Cart Service
WORKDIR C:/app/src/cartservice/src
RUN dotnet restore
RUN dotnet build

# Build other services
WORKDIR C:/app/src/productcatalogservice
RUN go build -o C:/app/productcatalogservice.exe

WORKDIR C:/app/src/currencyservice
RUN npm install

WORKDIR C:/app/src/paymentservice
RUN npm install

WORKDIR C:/app/src/shippingservice
RUN go build -o C:/app/shippingservice.exe

WORKDIR C:/app/src/emailservice
RUN pip install -r requirements.txt

WORKDIR C:/app/src/recommendationservice
RUN pip install -r requirements.txt

WORKDIR C:/app/src/adservice
RUN ./gradlew build

# Create start script
WORKDIR C:/app
COPY start.ps1 .

EXPOSE 8080 9555 3550 7070 50051 7000 8080 5050

CMD ["powershell", "-File", "C:/app/start.ps1"]

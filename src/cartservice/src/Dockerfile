
FROM --platform=amd64 mcr.microsoft.com/dotnet/sdk:8.0.302-noble@sha256:bd836d1c4a19860ee61d1202b82561f0c750edb7a635443cb001042b71d79569 as builder
ENV DOTNET_EnableWriteXorExecute=0
WORKDIR /app
COPY cartservice.csproj .
RUN dotnet restore cartservice.csproj \
    -r linux-x64
COPY . .
RUN dotnet publish cartservice.csproj \
    -p:PublishSingleFile=true \
    -r linux-x64 \
    --self-contained true \
    -p:PublishTrimmed=true \
    -p:TrimMode=full \
    -c release \
    -o /cartservice

# https://mcr.microsoft.com/product/dotnet/runtime-deps
FROM --platform=amd64 mcr.microsoft.com/dotnet/runtime-deps:8.0.6-noble-chiseled@sha256:55d6e41f2e7687c597daa4fdca997b07beb3e23b6283729e19bb8ceb272def1a

WORKDIR /app
COPY --from=builder /cartservice .
EXPOSE 7070
ENV DOTNET_EnableDiagnostics=0 \
    ASPNETCORE_HTTP_PORTS=7070
USER 1000
ENTRYPOINT ["/app/cartservice"]




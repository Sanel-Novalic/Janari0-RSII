FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7158
ENV ASPNETCORE_URLS=HTTPS://+:7158

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
RUN dotnet dev-certs https
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "Janari0/Janari0.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /root/.dotnet/corefx/cryptography/x509stores/my/* /root/.dotnet/corefx/cryptography/x509stores/my/
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Janari0.dll"] 
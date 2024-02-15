FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY ["Janari0.EmailProvider/Janari0.EmailProvider.csproj", "Janari0.EmailProvider/"]
RUN dotnet restore "Janari0.EmailProvider/Janari0.EmailProvider.csproj"

COPY ["./Janari0.Model/Janari0.Model.csproj", "./Janari0.Model/"]

COPY . .
WORKDIR "/src/Janari0.EmailProvider"
RUN dotnet build "Janari0.EmailProvider.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Janari0.EmailProvider.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Janari0.EmailProvider.dll"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1
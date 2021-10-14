#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

# Get base SDK Image from Microsoft
FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
# Copy the project files and restore any dependencies (via NUGET)
COPY ["WebApplicationTest/WebApplicationTest.csproj", "WebApplicationTest/"]
RUN dotnet restore "WebApplicationTest/WebApplicationTest.csproj"

# Copy the project files and build our release
COPY . .
WORKDIR "/src/WebApplicationTest"
RUN dotnet build "WebApplicationTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApplicationTest.csproj" -c Release -o /app/publish

# Generate Runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplicationTest.dll"]
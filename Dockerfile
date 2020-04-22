
# PULL DOTNET SDK DEPENDENCIES
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

# CREATE NEW FOLDER TO RUN OUR CMDS
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy all files
# publish app and output to out folder
COPY . ./
RUN dotnet publish -c Release -o out


# final stage/image (we only need runtime to run our app not the full sdk)
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet","./dockerapp.dll"]


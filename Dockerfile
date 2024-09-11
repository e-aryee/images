FROM mcr.microsoft.com/windows/servercore:ltsc2019
ARG INSTALL_JDK=true

# Download the latest self-hosted integration runtime installer into the SHIR folder
COPY SHIR C:/Users/ea_admin/Container/SHIR/

RUN ["powershell", "C:/Users/ea_admin/Container/SHIR/build.ps1"]

ENTRYPOINT ["powershell", "C:/Users/ea_admin/Container/SHIR/setup.ps1"]

ENV SHIR_WINDOWS_CONTAINER_ENV True

HEALTHCHECK --start-period=120s CMD ["powershell", "C:/Users/ea_admin/Container/SHIR/health-check.ps1"]

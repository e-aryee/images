# Use a Windows Server Core 2016 base image
FROM mcr.microsoft.com/windows/servercore:ltsc2016

# Install Chocolatey package manager
RUN powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Install Python 3.8.8
RUN choco install python --version=3.8.8 -y

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install Selenium 4.17.2
RUN pip install selenium==4.17.2

# Install a web driver (e.g., ChromeDriver for Chrome)
RUN choco install -y chromedriver

# Create a directory for your Selenium scripts
WORKDIR /selenium


# Set the working directory
WORKDIR /app

# Copy the application files to the container (assumes a main.py file)
COPY . /app

# Default command to run the application
CMD ["python", "main.py"]

# Set the entry point for the container
CMD ["powershell.exe", "-NoProfile", "-Command", "Start-Sleep -Seconds 3650"]  # Keeps the container running
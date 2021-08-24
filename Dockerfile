FROM jetbrains/teamcity-agent:2021.1.2-linux
WORKDIR /tmp
USER root
RUN apt-get update
RUN apt-get install -y wget apt-transport-https software-properties-common
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y powershell gss-ntlmssp
RUN cp -P /usr/bin/pwsh /usr/bin/powershell
RUN pwsh -Command 'Install-Module -Name PSWSMan -Force'
RUN pwsh -Command 'Install-WSMan'
USER buildagent

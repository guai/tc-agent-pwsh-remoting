## TeamCity agent Docker image with PowerShell Remoting added

With this image you can run commands like this:
```
$password = ConvertTo-SecureString "password" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PsCredential("Administrator", $password)
$scriptBlock = { Restart-Service -Name MyService }
Invoke-Command -computername "example.org" -Credential $credentials -scriptblock $scriptBlock
```
in your TeamCity builds.
* Build it with `docker build . -t jetbrains/teamcity-agent:with-pwsh-remoting`
* Run them inside the Docker:
```
docker run -d --name teamcity-server -v <path-to>\teamcity\datadir\:/data/teamcity_server/datadir -p 8111:8111 jetbrains/teamcity-server
docker run -d --name teamcity-agent -e "SERVER_URL=http://teamcity-server:8111" jetbrains/teamcity-agent:with-pwsh-remoting
docker network create teamcity-network
docker network connect teamcity-network teamcity-server
docker network connect teamcity-network teamcity-agent
```
PS: you may build the image `FROM jetbrains/teamcity-agent:2021.1.2-linux-sudo` if you need `sudo`

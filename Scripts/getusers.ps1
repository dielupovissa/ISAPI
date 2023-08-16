$cred = Get-Credential admin

$ipAddress = "10.255.6.210"

$url = "http://$ipAddress/ISAPI/Security/users/2"

$Response = Invoke-RestMethod -Method Get -Uri $url -Credential $cred -Verbose 

$Response

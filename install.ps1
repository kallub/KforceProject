#!/bin/bash

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-WindowsFeature Web-Server
New-Item -ItemType Directory -Name 'images' -Path 'C:\inetpub\wwwroot\catswebsite'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/kallub/Project/main/config/index.html -OutFile C:\inetpub\wwwroot\catswebsite\index.html
Invoke-WebRequest -Uri https://raw.githubusercontent.com/kallub/Project/main/config/cats.jpg -OutFile C:\inetpub\wwwroot\catswebsite\images\cats.jpg
$cert=New-SelfSignedCertificate -DnsName cats.internal.local -CertStoreLocation cert:\LocalMachine/My
New-IISSite -Name "TestSite2" -PhysicalPath "$env:systemdrive\inetpub\wwwroot\catswebsite" -BindingInformation "*:443:" -CertificateThumbPrint $cert.Thumbprint -CertStoreLocation "Cert:\LocalMachine\My" -Protocol https -Force

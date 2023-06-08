####################################################################
#SCRIPT WEER WERKEND GEMAAKT DOOR DE POWERSHELL NOOB RIAAN##########
####################################################################
#$wshell = New-Object -ComObject Wscript.Shell
#$Output = $wshell.Popup("Het kan zijn dat het de eerste keer mislukt door de Powershell module. Run dan het script opnieuw.")
####################################################################
#Benodigde MODULES INSTALLEREN######################################
####################################################################
Import-Module PowerShellGet
#Find-Module Posh-SSH
#Find-Module Posh-SSH | Install-Module -Force -Scope CurrentUser
#Get-Command -Module Posh-SSH
####################################################################
#VARIABELEN BEPALEN#################################################
####################################################################
$servername = Read-Host -Prompt 'IP van AP'
$credential = New-Object System.Management.Automation.PSCredential ('ubnt', $(ConvertTo-SecureString 'ubnt' -AsPlainText -Force))
$InformURL = "http://wifi.booneit.nl:8080/inform"
####################################################################
#FUNCTIONELE GEDEELTE###############################################
####################################################################
New-SSHSession -ComputerName $servername -Credential $credential -Force
  $session = Get-SSHSession -Index 0
  $stream = $session.Session.CreateShellStream("dumb", 0, 0, 0, 0, 1000)
  $stream.Write("set-inform $($InformURL)`n")
  $stream.Write("set-inform $($InformURL)`n")
  Write-Host "Chose adopt in UNIFI controller and press enter"
  pause
  $stream.Write("set-inform $($InformURL)`n")
  $stream.Write("set-inform $($InformURL)`n")
  sleep 3
  $stream.Write("set-inform $($InformURL)`n")
  $stream.Write("set-inform $($InformURL)`n")
Remove-SSHSession 0
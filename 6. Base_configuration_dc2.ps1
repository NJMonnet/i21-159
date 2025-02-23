# Configuration de base du serveur
$ServerName = "AD-DC2-core"
$NomDuDisque = "HDD_SYS"
$InterfaceReseau = (Get-NetConnectionProfile).InterfaceIndex
$IPAddress = "192.168.1.49"
$Gateway = "192.168.1.1"
$DnsPrimaire = "192.168.1.48"
$DnsSecondaire = "127.0.0.1"

# Modification du Hostname
Rename-Computer -NewName $ServerName

# Modification du nom du disque "C"
 $volume = Get-Volume -DriveLetter "C"
 $volume | Set-Volume -NewFileSystemLabel $NomDuDisque

# Modification de l'adresse IP sur l'interface reseau active
# https://www.technig.com/configure-ip-address-using-powershell/
New-NetIPAddress -InterfaceIndex $InterfaceReseau -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex $InterfaceReseau -ServerAddresses $DnsPrimaire, $DnsSecondaire


# Mise en place du RDP
# https://lazywinadmin.com/2014/04/powershell-getset-network-level.html

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

# Getting the NLA information
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $ServerName -Filter "TerminalName='RDP-tcp'").UserAuthenticationRequired

# Setting the NLA information to Enabled
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -ComputerName $ServerName -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(1)


Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -Value 1


Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools

#https://woshub.com/add-domain-controller-existing-ad-domain/
Add-Computer -DomainName "ICT159.private" -OUPath "OU=Domain Controllers,DC=ICT159,DC=private" 

#https://woshub.com/add-domain-controller-existing-ad-domain/
Import-Module ADDSDeployment
Install-ADDSDomainController `
    -NoGlobalCatalog:$false `
    -CreateDnsDelegation:$false `
    -CriticalReplicationOnly:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainName "ICT159.private" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SiteName "Default-First-Site-Name" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
    -Credential (Get-Credential)

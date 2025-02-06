# Configuration de base du serveur
$ServerName = "AD-DC1"
$NomDuDisque = "HDD_SYS"
$InterfaceReseau = (Get-NetConnectionProfile).InterfaceIndex
$IPAddress = "10.0.2.10"
$Gateway = "10.0.2.1"
$DnsPrimaire = "127.0.0.1"
$DnsSecondaire = "9.9.9.9"

# Modification du Hostname
Rename-Computer -NewName $ServerName

# Modification du nom du disque "C"
Rename-Volume -DriveLetter C -NewLabel $NomDuDisque

# Modification de l'adresse IP sur l'interface reseau active
# https://www.technig.com/configure-ip-address-using-powershell/
New-NetIPAddress -InterfaceIndex $InterfaceReseau -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceIndex $InterfaceReseau -ServerAddresses $DnsPrimaire, $DnsSecondaire


## Installation et configuration du service DNS
# https://learn.microsoft.com/en-us/windows-server/networking/dns/quickstart-install-configure-dns-server?tabs=powershell

Install-WindowsFeature -Name DNS

# Configuration de l'interface
$IPAddress = "10.0.2.10"

$DnsServerSettings = Get-DnsServerSetting -ALL
$DnsServerSettings.ListeningIpAddress = @($IPAddress)
Set-DNSServerSetting $DnsServerSettings

# Configuration de la redirection des requêtes
$DnsServer1 = "9.9.9.9"
$DnsServer2 = "1.1.1.1"

Set-DnsServerForwarder -IPAddress $DnsServer1, $DnsServer2

# Installation du service AD avec niveau fonctionnel 2008
# https://www.technig.com/install-active-directory-on-windows-server-2022-using-powershell/


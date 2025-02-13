# Configuration de base du serveur
$ServerName = "AD-DC1"
$NomDuDisque = "HDD_SYS"
$InterfaceReseau = (Get-NetConnectionProfile).InterfaceIndex
$IPAddress = "192.168.1.48"
$Gateway = "192.168.1.1"
$DnsPrimaire = "192.168.1.49"
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

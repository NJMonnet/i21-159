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

## Installation et configuration du service DNS
# https://learn.microsoft.com/en-us/windows-server/networking/dns/quickstart-install-configure-dns-server?tabs=powershell

Install-WindowsFeature -Name DNS

# Configuration de l'interface
$IPAddress = "192.168.1.48"

$DnsServerSettings = Get-DnsServerSetting -ALL
$DnsServerSettings.ListeningIpAddress = @($IPAddress)
Set-DNSServerSetting $DnsServerSettings

# Configuration de la redirection des requêtes
$DnsServer1 = "9.9.9.9"
$DnsServer2 = "1.1.1.1"

Set-DnsServerForwarder -IPAddress $DnsServer1, $DnsServer2

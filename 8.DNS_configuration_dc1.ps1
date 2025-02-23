$InterfaceReseau = (Get-NetConnectionProfile).InterfaceIndex
$DnsPrimaire = "192.168.1.49"
$DnsSecondaire = "127.0.0.1"

Set-DnsServerPrimaryZone -Name "ICT159.private" -ReplicationScope "Forest"

Set-DnsClientServerAddress -InterfaceIndex $InterfaceReseau -ServerAddresses $DnsPrimaire, $DnsSecondaire
# Installation du service AD DS
$NetBIOS = "ICT159"
$DomainName = "ICT159-private"

Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $DomainName -DomainNetbiosName $NetBios -ForestMode "Win2008R2" -DomainMode "Win2008R2" -InstallDNS:$true -InstallDNS:$False
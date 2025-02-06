# Installation du service AD DS
$NetBIOS = "ICT159"
$DomainName = "ICT159-private"
$SafeModePassword = ConvertTo-SecureString -AsPlainText "Welcome2024" -Force

Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $DomainName 
                    -DomainNetbiosName $NetBios 
                    -ForestMode "Win2008R2" 
                    -DomainMode "Win2008R2" 
                    -InstallDNS:$true
                    -SafeModeAdministratorPassword $SafeModePassword
# Installation du service AD DS
# https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-#BKMK_PS
$NetBIOS = "ICT159"
$DomainName = "ICT159.private"
$SafeModePassword = ConvertTo-SecureString -AsPlainText "Welcome2024" -Force

Install-WindowsFeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $DomainName 
                   -DomainNetbiosName $NetBios 
                   -ForestMode "Win2008R2" 
                   -DomainMode "Win2008R2" 
                   -SafeModeAdministratorPassword $SafeModePassword
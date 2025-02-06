# Mise à niveau de l'AD vers 2016
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-adforestmode?view=windowsserver2025-ps
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/set-addomainmode?view=windowsserver2025-ps

Set-ADForestMode -Identity "ICT159.private" -ForestMode Windows2016Forest
Set-ADDomainMode -Identity "ICT159.private" -DomainMode Windows2016Domain

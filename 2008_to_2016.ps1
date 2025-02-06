# Mise à niveau de l'AD vers 2016

Set-ADForestMode -Identity "ICT159.private" -ForestMode Windows2016Forest
Set-ADDomainMode -Identity "ICT159.private" -DomainMode Windows2016Domain

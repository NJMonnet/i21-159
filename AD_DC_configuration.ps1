# Création des OUs
$Domain = "ICT159.private"
$OUAdmin = "OU=Administration,DC=ICT159,DC=private"
$OUProduction = "OU=Production,DC=ICT159,DC=private"
$OUPath = "DC=ICT159,DC=private"

New-ADOrganizationalUnit -Name "Administration" -Path "DC=ICT159,DC=private" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Production" -Path "DC=ICT159,DC=private" -ProtectedFromAccidentalDeletion $false

# Création des utilisateurs
$UserPassword = ConvertTo-SecureString "Welcome2024" -AsPlainText -Force

$Users = @(
    @{Name="Alain DUBOIX"; UserName="alainduboix"; OU=$OUAdmin},
    @{Name="Alice DUBOIX"; UserName="aliceduboix"; OU=$OUAdmin},
    @{Name="Pierre RICHARD"; UserName="prichard"; OU=$OUProduction},
    @{Name="Paule JACCARD"; UserName="pjaccard"; OU=$OUProduction}
)
foreach ($User in $Users) {
    New-ADUser -Name $User.Name `
               -SamAccountName $User.UserName `
               -UserPrincipalName "$($User.UserName)@$Domain" `
               -Path $User.OU `
               -AccountPassword $UserPassword `
               -Enabled $true `
               -ChangePasswordAtLogon $true `
               -GivenName ($User.Name -split " ")[0] `
               -Surname ($User.Name -split " ")[1]
}

Get-ADUser -Filter * -SearchBase "DC=ICT159,DC=private" | Select Name, SamAccountName, DistinguishedName

# Création des groupes de sécurité
New-ADGroup -Name "Direction" -GroupScope Global -GroupCategory Security -Path $OUPath
New-ADGroup -Name "Secrétaires" -GroupScope Global -GroupCategory Security -Path $OUPath

# Ajout des utilisateurs dans le bon groupe
Add-ADGroupMember -Identity "Direction" -Members "alainduboix"
Add-ADGroupMember -Identity "Secrétaires" -Members "aliceduboix", "pjaccard"

# Activation de la corbeille AD
# Importation du module Active Directory
Import-Module ActiveDirectory

# Activation de la corbeille AD
Enable-ADOptionalFeature -Identity 'Recycle Bin Feature' `
                         -Scope ForestOrConfigurationSet `
                         -Target 'ICT159.private' `
                         -Confirm:$false
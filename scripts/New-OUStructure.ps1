# Creates the complete Organizational Unit hierarchy under lab.local
# in a single execution. Run on DC01 after domain promotion.

$domain = "DC=lab,DC=local"

New-ADOrganizationalUnit -Name "Lab" -Path $domain
New-ADOrganizationalUnit -Name "Users" -Path "OU=Lab,DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Computers" -Path "OU=Lab,DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Servers" -Path "OU=Lab,DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Groups" -Path "OU=Lab,DC=lab,DC=local"

New-ADOrganizationalUnit -Name "IT" -Path "OU=Users,OU=Lab,DC=lab,DC=local"
New-ADOrganizationalUnit -Name "Finance" -Path "OU=Users,OU=Lab,DC=lab,DC=local"
New-ADOrganizationalUnit -Name "HR" -Path "OU=Users,OU=Lab,DC=lab,DC=local"

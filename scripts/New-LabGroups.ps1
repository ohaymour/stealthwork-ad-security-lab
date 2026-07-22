# Creates all four security groups in the Groups OU.
# Run on DC01 after the OU structure is in place.

New-ADGroup -Name "GRP_IT" -GroupScope Global -GroupCategory Security -Path "OU=Groups,OU=Lab,DC=lab,DC=local"
New-ADGroup -Name "GRP_Finance" -GroupScope Global -GroupCategory Security -Path "OU=Groups,OU=Lab,DC=lab,DC=local"
New-ADGroup -Name "GRP_HR" -GroupScope Global -GroupCategory Security -Path "OU=Groups,OU=Lab,DC=lab,DC=local"
New-ADGroup -Name "GRP_Admins" -GroupScope Global -GroupCategory Security -Path "OU=Groups,OU=Lab,DC=lab,DC=local"

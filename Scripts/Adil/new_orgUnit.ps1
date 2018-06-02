# example 
# PS C:\Users\Администратор\desktop> .\1_create_new_OrganizationUnit.ps1

Import-Module ActiveDirectory

$name_dc = "polykek"
$name_dc_com = "com"

New-ADOrganizationalUnit -Name Others -Path "dc=$name_dc,dc=$name_dc_com"

New-ADOrganizationalUnit -Name Teachers -Path "dc=$name_dc,dc=$name_dc_com"

New-ADOrganizationalUnit -Name Administration -Path "dc=$name_dc,dc=$name_dc_com"

New-ADOrganizationalUnit -Name Students -Path "dc=$name_dc,dc=$name_dc_com"

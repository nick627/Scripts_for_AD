﻿# example 
# PS C:\Users\Администратор\desktop> .\2_create_new_group.ps1

# -groupScope Global - (Action area) Global group
# -ManagedBy "GeneralAdmins" - Контролировать работу администраторов нижних уровней.

Import-Module ActiveDirectory

$name_ou = "Administration"
$name_dc = "polykek"
$name_dc_com = "com"

New-ADGroup -Name "GeneralAdmins" -groupScope Global -Path "ou=$name_ou,dc=$name_dc,dc=$name_dc_com"

New-ADGroup -Name "AccountManagers" -groupScope Global -ManagedBy "GeneralAdmins" -Path "ou=$name_ou,dc=$name_dc,dc=$name_dc_com"

New-ADGroup -Name "HelpDesk" -groupScope Global -ManagedBy "GeneralAdmins" -Path "ou=$name_ou,dc=$name_dc,dc=$name_dc_com"

New-ADGroup -Name "ResourceAdmins" -groupScope Global -ManagedBy "GeneralAdmins" -Path "ou=$name_ou,dc=$name_dc,dc=$name_dc_com"

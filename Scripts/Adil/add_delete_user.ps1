﻿# example
# PS C:\Users\Администратор\desktop> .\add_delete_user.ps1 -name Student2 -command add
# PS C:\Users\Администратор\desktop> .\add_delete_user.ps1 -name Student2 -command del

param(
    [string]$name = $(throw "Enter name"),
    [string]$password = "Qwerty123",
    [string]$unit = "Students",
    [string]$command = $(throw "add or del"),
    [string]$groupname = ""
)

import-module activedirectory

switch($command)
{
	add
	{
		if ($unit)
		{
			
			# -AsPlainText Указывает строку простого текста для преобразования в защищенную строку. Командлеты защищенных строк помогают защитить конфиденциальный текст.
			# -Force - Подтверждает, что вы понимаете последствия использования параметра AsPlainText и все еще хотите его использовать.
			$secpass = $password | ConvertTo-SecureString -AsPlainText -Force

			# делим строку на подстроки, разделенные '/' 
			$outmp = $unit -split '/'
			# строим путь в подраздел 
			$outmp | ForEach-Object {$path = "OU=$_," + $path}
			# в конце добавляем домен
			$path +=  "DC=polykek, DC=com"

			New-ADUser `
				-Name $name `
				-Path $path `
				-SamAccountName $name `
				-DisplayName $name `
				-AccountPassword $secpass `
				-ChangePasswordAtLogon $false `
				-Enabled $true `
				-HomeDrive "Z:" `
				-HomeDirectory "\\WIN-LUA733BF4BA\SharedFolder\$name"`
				-scriptPath "script.bat"

			mkdir "C:\SharedFolder\$name"

			# iCACLS отображает или изменяет списки управления доступом (Access Control Lists (ACLs))
			# /grant[:r] SID:permission — предоставление указанных прав доступа пользователя
			# Права наследования могут предшествовать любой форме и применяются только к каталогам:
				# (OI) - наследование объектами
				# (CI) - наследование контейнерами
			# M[edium]: средний
			# Для данного пользователся даем доступ к его папке с правами наследоваия и "средний" доступ
			icacls "C:\SharedFolder\$name" /grant "$($name):(OI)(CI)M"

			if ($groupname)
			{
				Add-ADGroupMember -Identity $groupname -Members $name #$user
			}
		}
	}
	del
	{
		Remove-ADUser -Identity $name
		Remove-Item "C:\SharedFolder\$name"
	}
}

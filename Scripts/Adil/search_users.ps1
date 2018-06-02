# example
# PS C:\Users\Администратор\desktop> .\6_search_users.ps1.ps1 -number 30
# PS C:\Users\Администратор\desktop> .\6_search_users.ps1.ps1 90
# PS C:\Users\Администратор\desktop> .\6_search_users.ps1.ps1

# Скрипт ищет во всем домене пользователей с истекающим сроком действия пароля
# Входной параметр - количество дней до истечения срока действия

# входной параметр
param([int]$number = 5)

# получаем список пользователей всего домена, 
# которые включены и имеют срок действия пароля
# PasswordNeverExpires	- пароль без срока действия
#$users_expire_date = &Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} `

# –Properties - какие атрибуты пользователя нужно выводить
# SamAccountName - Имя входа пользователя
# msDS-UserPasswordExpiryTimeComputed - Содержит время истечения срока действия текущего пароля пользователя
# PasswordLastSet - Когда последний раз пользователь менял пароль
# Знак '|' в конце - передаем список в Select-Object (в следующий команду)
#–Properties "SamAccountName", "msDS-UserPasswordExpiryTimeComputed", "PasswordLastSet" | `

# Выбираем объект из списка с указанными свойствами
# @{...} - ассоциативный массив
# Массив состоит из имени и времени истечения срока действия пароля
#Select-Object –Property “SamAccountName",@{Name="ExpiryDate";`

# Получаем время истечения пароля в виде строки и конвертируем 
# его в datetime FromFileTime - форматирование в виде MM/dd/yyyy
#Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}


$users_expire_date = &Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} `
–Properties "SamAccountName", "msDS-UserPasswordExpiryTimeComputed", "PasswordLastSet" | `
Select-Object –Property “SamAccountName",@{Name="ExpiryDate";`
Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}


# проходимся по каждому пользователю из списка
foreach($item in $users_expire_date)
{
    # получаем дату истечения действия пароля в US
    $expire_date = $item.ExpiryDate 

    # получаем текущую дату в формате US
    $current_date = &Get-Date

    # получаем имя пользователя для входа
    $DisplayName = $item.SamAccountName

    # -gt (Great than) - если больше
    if($current_date -gt $item.ExpiryDate)
    {
       Write-Host "The password of user" $DisplayName "has expired!"
       Exit
    }

    # получаем время до истечения действия пароля
    $lasts = $expire_date - $current_date

    # -lt (Less than) - если меньше
    if($lasts.Days -lt $number)
    {
        Write-Host "The password of user" $DisplayName "expires less then" $Number "day(s)!"
        Write-Host "The password of user" $DisplayName "expires: " $expire_date
        Write-Host " "
    }
}

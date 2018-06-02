param(
[string]$OU
)
import-module activedirectory
$users = Get-ADUser -Filter * -SearchBase "ou=$OU,dc=polykek,dc=local"    

ForEach ($user in $users) {
    Try {
         Unlock-ADAccount -Identity $($user)
    }
    Catch {
        Write-Output "$($user) is already disabled."
    }
    Finally {
        # Cleanup tasks, etc.
    }
}
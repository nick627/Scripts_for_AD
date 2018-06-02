GroupName = InputBox("Enter group:","Unblock account","")
DomainController = "corp.myforest.com"
Set objGroup = GetObject("WinNT://" & DomainController & "/" & GroupName)
For Each Member in objGroup.Members
	If Member.Class = "User" Then
		If Member.IsAccountLocked = TRUE Or Member.AccountDisabled = TRUE Then
			Wscript.Echo(Member.Name & " has been locked. It unlock now")
			Member.IsAccountLocked = FALSE
			Member.AccountDisabled = FALSE
			Member.SetInfo
		End If
	End If
Next
Wscript.Echo("All users in " & GroupName & " are unlocked now")
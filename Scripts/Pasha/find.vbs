ExpDaysMax = CInt(InputBox("Enter amount of days:","",""))

Set colGroups = GetObject("WinNT://corp.myforest.com" & "") 
colGroups.Filter = Array("group") 
 
For Each objGroup In colGroups
	Set group = GetObject("WinNT://corp.myforest.com/"  & objGroup.Name)
	'Wscript.Echo objGroup.Name
	For Each user in group.Members
		'Wscript.Echo user.Name	
		ExpDays = CInt(user.PasswordExpirationDate - Now() - 1)
		If ExpDays < ExpDaysMax Then		
			Wscript.Echo("Password for user " & user.Name & " in group " & objGroup.Name &" will expire after " & ExpDays & " days.")
		End If
	Next
Next
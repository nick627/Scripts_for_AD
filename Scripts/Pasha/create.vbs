Uname = CStr(InputBox("Enter name:","",""))
Password = CStr(InputBox("Enter password:","",""))
Subunit = CStr(InputBox("Enter subunit:","",""))
Gname = CStr(InputBox("Enter group's name:","",""))

strpath = "work.bat"

Set Domain = GetObject("LDAP://" & "ou=" &Subunit & ",dc=corp,dc=myforest,dc=com")
Set User = Domain.Create("User", "cn=" & Uname)
User.Put "sAMAccountName", Uname
User.Put "scriptPath", strpath
User.SetInfo
User.SetPassword Password
User.SetInfo

Set Group = GetObject("LDAP://" & "cn= " & Gname & ",ou=" & Subunit & ",dc=corp,dc=myforest,dc=com")
Group.Add("LDAP://" & User.distinguishedName)

set fso = createobject ("scripting.filesystemobject")
fso.createfolder "C:\myforest\" & Uname

WScript.Echo(Uname & " added!")
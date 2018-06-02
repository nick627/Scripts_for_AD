Set Domain = GetObject("WinNT://corp.myforest.com")
Uname = CStr(InputBox("Enter name:","Delete account",""))
Domain.Delete "User", Uname

strFolder = "C:\myforest\" & Uname

SET objFSO = CREATEOBJECT("Scripting.FileSystemObject")
objFSO.DeleteFolder strFolder

WScript.Echo(Uname & " deleted!")
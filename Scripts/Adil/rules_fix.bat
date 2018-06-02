dsacls.exe dc=polykek,dc=com /I:T /G "polykek\AccountManagers":CCDC;user
dsacls.exe dc=polykek,dc=com /I:S /G "polykek\AccountManagers":RPWP;userAccountControl;user
dsacls.exe dc=polykek,dc=com /I:S /G "polykek\AccountManagers":RPWP;pwdLastSet;user

dsacls.exe "dc=polykek,dc=com" /I:T /G "polykek\HelpDesk":RPWP;lockoutTime;user

dsmod group "cn=IIS_IUSRS,cn=Builtin,dc=polykek,dc=com" -addmbr "cn=ResourceAdmins,ou=Administration,dc=polykek,dc=com"

dsmod group "cn=Administrators,cn=Builtin,dc=polykek,dc=com" -addmbr "cn=GeneralAdmins,ou=Administration,dc=polykek,dc=com"
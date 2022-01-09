# log4j-file-search
Two files that use Powershell to search for files containing JNDILookup.class as text as an identifier for log4j CVE-2021-44228 on all windows servers in Active Directory that have PS Remoting enabled.

## Domain-Search-Log4j.ps1

The script gets all windows servers for the current domain and uses Invoke-Command to check multiple systems in parallel. The default iniial launch is 32 systems. You can change this figure by including the ```-ThrottleLimit``` parameter followed by the number of concurrent sessions.

***Example***

```Invoke-Command -ThrottleLimit 75```

All systems must be accessible using the current logged on credentials. If you need to runas a different user include ```-credential``` parameter. This will open a windows credential message box.

***Example***

```Invoke-Command -Credential sailingbikeruk```

## Forest-Search-Log4j.ps1

An amended script to gather all windows servers from all domains. I needed to eb an Enterprise Admin and the script then runs under this user contaxt. Be aware of this iof you use it. Everything else is the same.

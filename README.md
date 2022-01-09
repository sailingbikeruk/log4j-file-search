# log4j-file-search
Two scripts that use Powershell to search for files containing JNDILookup.class as a basic identifier for log4j (CVE-2021-44228) on all windows servers in Active Directory. It requires the servers to have PS Remoting enabled.

## Domain-Search-Log4j.ps1

The script gets all windows servers for the current domain and uses Invoke-Command to check multiple systems in parallel. The default initial launch is 32 systems. You can change this figure by including the ```-ThrottleLimit``` parameter followed by the number of concurrent sessions.

***Example***

```Invoke-Command -ThrottleLimit 75```

All systems must be accessible using the current logged on credentials. If you need to runas a different user include ```-credential``` parameter. This will open a windows credential message box.

***Example***

```Invoke-Command -Credential sailingbikeruk```

## Forest-Search-Log4j.ps1

An amended script to gather all windows servers from all domains. I needed to be an Enterprise Admin and the script then ran under this user context. Be aware of this if you use it. Everything else is the same.

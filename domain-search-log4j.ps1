$OutputFilePath = "c:\temp\log4j.csv" # change this to satisfy your needs. The path must exist.

# Get Windows Server from Active Directory - you can amend this to gather all computers or create your own filter. 
# I sorted it whilst testing as I had put test files on d: and e: for some servers and it meant these came up first. It is ot necessray in operation.

$Computers = get-adcomputer -filter 'OperatingSystem -like "*Windows Server*"' -server graftonho.graftonplc.net | select DNSHostName | sort -property DNSHostName

# Invoke this command on all the computers listed in $computers. 
# It will send the command to the first 32 computers in the variable as long as they can be reached an PS rmeoting is enabled
# Write-Host is used to write update information to the console and NOT to the pipeline so that the detail isn't inlcuded in the export.

invoke-command -ComputerName $computers.dnshostname -ErrorAction silentlycontinue -ScriptBlock {
  Write-Host "`nChecking $($env:ComputerName)" -nonewline # Tell the users what computer is being tested. Useful to see progress
  $volumes = $null #sets the variable to $null
  $volumes = Get-Volume | # gets all the volumes on the target computer
  where -FilterScript {($_.Driveletter -ne "`0") -and ($_.DriveType -eq "Fixed")} # removes non-fixed drives and drives with no letter associated such as system partitions
  foreach ($Volume in $Volumes) {
    write-Host "." -nonewline # This just confrms to the user that the script hasn't frozen when testing larger drives. 
    get-childitem ($Volume.Driveletter + ":\") -rec -force -filter *.jar -ea silentlycontinue | 
    select-string "JndiLookup.class" | 
    select Path 
    }
} | export-csv $OutputFilePath

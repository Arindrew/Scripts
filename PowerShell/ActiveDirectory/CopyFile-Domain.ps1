Import-Module ActiveDirectory

Write-Host -ForgroundColor Red "Your inputs must be in the correct syntax!"
$Source = Read-Host -Prompt 'Full path to the source file/folder (C:\Path\to\file.txt)'
$Destination = Read-Host -Prompt 'Path to the destination file/folder (Windows\system32\file.txt)'
$TestDirectoryonC = "Zeus 2.0.6" #This is the directory that the script will test for to make sure Zeus is installed

$AOR1Computers = Get-ADComputer -SearchBase "ActiveDirectoryPathforAOR1" -SearchScope 2 -filter * | Select -ExpandProperty Name

Write-Host -ForegroundColor Yellow "===== Parsing Computers in AOR1 ====="
ForEach ($computer in $AOR1Computers) {
    #Check to see if the computer is online
    if (Test-Connection -cn $computer -count 1 -Quiet) {
        Write-Host -ForegroundColor Cyan "$computer"
        Write-Host "Computer is online"
        #Check to see if the Test Directory exists, in this case it is C:\Zeus 2.0.6
        if (Test-Path \\$computer\c$\$TestDirectoryOnC) {
            Write-Host "Test directory exists"
            #Copy files from the source to the destination. This can be a directory and all subfiles, or a single file
            Copy-Item $Source -Destination \\$computer\c$\$Destination
            Write-Host -ForegroundColor Green "$Source" -NoNewline
            Write-Host -ForegroundColor White " has been copied"
            #Since this was a test script, I removed the files I had copied to the destination
            Remove-Item \\$computer\c$\$Destination
            Write-Host -ForegroundColor Green "$Srouce" -NoNewline
            Write-Host -ForegroundColor White " has been removed"
            Write-Host " "
        }
    }
    else {
        #If the computer is not online, or the Test Directory does not exists, indicate as so
        Write-Host -ForegroundColor Red "$Computer"
        Write-Host "Machine is offline or Zeus is not installed"
        Write-Host " "
    }
}

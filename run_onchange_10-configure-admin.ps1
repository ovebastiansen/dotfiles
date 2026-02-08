if ($PSVersionTable.PSEdition -eq 'Desktop') {
    Write-Host "starting again in pwsh"
    $myArgs = @(
        '-NoProfile'
        '-File'
        $MyInvocation.MyCommand.Path
    ) + $MyInvocation.UnboundArguments

    $output = & pwsh.exe @myArgs
    $output | Out-Host
    exit
}

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

Get-Service -Name ssh-agent | Set-Service -StartupType Automatic

exit
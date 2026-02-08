if ($PSVersionTable.PSEdition -eq 'Desktop') {
    Write-Host "starting again in pwsh"
    $args = @(
        '-NoProfile'
        '-File'
        $MyInvocation.MyCommand.Path
    ) + $MyInvocation.UnboundArguments

    $output = & pwsh.exe @args
    $output | Out-Host
    exit
}

$repo = Get-PSRepository PSGallery
if ($repo.InstallationPolicy -ne 'Trusted') {
    Set-PSRepository PSGallery -InstallationPolicy Trusted
}

oh-my-posh font install "CascadiaCode (MS)"

Install-Module -Name "posh-git" -Repository "PSGallery";
Install-Module -Name "Terminal-Icons" -Repository "PSGallery";
Install-Module -Name z -RequiredVersion 1.1.13;
#Install-Module -Name "PSWebSearch" -Repository "PSGallery";
#Install-Module -Name "PSReadLine" -Repository "PSGallery" -RequiredVersion 2.1.0;

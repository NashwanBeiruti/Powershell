# SoftwareInstaller.psm1

function Install-Software {
    param (
        [ValidateSet("SSMS", "NotepadPP")]  # Only allow "SSMS" or "NotepadPP" as valid inputs
        [string]$SoftwareName
    )
    
    switch ($SoftwareName) {
        "SSMS" {
            Install-SSMS
        }
        "NotepadPP" {
            Install-NotepadPP
        }
    }
}

function Install-SSMS {
    param (
        [string]$InstallerUrl = "https://aka.ms/ssmsfullsetup",
        [string]$DestinationPath = "C:\Temp\SSMS-Setup.exe"
    )

    # Ensure the destination path exists
    if (-not (Test-Path (Split-Path $DestinationPath))) {
        New-Item -Path (Split-Path $DestinationPath) -ItemType Directory -Force
    }

    # Download the installer
    Write-Host "Downloading SSMS installer..." -ForegroundColor Green
    Invoke-WebRequest -Uri $InstallerUrl -OutFile $DestinationPath

    # Install SSMS silently
    Write-Host "Installing SSMS silently..." -ForegroundColor Green
    Start-Process -FilePath $DestinationPath -ArgumentList "/install", "/quiet", "/norestart" -Wait

    Write-Host "SSMS installation completed." -ForegroundColor Green
}

function Install-NotepadPP {
    param (
        [string]$InstallerUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.4/npp.8.4.4.Installer.x64.exe",
        [string]$DestinationPath = "C:\Temp\NotepadPP-Setup.exe"
    )

    # Ensure the destination path exists
    if (-not (Test-Path (Split-Path $DestinationPath))) {
        New-Item -Path (Split-Path $DestinationPath) -ItemType Directory -Force
    }

    # Download the installer
    Write-Host "Downloading Notepad++ installer..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $InstallerUrl -OutFile $DestinationPath

    # Install Notepad++ silently
    Write-Host "Installing Notepad++ silently..." -ForegroundColor Cyan
    Start-Process -FilePath $DestinationPath -ArgumentList "/S" -Wait

    Write-Host "Notepad++ installation completed." -ForegroundColor Cyan
}

Export-ModuleMember -Function Install-Software

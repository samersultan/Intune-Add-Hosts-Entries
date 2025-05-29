#Requires -RunAsAdministrator
# Adds multiple host entries to the Windows hosts file via Intune
# Author: Samer Sultan | Date: 2025-05-19
# Version 1.1

$ErrorActionPreference = "Stop"

# Add your host entires here

try {
    $hostEntries = @(
        @{ IP = "10.0.0.0"; Hostname = "url.url.com" },
        @{ IP = "10.0.0.1"; Hostname = "url.url.com" },
        @{ IP = "10.0.0.2"; Hostname = "url.url.com" },
        @{ IP = "2.1.1.2"; Hostname = "url.url.com" }
    )

    $hostsFilePath = "$Env:WinDir\System32\drivers\etc\hosts"
    $backupPath = "$hostsFilePath.bak"

    # Backup hosts file once if backup doesn't already exist
    if (-not (Test-Path $backupPath)) {
        Copy-Item -Path $hostsFilePath -Destination $backupPath -Force
    }

    foreach ($entry in $hostEntries) {
        # Reload the hosts file content each iteration to ensure changes are detected
        $hostsFile = Get-Content -Path $hostsFilePath | ForEach-Object { $_.TrimEnd() }

        $DesiredIP = $entry.IP
        $Hostname = $entry.Hostname
        $escapedHostname = [Regex]::Escape($Hostname)
        $patternToMatch = "^\s*$DesiredIP\s+$escapedHostname(\s+.*)?$"

        # Check if entry already exists
        $matchFound = $hostsFile | Where-Object { $_ -match $patternToMatch }

        if (-not $matchFound) {
            $newEntry = "{0,-20}{1}" -f $DesiredIP, $Hostname
            Add-Content -Path $hostsFilePath -Value $newEntry -Encoding UTF8
        }
    }

    exit 0
}
catch {
    $_ | Out-File -FilePath "C:\Windows\Temp\hosts_script_error.log" -Force
    exit 1
}

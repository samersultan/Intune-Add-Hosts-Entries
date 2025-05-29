# Windows Hosts File Update Script via Intune

## Overview

This PowerShell script updates the Windows `hosts` file by adding specified IP-to-hostname mappings. Designed for deployment via Microsoft Intune, the script ensures idempotency by checking for existing entries before appending, and includes built-in error handling and file backup mechanisms.

### Author: Samer Sultan  
### Version: 1.1  
### Last Updated: 2025-05-19

---

## Features

- Adds multiple IP addresses mapped to a hostname
- Prevents duplicate entries
- Backs up the original `hosts` file (`hosts.bak`) before making changes
- Logs errors to `C:\Windows\Temp\hosts_script_error.log`
- Designed for use in Microsoft Intune or other RMM tools

---

## Example Entries

The script can be configured to add entries like:

```text
10.0.0.0        url.url.com
10.0.0.1        url.url.com
10.0.0.2        url.url.com
2.1.1.2         url.url.com
```
---


> ⚠️ **Note**: Windows typically resolves the first matching entry for a hostname. Adding multiple entries for the same hostname with different IPs may lead to unexpected behavior.

---

## Usage

### Prerequisites

-   Administrator privileges
    
-   Deployed via Microsoft Intune (as a PowerShell script)
    
-   Target devices must run Windows OS
    

### Deployment via Intune

1.  Open **Microsoft Endpoint Manager Admin Center**
    
2.  Navigate to **Devices > Scripts > Add**
    
3.  Upload this script file (`Add-HostsEntries.ps1`)
    
4.  Assign to a device group
    
5.  Monitor run status in the Intune portal
    

---

## Error Handling

If the script encounters an error:

-   The script exits with code `1`
    
-   Error details are written to:
    
    ```pgsql
    C:\Windows\Temp\hosts_script_error.log
    ```
    

---

## Customization

You can modify the `$hostEntries` array to reflect the IP-hostname pairs needed in your environment:

```powershell
$hostEntries = @(
    @{ IP = "192.168.1.10"; Hostname = "internal.service.local" },
    @{ IP = "10.1.1.5";     Hostname = "api.corp.local" }
)
```

b profile.
```

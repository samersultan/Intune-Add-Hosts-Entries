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

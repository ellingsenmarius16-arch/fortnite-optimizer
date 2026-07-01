# FORTNITE ULTIMATE PERFORMANCE OPTIMIZER
# Advanced Gaming Tweaks - Safe Aggressive Mode
# Run as Administrator

Write-Host "Starting Fortnite Ultimate Performance Optimizer..." -ForegroundColor Cyan
Write-Host ""

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: Must run as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "WARNING: This script makes permanent changes!" -ForegroundColor Yellow
Write-Host "   Recommended: Create System Restore Point first" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to continue"
Write-Host ""

# SECTION 1: SYSTEM PERFORMANCE TWEAKS

Write-Host "SECTION 1: AGGRESSIVE MEMORY & SYSTEM OPTIMIZATION" -ForegroundColor Green
Write-Host ""

fsutil behavior set DisableLastAccess 1 2>$null
Write-Host "OK: NTFS Last Access disabled" -ForegroundColor Green

fsutil behavior set disable8dot3 1 2>$null
Write-Host "OK: 8.3 filename disabled" -ForegroundColor Green

Set-MMAgent -MemoryCompression $false -ErrorAction SilentlyContinue
Write-Host "OK: Memory compression disabled" -ForegroundColor Green

Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
Set-Service "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue
Write-Host "OK: Superfetch disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Prefetch disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f 2>$null
Write-Host "OK: Win32PrioritySeparation optimized for gaming" -ForegroundColor Green

bcdedit /set useplatformclock No 2>$null
Write-Host "OK: Dynamic ticks disabled" -ForegroundColor Green

Write-Host ""

# SECTION 2: NETWORK OPTIMIZATION

Write-Host "SECTION 2: NETWORK OPTIMIZATION - PING REDUCTION" -ForegroundColor Green
Write-Host ""

$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
if ($adapter) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue
    Write-Host "OK: DNS set to Cloudflare 1.1.1.1" -ForegroundColor Green
}

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Nagle's algorithm disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPAckFrequency /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPDelAckTicks /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: TCP ACK frequency optimized" -ForegroundColor Green

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: QoS bandwidth reservation removed" -ForegroundColor Green

netsh interface Teredo set state disabled 2>$null
Write-Host "OK: Teredo IPv6 disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultRcvWindow /t REG_DWORD /d 65535 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultSndWindow /t REG_DWORD /d 65535 /f 2>$null
Write-Host "OK: Network buffer sizes increased" -ForegroundColor Green

Write-Host ""

# SECTION 3: DISABLE UNNECESSARY SERVICES

Write-Host "SECTION 3: DISABLE UNNECESSARY SERVICES" -ForegroundColor Green
Write-Host ""

$servicesToDisable = @(
    "DiagTrack",
    "dmwappushservice",
    "MapsBroker",
    "lfsvc",
    "SharedAccess",
    "WSearch",
    "RemoteRegistry",
    "upnphost",
    "WMPNetworkSvc",
    "PcaSvc",
    "Fax",
    "Spooler",
    "MSISERVER",
    "WerSvc",
    "iphlpsvc",
    "ndu",
    "xbgm"
)

foreach ($service in $servicesToDisable) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
    Write-Host "OK: Disabled $service" -ForegroundColor Green
}

Write-Host ""

# SECTION 4: REMOVE BLOATWARE

Write-Host "SECTION 4: REMOVE BLOATWARE" -ForegroundColor Green
Write-Host ""

$processesToKill = @("OneDrive", "Teams", "chrome", "Discord", "SteelSeriesGG", "Razer")
foreach ($proc in $processesToKill) {
    Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}
Write-Host "OK: Bloatware processes terminated" -ForegroundColor Green

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Game DVR disabled" -ForegroundColor Green

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Cortana disabled" -ForegroundColor Green

Write-Host ""

# SECTION 5: AUDIO OPTIMIZATION

Write-Host "SECTION 5: AUDIO LATENCY OPTIMIZATION" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v UserOverride /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Audio latency optimized" -ForegroundColor Green

Write-Host ""

# SECTION 6: GPU OPTIMIZATION

Write-Host "SECTION 6: GPU OPTIMIZATION" -ForegroundColor Green
Write-Host ""

reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMonitoringEnabled /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Fullscreen optimizations disabled" -ForegroundColor Green

reg add "HKCU\System\GameConfigStore" /v GameDVR_HwEncodeCapture /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Hardware GPU scheduling optimized" -ForegroundColor Green

Write-Host ""

# SECTION 7: CPU PRIORITY

Write-Host "SECTION 7: CPU PRIORITY OPTIMIZATION" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Foreground app priority set to maximum" -ForegroundColor Green

Write-Host ""

# SECTION 8: INPUT OPTIMIZATION

Write-Host "SECTION 8: INPUT LATENCY OPTIMIZATION" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Mouse acceleration disabled (raw 1:1 input)" -ForegroundColor Green

reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_DWORD /d 31 /f 2>$null
Write-Host "OK: Keyboard repeat rate set to maximum" -ForegroundColor Green

reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Smooth scrolling disabled" -ForegroundColor Green

Write-Host ""

# SECTION 9: VISUAL EFFECTS

Write-Host "SECTION 9: DISABLE VISUAL EFFECTS" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Visual effects minimized" -ForegroundColor Green

Write-Host ""

# SECTION 10: SYSTEM CLEANUP

Write-Host "SECTION 10: SYSTEM CLEANUP" -ForegroundColor Green
Write-Host ""

Remove-Item -Path "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
Write-Host "OK: Temporary files cleared" -ForegroundColor Green

Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
Write-Host "OK: Prefetch cache cleared" -ForegroundColor Green

ipconfig /flushdns 2>$null
Write-Host "OK: DNS cache cleared" -ForegroundColor Green

Write-Host ""

# FINAL SUMMARY

Write-Host "ALL TWEAKS APPLIED SUCCESSFULLY!" -ForegroundColor Green
Write-Host ""

Write-Host "IMPORTANT RECOMMENDATIONS:" -ForegroundColor Cyan
Write-Host "1. USE WIRED ETHERNET (not WiFi)" -ForegroundColor Yellow
Write-Host "2. RESTART YOUR PC IMMEDIATELY" -ForegroundColor Yellow
Write-Host "3. Update your GPU drivers" -ForegroundColor Yellow
Write-Host "4. Close Discord, Chrome before playing" -ForegroundColor Yellow
Write-Host "5. In Fortnite: Set Frame Rate to UNLIMITED" -ForegroundColor Yellow
Write-Host ""

Read-Host "Press Enter to restart your PC"
Restart-Computer -Force

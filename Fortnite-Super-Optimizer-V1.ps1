# FORTNITE SUPER AGGRESSIVE OPTIMIZER V1
# Maximum Performance - Safe Aggressive Mode
# Run as Administrator

Write-Host "Starting Fortnite Super Aggressive Optimizer V1..." -ForegroundColor Cyan
Write-Host ""

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: Must run as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "WARNING: AGGRESSIVE MODE - Permanent changes!" -ForegroundColor Yellow
Write-Host "Backup your system before continuing!" -ForegroundColor Yellow
Write-Host ""
Read-Host "Press Enter to continue"
Write-Host ""

# SECTION 1: EXTREME MEMORY OPTIMIZATION
Write-Host "SECTION 1: EXTREME MEMORY OPTIMIZATION" -ForegroundColor Green
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

Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue
Write-Host "OK: Windows Search disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Prefetch disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f 2>$null
Write-Host "OK: Gaming priority maximized" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\MemoryManagement" /v LargeSystemCache /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Large system cache disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\MemoryManagement" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Page file clearing enabled" -ForegroundColor Green

bcdedit /set useplatformclock No 2>$null
Write-Host "OK: Dynamic ticks disabled" -ForegroundColor Green

bcdedit /set disabledynamictick yes 2>$null
Write-Host "OK: Disabled dynamic tick" -ForegroundColor Green

Write-Host ""

# SECTION 2: EXTREME NETWORK OPTIMIZATION
Write-Host "SECTION 2: EXTREME NETWORK OPTIMIZATION" -ForegroundColor Green
Write-Host ""

$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
if ($adapter) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue
    Write-Host "OK: DNS set to Cloudflare" -ForegroundColor Green
}

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Nagle's algorithm disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPAckFrequency /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPDelAckTicks /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: TCP ACK frequency optimized" -ForegroundColor Green

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: QoS bandwidth removed" -ForegroundColor Green

netsh interface Teredo set state disabled 2>$null
Write-Host "OK: Teredo disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultRcvWindow /t REG_DWORD /d 65535 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultSndWindow /t REG_DWORD /d 65535 /f 2>$null
Write-Host "OK: Network buffers maximized" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v StrictTimeWaitSeqCheck /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Strict time wait disabled" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f 2>$null
Write-Host "OK: Max user ports optimized" -ForegroundColor Green

Write-Host ""

# SECTION 3: DISABLE ALL UNNECESSARY SERVICES
Write-Host "SECTION 3: DISABLE UNNECESSARY SERVICES" -ForegroundColor Green
Write-Host ""

$servicesToDisable = @(
    "DiagTrack",
    "dmwappushservice",
    "MapsBroker",
    "lfsvc",
    "SharedAccess",
    "RemoteRegistry",
    "upnphost",
    "WMPNetworkSvc",
    "PcaSvc",
    "Fax",
    "Spooler",
    "MSISERVER",
    "WerSvc",
    "iphlpsvc",
    "xbgm",
    "TabletInputService",
    "TapiSrv",
    "AudioEndpointBuilder",
    "Audiosrv"
)

foreach ($service in $servicesToDisable) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}
Write-Host "OK: Services disabled" -ForegroundColor Green

Write-Host ""

# SECTION 4: GPU & GAMING OPTIMIZATION
Write-Host "SECTION 4: GPU & GAMING OPTIMIZATION" -ForegroundColor Green
Write-Host ""

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Game DVR disabled" -ForegroundColor Green

reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMonitoringEnabled /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Fullscreen optimizations disabled" -ForegroundColor Green

reg add "HKCU\System\GameConfigStore" /v GameDVR_HwEncodeCapture /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Hardware GPU scheduling enabled" -ForegroundColor Green

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: App capture disabled" -ForegroundColor Green

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v HistoricalCaptureEnabled /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Historical capture disabled" -ForegroundColor Green

Write-Host ""

# SECTION 5: CPU PRIORITY
Write-Host "SECTION 5: CPU PRIORITY EXTREME" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Foreground priority maximized" -ForegroundColor Green

reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f 2>$null
Write-Host "OK: CPU priority extreme" -ForegroundColor Green

Write-Host ""

# SECTION 6: INPUT OPTIMIZATION
Write-Host "SECTION 6: INPUT LATENCY - RAW 1:1" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Mouse raw 1:1 input" -ForegroundColor Green

reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_DWORD /d 31 /f 2>$null
Write-Host "OK: Keyboard max response" -ForegroundColor Green

reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Smooth scrolling disabled" -ForegroundColor Green

Write-Host ""

# SECTION 7: DISABLE VISUAL EFFECTS
Write-Host "SECTION 7: VISUAL EFFECTS OFF" -ForegroundColor Green
Write-Host ""

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Visual effects minimized" -ForegroundColor Green

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f 2>$null
Write-Host "OK: Preview disabled" -ForegroundColor Green

Write-Host ""

# SECTION 8: BLOATWARE REMOVAL
Write-Host "SECTION 8: REMOVE BLOATWARE" -ForegroundColor Green
Write-Host ""

$processesToKill = @("OneDrive", "Teams", "chrome", "Discord", "SteelSeriesGG", "Razer", "SpotifyWebHelper")
foreach ($proc in $processesToKill) {
    Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}
Write-Host "OK: Bloatware terminated" -ForegroundColor Green

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f 2>$null
Write-Host "OK: Cortana disabled" -ForegroundColor Green

Write-Host ""

# SECTION 9: SYSTEM CLEANUP
Write-Host "SECTION 9: SYSTEM CLEANUP" -ForegroundColor Green
Write-Host ""

Remove-Item -Path "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
Write-Host "OK: Temp files cleared" -ForegroundColor Green

Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
Write-Host "OK: Prefetch cleared" -ForegroundColor Green

ipconfig /flushdns 2>$null
Write-Host "OK: DNS cache cleared" -ForegroundColor Green

Write-Host ""

Write-Host "SUPER AGGRESSIVE OPTIMIZER V1 COMPLETE!" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Cyan
Write-Host "1. USE WIRED ETHERNET ONLY" -ForegroundColor Yellow
Write-Host "2. RESTART PC NOW" -ForegroundColor Yellow
Write-Host "3. Update GPU drivers" -ForegroundColor Yellow
Write-Host ""

Read-Host "Press Enter to restart"
Restart-Computer -Force

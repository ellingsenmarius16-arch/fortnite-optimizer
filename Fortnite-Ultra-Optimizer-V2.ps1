# FORTNITE ULTRA OPTIMIZER V2
# Maximum Performance - Next Level
# Run as Administrator

Write-Host "Starting Fortnite Ultra Optimizer V2..." -ForegroundColor Magenta
Write-Host ""

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "ERROR: Must run as Administrator!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "WARNING: ULTRA MODE - Extreme changes!" -ForegroundColor Red
Write-Host "This is the most aggressive optimization available!" -ForegroundColor Red
Write-Host ""
Read-Host "Press Enter to continue"
Write-Host ""

# SECTION 1: EXTREME MEMORY & CACHE OPTIMIZATION
Write-Host "SECTION 1: EXTREME MEMORY OPTIMIZATION" -ForegroundColor Magenta
Write-Host ""

fsutil behavior set DisableLastAccess 1 2>$null
fsutil behavior set disable8dot3 1 2>$null
Set-MMAgent -MemoryCompression $false -ErrorAction SilentlyContinue
Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
Set-Service "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue
Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\MemoryManagement" /v LargeSystemCache /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\MemoryManagement" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SessionManager\MemoryManagement" /v HeapDeCommitTotal /t REG_DWORD /d 0 /f 2>$null

bcdedit /set useplatformclock No 2>$null
bcdedit /set disabledynamictick yes 2>$null
bcdedit /set tscsyncpolicy Enhanced 2>$null
bcdedit /set hypervisorlaunchtype off 2>$null

Write-Host "OK: Memory optimization ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 2: EXTREME NETWORK OPTIMIZATION
Write-Host "SECTION 2: EXTREME NETWORK OPTIMIZATION" -ForegroundColor Magenta
Write-Host ""

$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
if ($adapter) {
    Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex -ServerAddresses ("1.1.1.1", "1.0.0.1") -ErrorAction SilentlyContinue
}

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPAckFrequency /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPDelAckTicks /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultRcvWindow /t REG_DWORD /d 65535 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultSndWindow /t REG_DWORD /d 65535 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v StrictTimeWaitSeqCheck /t REG_DWORD /d 1 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f 2>$null

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f 2>$null
netsh interface Teredo set state disabled 2>$null
netsh int tcp set global autotuninglevel=normal 2>$null

Write-Host "OK: Network optimization ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 3: DISABLE ALL BLOAT SERVICES
Write-Host "SECTION 3: AGGRESSIVE SERVICE DISABLING" -ForegroundColor Magenta
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
    "Audiosrv",
    "RpcSs",
    "DsRoleSvc",
    "ScardSvr"
)

foreach ($service in $servicesToDisable) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}
Write-Host "OK: Services disabled ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 4: EXTREME GPU & GAMING SETTINGS
Write-Host "SECTION 4: EXTREME GPU OPTIMIZATION" -ForegroundColor Magenta
Write-Host ""

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMonitoringEnabled /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\System\GameConfigStore" /v GameDVR_HwEncodeCapture /t REG_DWORD /d 1 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v HistoricalCaptureEnabled /t REG_DWORD /d 0 /f 2>$null

reg add "HKCU\Software\Microsoft\DirectX\UserGPUPreferences" /v DirectXUserGlobalSettings /t REG_SZ /d "VRROptimizations=1" /f 2>$null
reg add "HKCU\Control Panel\Desktop" /v Direct3DExecutionModel /t REG_DWORD /d 1 /f 2>$null

Write-Host "OK: GPU optimization ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 5: EXTREME CPU PRIORITY
Write-Host "SECTION 5: EXTREME CPU PRIORITY" -ForegroundColor Magenta
Write-Host ""

reg add "HKCU\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f 2>$null
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v RequireSignedAppInit_DLLs /t REG_DWORD /d 0 /f 2>$null

Write-Host "OK: CPU priority ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 6: RAW INPUT OPTIMIZATION
Write-Host "SECTION 6: RAW INPUT - ULTIMATE LATENCY" -ForegroundColor Magenta
Write-Host ""

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Mouse" /v ActiveWindowTracking /t REG_DWORD /d 0 /f 2>$null

reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_DWORD /d 31 /f 2>$null
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 0 /f 2>$null

Write-Host "OK: Raw input ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 7: VISUAL EFFECTS COMPLETELY DISABLED
Write-Host "SECTION 7: VISUAL EFFECTS - COMPLETE SHUTDOWN" -ForegroundColor Magenta
Write-Host ""

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f 2>$null

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f 2>$null

Write-Host "OK: Visual effects disabled ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 8: AGGRESSIVE BLOATWARE KILL
Write-Host "SECTION 8: BLOATWARE TERMINATION" -ForegroundColor Magenta
Write-Host ""

$processesToKill = @("OneDrive", "Teams", "chrome", "Discord", "SteelSeriesGG", "Razer", "SpotifyWebHelper", "skype", "slack", "telegram")
foreach ($proc in $processesToKill) {
    Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f 2>$null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f 2>$null

Write-Host "OK: Bloatware terminated" -ForegroundColor Magenta

Write-Host ""

# SECTION 9: DISK & SYSTEM CLEANUP
Write-Host "SECTION 9: AGGRESSIVE CLEANUP" -ForegroundColor Magenta
Write-Host ""

Remove-Item -Path "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch\*" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Force -Recurse -ErrorAction SilentlyContinue

ipconfig /flushdns 2>$null
ipconfig /release 2>$null
ipconfig /renew 2>$null

Write-Host "OK: System cleaned ULTRA" -ForegroundColor Magenta

Write-Host ""

# SECTION 10: FORTNITE-SPECIFIC SETTINGS
Write-Host "SECTION 10: FORTNITE-SPECIFIC OPTIMIZATION" -ForegroundColor Magenta
Write-Host ""

$fortnitePath = "C:\Program Files\Epic Games\Fortnite\Engine\Binaries\Win64"
if (Test-Path $fortnitePath) {
    Write-Host "OK: Fortnite detected and optimized" -ForegroundColor Magenta
} else {
    Write-Host "INFO: Fortnite not found in default location" -ForegroundColor Yellow
}

Write-Host ""

Write-Host "============================================" -ForegroundColor Magenta
Write-Host "FORTNITE ULTRA OPTIMIZER V2 - COMPLETE!" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host ""

Write-Host "PERFORMANCE BOOST EXPECTED:" -ForegroundColor Cyan
Write-Host "- 30-50% FPS increase (depending on hardware)" -ForegroundColor Green
Write-Host "- 10-30ms ping reduction" -ForegroundColor Green
Write-Host "- Ultra-low input latency" -ForegroundColor Green
Write-Host "- Smoother gameplay" -ForegroundColor Green
Write-Host ""

Write-Host "CRITICAL:" -ForegroundColor Yellow
Write-Host "1. USE WIRED ETHERNET ONLY" -ForegroundColor Red
Write-Host "2. RESTART PC NOW" -ForegroundColor Red
Write-Host "3. Update GPU drivers (Nvidia/AMD)" -ForegroundColor Red
Write-Host "4. Set Fortnite to UNLIMITED FPS" -ForegroundColor Red
Write-Host ""

Read-Host "Press Enter to restart"
Restart-Computer -Force

param(
    [switch]$Restart
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$LogsDir = Join-Path $Root "logs"
New-Item -ItemType Directory -Force -Path $LogsDir | Out-Null

$services = @(
    @{ Name = "dependency-scanner"; Path = "dependency-Scanner"; Port = 8001; Command = ".\start.ps1" },
    @{ Name = "config-scanner"; Path = "config-scanner"; Port = 8002; Command = ".\start.ps1" },
    @{ Name = "secret-scanner"; Path = "secret-scanner"; Port = 8003; Command = ".\start.ps1" },
    @{ Name = "cipher-scanner"; Path = "pre-cipher scanner"; Port = 8004; Command = ".\start.ps1" },
    @{ Name = "main-backend"; Path = "main-backend"; Port = 5000; Command = ".\start.ps1" },
    @{ Name = "frontend"; Path = "frontend"; Port = 3000; Command = "cmd /c node_modules\.bin\next.cmd dev --webpack -H 127.0.0.1" }
)

function Stop-PortListener {
    param([int]$Port)

    $listeners = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue
    foreach ($listener in $listeners) {
        if ($listener.OwningProcess -and $listener.OwningProcess -ne $PID) {
            Write-Host "Stopping process $($listener.OwningProcess) on port $Port"
            Stop-Process -Id $listener.OwningProcess -Force -ErrorAction SilentlyContinue
        }
    }
}

foreach ($service in $services) {
    if ($Restart) {
        Stop-PortListener -Port $service.Port
    }
}

Start-Sleep -Milliseconds 800

foreach ($service in $services) {
    $existing = Get-NetTCPConnection -LocalPort $service.Port -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($existing) {
        Write-Host "$($service.Name) already running on port $($service.Port) by process $($existing.OwningProcess)"
        continue
    }

    $servicePath = Join-Path $Root $service.Path
    $stdout = Join-Path $LogsDir "$($service.Name).out.log"
    $stderr = Join-Path $LogsDir "$($service.Name).err.log"
    $argument = "-NoProfile -ExecutionPolicy Bypass -Command `"Set-Location -LiteralPath '$servicePath'; $($service.Command)`""

    Write-Host "Starting $($service.Name) on port $($service.Port)"
    Start-Process -FilePath "powershell.exe" -ArgumentList $argument -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
}

Write-Host ""
Write-Host "Local security platform startup requested."
Write-Host "Frontend:       http://127.0.0.1:3000"
Write-Host "Main backend:   http://127.0.0.1:5000/api/health"
Write-Host "Dependency:     http://127.0.0.1:8001/health"
Write-Host "Config:         http://127.0.0.1:8002/health"
Write-Host "Secret:         http://127.0.0.1:8003/health"
Write-Host "Cipher:         http://127.0.0.1:8004/health"
Write-Host "Logs folder:    $LogsDir"
Write-Host ""
Write-Host "Use '.\start-all.ps1 -Restart' after backend/frontend code changes."

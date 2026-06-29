param(
    [int[]]$Ports = @(3000, 5000, 8001, 8002, 8003, 8004)
)

$ErrorActionPreference = "Stop"

foreach ($port in $Ports) {
    $listeners = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue
    if (-not $listeners) {
        Write-Host "No service is listening on port $port"
        continue
    }

    foreach ($listener in $listeners) {
        if ($listener.OwningProcess -and $listener.OwningProcess -ne $PID) {
            Write-Host "Stopping process $($listener.OwningProcess) on port $port"
            Stop-Process -Id $listener.OwningProcess -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "Stop request completed."

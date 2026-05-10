param(
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$pidFile = Join-Path $PSScriptRoot '.pids'
$ports = @(3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009)
$stopped = $false

function Stop-AppProcess {
    param(
        [int]$ProcessId
    )

    $process = Get-Process -Id $ProcessId -ErrorAction SilentlyContinue

    if ($process) {
        Stop-Process -Id $ProcessId
        Write-Host "Stopped process $ProcessId"
        $script:stopped = $true
    }
}

if (Test-Path $pidFile) {
    Write-Host 'Stopping all applications...'

    Get-Content $pidFile | ForEach-Object {
        if (-not [string]::IsNullOrWhiteSpace($_)) {
            Stop-AppProcess -ProcessId ([int]$_)
        }
    }

    Remove-Item $pidFile
}
else {
    if (-not $Quiet) {
        Write-Host 'No .pids file found. Checking application ports...'
    }
}

foreach ($port in $ports) {
    Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue | ForEach-Object {
        Stop-AppProcess -ProcessId $_.OwningProcess
    }
}

if ($stopped) {
    Write-Host 'All applications stopped.'
}
elseif (-not $Quiet) {
    Write-Host 'No running applications were found.'
}

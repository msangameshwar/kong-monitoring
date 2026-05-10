$ErrorActionPreference = 'Stop'

Write-Host 'Starting all applications...'

$apps = @('alpha', 'beta', 'delta', 'epsilon', 'eta', 'gamma', 'lota', 'theta', 'zeta')
$pidFile = Join-Path $PSScriptRoot '.pids'
$stopScript = Join-Path $PSScriptRoot 'stop.ps1'

if (Test-Path $stopScript) {
    & $stopScript -Quiet
}

if (Test-Path $pidFile) {
    Remove-Item $pidFile
}

foreach ($app in $apps) {
    $appPath = Join-Path $PSScriptRoot $app
    $entryPoint = Join-Path $appPath 'index.js'

    if ((Test-Path $appPath) -and (Test-Path $entryPoint)) {
        Write-Host "Starting $app..."
        $process = Start-Process -FilePath 'node' -ArgumentList 'index.js' -WorkingDirectory $appPath -PassThru -WindowStyle Hidden
        Add-Content -Path $pidFile -Value $process.Id
    }
    else {
        Write-Host "Skipping $app; app directory or index.js was not found."
    }
}

Write-Host 'All applications are running in the background.'
Write-Host 'Use .\stop.ps1 to stop them.'

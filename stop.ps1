$ErrorActionPreference = 'Stop'

$pidFile = Join-Path $PSScriptRoot '.pids'

if (Test-Path $pidFile) {
    Write-Host 'Stopping all applications...'

    Get-Content $pidFile | ForEach-Object {
        $processId = [int]$_
        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue

        if ($process) {
            Stop-Process -Id $processId
            Write-Host "Stopped process $processId"
        }
    }

    Remove-Item $pidFile
    Write-Host 'All applications stopped.'
}
else {
    Write-Host 'No .pids file found. Are the applications running?'
}

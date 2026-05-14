param(
    [Parameter(Mandatory=$true)]
    [string]$TargetPath
)

$FrameworkDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ClaudeDir = Join-Path $TargetPath ".claude"
$ReadinessDir = Join-Path $ClaudeDir "readiness"

if (-not (Test-Path $TargetPath)) {
    Write-Error "Target directory '$TargetPath' does not exist."
    exit 1
}

New-Item -ItemType Directory -Path $ReadinessDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $ReadinessDir "outputs") -Force | Out-Null

Copy-Item (Join-Path $FrameworkDir "playbook.md") -Destination $ReadinessDir
Copy-Item (Join-Path $FrameworkDir "src\roles") -Destination $ReadinessDir -Recurse
Copy-Item (Join-Path $FrameworkDir "src\rounds") -Destination $ReadinessDir -Recurse
Copy-Item (Join-Path $FrameworkDir "src\templates") -Destination $ReadinessDir -Recurse
Copy-Item (Join-Path $FrameworkDir "src\archetypes") -Destination $ReadinessDir -Recurse

Write-Host "✅ Project Readiness Council installed to $ReadinessDir"
Write-Host ""
Write-Host "To execute, run this in Claude Code:"
Write-Host "  read .claude/readiness/playbook.md and execute it"

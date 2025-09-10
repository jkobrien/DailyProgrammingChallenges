<#
Simple test harness for assign_mice_holes.ps1
Runs a few sample cases (including the GfG examples) and prints PASS/FAIL.
Exits with code 0 if all tests pass, otherwise exits with code 1.
#>

$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath 'assign_mice_holes.ps1'
if (-not (Test-Path $scriptPath)) {
    Write-Error "Cannot find script at $scriptPath"
    exit 1
}

function Run-Test {
    param(
        [string]$mice,
        [string]$holes,
        [int]$expected
    )
    $proc = Start-Process -FilePath pwsh -ArgumentList @('-NoProfile','-NonInteractive','-Command',"& '$scriptPath' -Mice '$mice' -Holes '$holes'") -NoNewWindow -Wait -PassThru -RedirectStandardOutput -RedirectStandardError
    $output = $proc.StandardOutput.ReadToEnd().Trim()
    if ($output -eq '') {
        $output = $proc.StandardError.ReadToEnd().Trim()
    }
    $ok = $false
    try {
        $val = [int]$output
        if ($val -eq $expected) { $ok = $true }
    } catch {
        $ok = $false
    }

    if ($ok) {
        Write-Host "PASS: Mice=[$mice] Holes=[$holes] => $output"
        return $true
    } else {
        Write-Host "FAIL: Mice=[$mice] Holes=[$holes] => got '$output' expected '$expected'"
        return $false
    }
}

$tests = @(
    @{m='4,-4,2'; h='4,0,5'; e=4},
    @{m='1,2'; h='20,10'; e=18},
    # Additional tests
    @{m='0'; h='0'; e=0},
    @{m='-5,5'; h='5,-5'; e=10},
    @{m='1,3,6'; h='2,4,7'; e=1}
)

$allOK = $true
foreach ($t in $tests) {
    $res = Run-Test -mice $t.m -holes $t.h -expected $t.e
    if (-not $res) { $allOK = $false }
}

if ($allOK) { Write-Host "All tests passed."; exit 0 } else { Write-Host "Some tests failed."; exit 1 }

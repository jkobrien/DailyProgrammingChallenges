<#
Unit tests for Minimize-HeightsII
Run: pwsh -File .\test_minimize_heights_ii.ps1
Exits with code 0 on success, 1 on any failure.
#>

. "$PSScriptRoot\minimize_heights_ii.ps1"

function Test-MinimizeHeights {
    param($Heights, $K, $Expected, $TestName)
    
    $result = Minimize-HeightsII -Heights $Heights -K $K
    if ($result -eq $Expected) {
        Write-Host "[PASS] $TestName - K=$K => $result"
        return $true
    } else {
        Write-Host "[FAIL] $TestName - K=$K => got $result, expected $Expected"
        return $false
    }
}

$failures = 0

# Test cases
if (-not (Test-MinimizeHeights -Heights @(1) -K 5 -Expected 0 -TestName "Test 1")) { $failures++ }
if (-not (Test-MinimizeHeights -Heights @(1,2) -K 1 -Expected 1 -TestName "Test 2")) { $failures++ }
if (-not (Test-MinimizeHeights -Heights @(3,9,12) -K 3 -Expected 3 -TestName "Test 3")) { $failures++ }
if (-not (Test-MinimizeHeights -Heights @(1,5,8,10) -K 2 -Expected 5 -TestName "Test 4")) { $failures++ }
if (-not (Test-MinimizeHeights -Heights @(0,10) -K 5 -Expected 0 -TestName "Test 5")) { $failures++ }

if ($failures -eq 0) {
    Write-Host "All tests passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Failures: $failures" -ForegroundColor Red
    exit 1
}

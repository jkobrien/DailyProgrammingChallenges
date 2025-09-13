<#
Tests for Find-GasStation
Run: pwsh -File .\test_gas_station.ps1
Exits with code 0 on success, non-zero on failure.
#>

. "$PSScriptRoot\gas_station.ps1"

$tests = @(
    @{Gas=@(1,2,3,4,5); Cost=@(3,4,5,1,2); Expected=3; Name='Example 1'},
    @{Gas=@(2,3,4); Cost=@(3,4,3); Expected=-1; Name='Impossible'},
    @{Gas=@(5,1,2,3,4); Cost=@(4,4,1,5,1); Expected=4; Name='Start at last'},
    @{Gas=@(3,3,4); Cost=@(3,4,3); Expected=2; Name='Multiple options'},
    @{Gas=@(); Cost=@(); Expected=-1; Name='Empty arrays'}
)

$failures = 0
$index = 0
foreach ($t in $tests) {
    $index++
    try {
        $res = Find-GasStation -Gas $t.Gas -Cost $t.Cost
    } catch {
        $res = 'ERR'
    }

    if ($res -eq $t.Expected) {
        Write-Host "[PASS] Test $index - $($t.Name): got $res"
    } else {
        Write-Host "[FAIL] Test $index - $($t.Name): got $res, expected $($t.Expected)"
        $failures++
    }
}

if ($failures -eq 0) {
    Write-Host "All tests passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "$failures tests failed." -ForegroundColor Red
    exit 1
}

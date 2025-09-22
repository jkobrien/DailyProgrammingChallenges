<#
Tests for Invoke-NextGreaterCircular
Run: pwsh -File .\test_next_greater_circular.ps1
#>

. "$PSScriptRoot\next_greater_circular.ps1"

$cases = @(
    @{Input=@(1,2,1); Expected=@(2,-1,2); Name='Simple'},
    @{Input=@(3,8,4,1,2); Expected=@(8,-1,8,2,3); Name='Mixed'},
    @{Input=@(1,1,1); Expected=@(-1,-1,-1); Name='All equal'},
    @{Input=@(5,4,3,2,1); Expected=@(-1,5,5,5,5); Name='Strictly decreasing'},
    @{Input=@(); Expected=@(); Name='Empty array'}
)

$failures = 0
$index = 0
foreach ($c in $cases) {
    $index++
    try {
        $res = Invoke-NextGreaterCircular -Nums $c.Input
    } catch {
        $res = "ERR: $_"
    }

    # Compare sequences
    $match = $true
    if ($res -is [string]) { $match = $false } else {
        if ($res.Count -ne $c.Expected.Count) { $match = $false } else {
            for ($i=0; $i -lt $res.Count; $i++) { if ($res[$i] -ne $c.Expected[$i]) { $match = $false; break } }
        }
    }

    if ($match) {
        Write-Host "[PASS] Test $index - $($c.Name): ($([string]::Join(',', $c.Input))) -> ($([string]::Join(',', $res)))"
    } else {
        Write-Host "[FAIL] Test $index - $($c.Name): got ($([string]::Join(',', $res))), expected ($([string]::Join(',', $c.Expected)))"
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

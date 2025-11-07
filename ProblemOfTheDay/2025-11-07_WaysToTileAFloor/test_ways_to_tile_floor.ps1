<#
Test script for Ways To Tile A Floor (POTD 2025-11-07)
#>
. "$PSScriptRoot/ways_to_tile_floor.ps1"

function Test-WaysToTileFloor {
    $tests = @(
        @{ n = 1; expected = 1 },
        @{ n = 2; expected = 2 },
        @{ n = 3; expected = 3 },
        @{ n = 4; expected = 5 },
        @{ n = 5; expected = 8 },
        @{ n = 10; expected = 89 }
    )
    $allPassed = $true
    foreach ($test in $tests) {
        $result = Get-WaysToTileFloor -n $test.n
        if ($result -ne $test.expected) {
            Write-Host "FAILED: n=$($test.n) Expected=$($test.expected) Got=$result" -ForegroundColor Red
            $allPassed = $false
        } else {
            Write-Host "PASSED: n=$($test.n) => $result" -ForegroundColor Green
        }
    }
    if ($allPassed) {
        Write-Host "All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed." -ForegroundColor Red
    }
}

Test-WaysToTileFloor

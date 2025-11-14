# Simple test runner for Minimum Cost to Merge Stones
. "$PSScriptRoot\minimum_cost_merge_stones.ps1"

Write-Host "`n=== MINIMUM COST TO MERGE STONES - TEST SUITE ===" -ForegroundColor Cyan
Write-Host ""

$testsPassed = 0
$testsFailed = 0

function Test-Solution {
    param($TestName, $Stones, $K, $Expected)
    
    Write-Host "$TestName" -ForegroundColor Yellow
    Write-Host "  Input: stones = [$($Stones -join ', ')], k = $K"
    Write-Host "  Expected: $Expected"
    
    $result = Get-MinimumCostToMergeStones -stones $Stones -k $K
    Write-Host "  Actual:   $result" -ForegroundColor $(if ($result -eq $Expected) { "Green" } else { "Red" })
    
    if ($result -eq $Expected) {
        Write-Host "  [PASSED]`n" -ForegroundColor Green
        $script:testsPassed++
    } else {
        Write-Host "  [FAILED]`n" -ForegroundColor Red
        $script:testsFailed++
    }
}

# GeeksforGeeks Examples
Write-Host "[PROVIDED EXAMPLES]" -ForegroundColor Magenta
Test-Solution "Example 1: Basic case" @(1, 2, 3) 2 9
Test-Solution "Example 2: Larger array" @(1, 5, 3, 2, 4) 2 35
Test-Solution "Example 3: Impossible case" @(1, 5, 3, 2, 4) 4 -1

# Edge Cases
Write-Host "`n[EDGE CASES]" -ForegroundColor Magenta
Test-Solution "Single pile" @(5) 2 0
Test-Solution "Two piles" @(3, 5) 2 8
Test-Solution "All same values" @(2, 2, 2, 2) 2 16
Test-Solution "Impossible merge" @(1, 2, 3) 3 -1

# K=3 Scenarios
Write-Host "`n[K=3 SCENARIOS]" -ForegroundColor Magenta
Test-Solution "K=3 Valid merge" @(3, 2, 4, 1) 3 20
Test-Solution "K=3 Five piles" @(1, 2, 3, 4, 5) 3 30
Test-Solution "K=3 Seven piles" @(1, 1, 1, 1, 1, 1, 1) 3 21

# Larger Arrays
Write-Host "`n[LARGER ARRAYS]" -ForegroundColor Magenta
Test-Solution "Six piles" @(1, 2, 3, 4, 5, 6) 2 63
Test-Solution "Eight piles" @(5, 3, 8, 2, 7, 4, 6, 1) 2 144
Test-Solution "Six piles impossible" @(2, 3, 4, 5, 6, 7) 3 -1

# Special Patterns
Write-Host "`n[SPECIAL PATTERNS]" -ForegroundColor Magenta
Test-Solution "Ascending sequence" @(1, 2, 3, 4) 2 30
Test-Solution "Descending sequence" @(4, 3, 2, 1) 2 30
Test-Solution "Large k value" @(1, 2, 3, 4, 5, 6, 7) 7 28
Test-Solution "Maximum stones value" @(100, 100, 100) 2 500

# Boundary Conditions
Write-Host "`n[BOUNDARY CONDITIONS]" -ForegroundColor Magenta
Test-Solution "Minimum valid merge" @(1, 1) 2 2
Test-Solution "Four ones" @(1, 1, 1, 1) 2 8
Test-Solution "Exact k piles" @(5, 10, 15) 3 30

# Summary
Write-Host "`n=====================================" -ForegroundColor Cyan
Write-Host "TEST SUMMARY" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
$total = $testsPassed + $testsFailed
Write-Host "Total:  $total"
Write-Host "Passed: $testsPassed" -ForegroundColor Green
Write-Host "Failed: $testsFailed" -ForegroundColor $(if ($testsFailed -eq 0) { "Green" } else { "Red" })
$passRate = if ($total -gt 0) { [math]::Round(($testsPassed / $total) * 100, 2) } else { 0 }
Write-Host "Pass Rate: $passRate%`n"

if ($testsFailed -eq 0) {
    Write-Host "ALL TESTS PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "SOME TESTS FAILED" -ForegroundColor Red
    exit 1
}

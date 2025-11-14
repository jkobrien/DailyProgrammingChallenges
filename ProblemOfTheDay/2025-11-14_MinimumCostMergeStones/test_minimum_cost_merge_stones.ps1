<#
.SYNOPSIS
    Comprehensive test suite for Minimum Cost to Merge Stones solution

.DESCRIPTION
    Tests the Get-MinimumCostToMergeStones function with various test cases
    including edge cases, provided examples, and additional scenarios.
#>

# Import the solution
. "$PSScriptRoot\minimum_cost_merge_stones.ps1"

# Test result tracking
$script:testsPassed = 0
$script:testsFailed = 0
$script:testResults = @()

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Stones,
        [int]$K,
        [int]$Expected
    )
    
    Write-Host "`n$TestName" -ForegroundColor Cyan
    Write-Host ("=" * 60) -ForegroundColor Gray
    Write-Host "Input: stones = [$($Stones -join ', ')], k = $K"
    Write-Host "Expected: $Expected"
    
    try {
        $result = Get-MinimumCostToMergeStones -stones $Stones -k $K
        Write-Host "Actual:   $result" -ForegroundColor $(if ($result -eq $Expected) { "Green" } else { "Red" })
        
        if ($result -eq $Expected) {
            Write-Host "[PASSED]" -ForegroundColor Green
            $script:testsPassed++
            $script:testResults += [PSCustomObject]@{
                Test = $TestName
                Status = "PASSED"
                Expected = $Expected
                Actual = $result
            }
        }
        else {
            Write-Host "[FAILED]" -ForegroundColor Red
            $script:testsFailed++
            $script:testResults += [PSCustomObject]@{
                Test = $TestName
                Status = "FAILED"
                Expected = $Expected
                Actual = $result
            }
        }
    }
    catch {
        Write-Host "[EXCEPTION]: $_" -ForegroundColor Red
        $script:testsFailed++
        $script:testResults += [PSCustomObject]@{
            Test = $TestName
            Status = "EXCEPTION"
            Expected = $Expected
            Actual = "Exception: $_"
        }
    }
}

# Run all tests
Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║   MINIMUM COST TO MERGE STONES - COMPREHENSIVE TEST SUITE   ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta

# ============================================================
# PROVIDED EXAMPLES FROM GEEKSFORGEEKS
# ============================================================
Write-Host "`n[PROVIDED EXAMPLES]" -ForegroundColor Yellow

Test-Case `
    -TestName "Example 1: Basic case with k=2" `
    -Stones @(1, 2, 3) `
    -K 2 `
    -Expected 9

Test-Case `
    -TestName "Example 2: Larger array with k=2" `
    -Stones @(1, 5, 3, 2, 4) `
    -K 2 `
    -Expected 35

Test-Case `
    -TestName "Example 3: Impossible case with k equals 4" `
    -Stones @(1, 5, 3, 2, 4) `
    -K 4 `
    -Expected -1

# ============================================================
# EDGE CASES
# ============================================================
Write-Host "`n`n[EDGE CASES]" -ForegroundColor Yellow

Test-Case `
    -TestName "Edge 1: Single pile already merged" `
    -Stones @(5) `
    -K 2 `
    -Expected 0

Test-Case `
    -TestName "Edge 2: Two piles with k=2" `
    -Stones @(3, 5) `
    -K 2 `
    -Expected 8

Test-Case `
    -TestName "Edge 3: All same values" `
    -Stones @(2, 2, 2, 2) `
    -K 2 `
    -Expected 16

Test-Case `
    -TestName "Edge 4: Impossible - 3 piles with k equals 3" `
    -Stones @(1, 2, 3) `
    -K 3 `
    -Expected -1

# ============================================================
# K = 3 SCENARIOS
# ============================================================
Write-Host "`n`n[K=3 SCENARIOS]" -ForegroundColor Yellow

Test-Case `
    -TestName "K=3 Test 1: Valid merge" `
    -Stones @(3, 2, 4, 1) `
    -K 3 `
    -Expected 20

Test-Case `
    -TestName "K=3 Test 2: Five piles" `
    -Stones @(1, 2, 3, 4, 5) `
    -K 3 `
    -Expected 30

Test-Case `
    -TestName "K=3 Test 3: Seven piles" `
    -Stones @(1, 1, 1, 1, 1, 1, 1) `
    -K 3 `
    -Expected 21

# ============================================================
# LARGER ARRAYS
# ============================================================
Write-Host "`n`n[LARGER ARRAYS]" -ForegroundColor Yellow

Test-Case `
    -TestName "Large 1: Six piles with k=2" `
    -Stones @(1, 2, 3, 4, 5, 6) `
    -K 2 `
    -Expected 63

Test-Case `
    -TestName "Large 2: Eight piles with k=2" `
    -Stones @(5, 3, 8, 2, 7, 4, 6, 1) `
    -K 2 `
    -Expected 144

Test-Case `
    -TestName "Large 3: Six piles with k equals 3" `
    -Stones @(2, 3, 4, 5, 6, 7) `
    -K 3 `
    -Expected -1

# ============================================================
# SPECIAL PATTERNS
# ============================================================
Write-Host "`n`n[SPECIAL PATTERNS]" -ForegroundColor Yellow

Test-Case `
    -TestName "Pattern 1: Ascending sequence" `
    -Stones @(1, 2, 3, 4) `
    -K 2 `
    -Expected 30

Test-Case `
    -TestName "Pattern 2: Descending sequence" `
    -Stones @(4, 3, 2, 1) `
    -K 2 `
    -Expected 30

Test-Case `
    -TestName "Pattern 3: Large k value" `
    -Stones @(1, 2, 3, 4, 5, 6, 7) `
    -K 7 `
    -Expected 28

Test-Case `
    -TestName "Pattern 4: Maximum stones value" `
    -Stones @(100, 100, 100) `
    -K 2 `
    -Expected 500

# ============================================================
# BOUNDARY CONDITIONS
# ============================================================
Write-Host "`n`n[BOUNDARY CONDITIONS]" -ForegroundColor Yellow

Test-Case `
    -TestName "Boundary 1: Minimum valid merge" `
    -Stones @(1, 1) `
    -K 2 `
    -Expected 2

Test-Case `
    -TestName "Boundary 2: Four piles k equals 2 all ones" `
    -Stones @(1, 1, 1, 1) `
    -K 2 `
    -Expected 8

Test-Case `
    -TestName "Boundary 3: Exact k piles" `
    -Stones @(5, 10, 15) `
    -K 3 `
    -Expected 30

# ============================================================
# SUMMARY
# ============================================================
Write-Host "`n`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║                         TEST SUMMARY                         ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta

$totalTests = $script:testsPassed + $script:testsFailed
$passRate = if ($totalTests -gt 0) { [math]::Round(($script:testsPassed / $totalTests) * 100, 2) } else { 0 }

Write-Host "`nTotal Tests:  $totalTests" -ForegroundColor White
Write-Host "Passed:       $script:testsPassed" -ForegroundColor Green
Write-Host "Failed:       $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host "Pass Rate:    $passRate%" -ForegroundColor $(if ($passRate -eq 100) { "Green" } elseif ($passRate -ge 80) { "Yellow" } else { "Red" })

if ($script:testsFailed -gt 0) {
    Write-Host "`n[FAILED TESTS]" -ForegroundColor Red
    $script:testResults | Where-Object { $_.Status -ne "PASSED" } | ForEach-Object {
        Write-Host "  - $($_.Test): Expected $($_.Expected), Got $($_.Actual)" -ForegroundColor Red
    }
}

Write-Host "`n" -NoNewline
if ($script:testsFailed -eq 0) {
    Write-Host "ALL TESTS PASSED!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "SOME TESTS FAILED" -ForegroundColor Red
    exit 1
}

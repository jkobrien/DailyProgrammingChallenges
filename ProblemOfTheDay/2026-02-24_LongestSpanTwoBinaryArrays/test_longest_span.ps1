<#
.SYNOPSIS
    Test suite for Longest Span in Two Binary Arrays solution

.DESCRIPTION
    Comprehensive tests including example cases, edge cases, and randomized tests
    comparing the optimized solution against the brute force implementation.
#>

# Import the solution
. "$PSScriptRoot\longest_span_two_binary_arrays.ps1"

$script:TestsPassed = 0
$script:TestsFailed = 0

function Test-Case {
    param (
        [string]$Name,
        [int[]]$a1,
        [int[]]$a2,
        [int]$Expected
    )

    $result = Get-LongestSpan -a1 $a1 -a2 $a2

    if ($result -eq $Expected) {
        Write-Host "[PASS] $Name" -ForegroundColor Green
        $script:TestsPassed++
    }
    else {
        Write-Host "[FAIL] $Name" -ForegroundColor Red
        Write-Host "       a1       = [$($a1 -join ', ')]"
        Write-Host "       a2       = [$($a2 -join ', ')]"
        Write-Host "       Expected = $Expected"
        Write-Host "       Got      = $result"
        $script:TestsFailed++
    }
}

function Test-AgainstBruteForce {
    param (
        [string]$Name,
        [int[]]$a1,
        [int[]]$a2
    )

    $optimized = Get-LongestSpan -a1 $a1 -a2 $a2
    $bruteForce = Get-LongestSpanBruteForce -a1 $a1 -a2 $a2

    if ($optimized -eq $bruteForce) {
        Write-Host "[PASS] $Name (optimized=$optimized, brute=$bruteForce)" -ForegroundColor Green
        $script:TestsPassed++
    }
    else {
        Write-Host "[FAIL] $Name" -ForegroundColor Red
        Write-Host "       a1         = [$($a1 -join ', ')]"
        Write-Host "       a2         = [$($a2 -join ', ')]"
        Write-Host "       Optimized  = $optimized"
        Write-Host "       BruteForce = $bruteForce"
        $script:TestsFailed++
    }
}

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Testing: Longest Span in Two Binary Arrays" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# ===============================================
# EXAMPLE TEST CASES
# ===============================================
Write-Host "--- Example Test Cases ---" -ForegroundColor Yellow

Test-Case -Name "Example 1: Basic case" `
    -a1 @(0, 1, 0, 0, 0, 0) `
    -a2 @(1, 0, 1, 0, 0, 1) `
    -Expected 4

Test-Case -Name "Example 2: Longer span" `
    -a1 @(0, 1, 0, 1, 1, 1, 1) `
    -a2 @(1, 1, 1, 1, 1, 0, 1) `
    -Expected 6

Test-Case -Name "Example 3: No common span" `
    -a1 @(0, 0, 0) `
    -a2 @(1, 1, 1) `
    -Expected 0

# ===============================================
# EDGE CASES
# ===============================================
Write-Host ""
Write-Host "--- Edge Cases ---" -ForegroundColor Yellow

Test-Case -Name "Single element - equal" `
    -a1 @(1) `
    -a2 @(1) `
    -Expected 1

Test-Case -Name "Single element - unequal" `
    -a1 @(0) `
    -a2 @(1) `
    -Expected 0

Test-Case -Name "Empty arrays" `
    -a1 @() `
    -a2 @() `
    -Expected 0

Test-Case -Name "Two elements - equal" `
    -a1 @(0, 1) `
    -a2 @(0, 1) `
    -Expected 2

Test-Case -Name "Two elements - swap gives same sum" `
    -a1 @(0, 1) `
    -a2 @(1, 0) `
    -Expected 2

Test-Case -Name "Identical arrays" `
    -a1 @(1, 0, 1, 1, 0) `
    -a2 @(1, 0, 1, 1, 0) `
    -Expected 5

Test-Case -Name "All zeros" `
    -a1 @(0, 0, 0, 0, 0) `
    -a2 @(0, 0, 0, 0, 0) `
    -Expected 5

Test-Case -Name "All ones" `
    -a1 @(1, 1, 1, 1) `
    -a2 @(1, 1, 1, 1) `
    -Expected 4

# ===============================================
# SPECIAL CASES
# ===============================================
Write-Host ""
Write-Host "--- Special Cases ---" -ForegroundColor Yellow

Test-Case -Name "Span at beginning" `
    -a1 @(1, 0, 0, 0, 1) `
    -a2 @(1, 0, 1, 1, 1) `
    -Expected 2

Test-Case -Name "Span at end" `
    -a1 @(1, 1, 0, 0, 1) `
    -a2 @(0, 0, 0, 0, 1) `
    -Expected 3

Test-Case -Name "Multiple spans - longest in middle" `
    -a1 @(0, 1, 0, 1, 0, 1, 0) `
    -a2 @(1, 0, 1, 0, 1, 0, 1) `
    -Expected 6

Test-Case -Name "Alternating pattern" `
    -a1 @(0, 1, 0, 1, 0, 1) `
    -a2 @(1, 0, 1, 0, 1, 0) `
    -Expected 6

# ===============================================
# VERIFICATION AGAINST BRUTE FORCE
# ===============================================
Write-Host ""
Write-Host "--- Verification Against Brute Force ---" -ForegroundColor Yellow

# Fixed test cases
Test-AgainstBruteForce -Name "Verify Example 1" `
    -a1 @(0, 1, 0, 0, 0, 0) `
    -a2 @(1, 0, 1, 0, 0, 1)

Test-AgainstBruteForce -Name "Verify Example 2" `
    -a1 @(0, 1, 0, 1, 1, 1, 1) `
    -a2 @(1, 1, 1, 1, 1, 0, 1)

# Random test cases
Write-Host ""
Write-Host "--- Random Test Cases ---" -ForegroundColor Yellow

for ($t = 1; $t -le 10; $t++) {
    $size = Get-Random -Minimum 5 -Maximum 20
    $a1 = @()
    $a2 = @()
    for ($i = 0; $i -lt $size; $i++) {
        $a1 += Get-Random -Minimum 0 -Maximum 2
        $a2 += Get-Random -Minimum 0 -Maximum 2
    }

    Test-AgainstBruteForce -Name "Random test $t (size=$size)" -a1 $a1 -a2 $a2
}

# ===============================================
# SUMMARY
# ===============================================
Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($script:TestsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Some tests failed." -ForegroundColor Red
    exit 1
}
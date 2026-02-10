<#
.SYNOPSIS
    Tests for Koko Eating Bananas solution.

.DESCRIPTION
    Dot-sources the solution and runs a battery of test cases covering
    basic examples, edge cases, and large inputs. Outputs PASS / FAIL
    for each test, and a final summary.
#>

# -- Load the solution ------------------------------------------------
. "$PSScriptRoot\Solution.ps1"

# -- Test harness ------------------------------------------------------
$script:passed = 0
$script:failed = 0

function Test-Case {
    param(
        [string]$Name,
        [int[]]$Piles,
        [int]$Hours,
        [int]$Expected
    )

    $actual = Get-MinEatingSpeed -Piles $Piles -Hours $Hours

    if ($actual -eq $Expected) {
        Write-Host "  [PASS] $Name" -ForegroundColor Green
        $script:passed++
    }
    else {
        Write-Host "  [FAIL] $Name  (expected $Expected, got $actual)" -ForegroundColor Red
        $script:failed++
    }
}

# -- Test cases --------------------------------------------------------
Write-Host ""
Write-Host "=== Koko Eating Bananas - Test Suite ===" -ForegroundColor Cyan
Write-Host ""

# GFG Example 1
Test-Case -Name "GFG Example 1: [5,10,3] k=4" -Piles @(5, 10, 3) -Hours 4 -Expected 5

# GFG Example 2
Test-Case -Name "GFG Example 2: [5,10,15,20] k=7" -Piles @(5, 10, 15, 20) -Hours 7 -Expected 10

# Single pile, exactly enough hours
Test-Case -Name "Single pile: [8] k=8" -Piles @(8) -Hours 8 -Expected 1

# Single pile, must finish in 1 hour
Test-Case -Name "Single pile, 1 hour: [100] k=1" -Piles @(100) -Hours 1 -Expected 100

# All piles equal
Test-Case -Name "Equal piles: [6,6,6] k=3" -Piles @(6, 6, 6) -Hours 3 -Expected 6

# Hours equals number of piles -> speed = max pile
Test-Case -Name "Hours = pile count: [3,6,7,11] k=4" -Piles @(3, 6, 7, 11) -Hours 4 -Expected 11

# Many small piles
Test-Case -Name "Many 1-banana piles: k = n" -Piles @(1, 1, 1, 1, 1) -Hours 5 -Expected 1

# k much larger than needed -> speed = 1
Test-Case -Name "Generous time: [4,3,2] k=100" -Piles @(4, 3, 2) -Hours 100 -Expected 1

# Tight schedule
Test-Case -Name "Tight: [30,11,23,4,20] k=5" -Piles @(30, 11, 23, 4, 20) -Hours 5 -Expected 30

# Tight schedule with extra hour
Test-Case -Name "Slightly loose: [30,11,23,4,20] k=6" -Piles @(30, 11, 23, 4, 20) -Hours 6 -Expected 23

# Large single pile
Test-Case -Name "Large single pile" -Piles @(312884470) -Hours 312884469 -Expected 2

# Two piles
Test-Case -Name "Two piles: [1000000, 1000000] k=3" -Piles @(1000000, 1000000) -Hours 3 -Expected 1000000

# -- Summary -----------------------------------------------------------
Write-Host ""
$bar = "=" * 45
Write-Host $bar -ForegroundColor Cyan
$summaryColor = if ($script:failed -eq 0) { "Green" } else { "Red" }
Write-Host "  Results: $($script:passed) passed, $($script:failed) failed" -ForegroundColor $summaryColor
Write-Host $bar -ForegroundColor Cyan
Write-Host ""

if ($script:failed -gt 0) { exit 1 }

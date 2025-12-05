<#
.SYNOPSIS
    Comprehensive test suite for Walls Coloring II solution.

.DESCRIPTION
    Tests the Get-MinCostToPaintWalls function with various test cases including
    edge cases, basic examples, and complex scenarios.
#>

# Import the solution
. "$PSScriptRoot\walls_coloring_ii.ps1"

# Test counter
$script:TestsPassed = 0
$script:TestsFailed = 0

function Test-WallsColoring {
    param(
        [string]$TestName,
        [array]$Costs,
        [int]$Expected
    )
    
    Write-Host ""
    Write-Host "Test: $TestName" -ForegroundColor Yellow
    if ($Costs.Count -gt 0) {
        Write-Host "Input costs: $($Costs.Count) walls, $($Costs[0].Count) colors"
    }
    else {
        Write-Host "Input costs: 0 walls"
    }
    
    $result = Get-MinCostToPaintWalls -costs $Costs
    
    if ($result -eq $Expected) {
        Write-Host "PASSED - Output: $result (Expected: $Expected)" -ForegroundColor Green
        $script:TestsPassed++
    }
    else {
        Write-Host "FAILED - Output: $result (Expected: $Expected)" -ForegroundColor Red
        $script:TestsFailed++
    }
}

$separator = "======================================================================"

Write-Host $separator -ForegroundColor Cyan
Write-Host "WALLS COLORING II - TEST SUITE" -ForegroundColor Cyan
Write-Host $separator -ForegroundColor Cyan

# Test 1: Basic example from problem statement
Test-WallsColoring -TestName "Example 1: 4 walls, 3 colors" -Costs @(@(1, 5, 7), @(5, 8, 4), @(3, 2, 9), @(1, 2, 4)) -Expected 8

# Test 2: Impossible case - only 1 color, multiple walls
Test-WallsColoring -TestName "Example 2: Impossible case" -Costs @(@(5), @(4), @(9), @(2), @(1)) -Expected -1

# Test 3: Single wall - should return minimum color cost  
Test-WallsColoring -TestName "Edge case: Single wall" -Costs @(,@(3, 5, 2, 9)) -Expected 2

# Test 4: Two walls, two colors
Test-WallsColoring -TestName "Basic: 2 walls, 2 colors" -Costs @(@(1, 3), @(2, 4)) -Expected 5

# Test 5: Three walls, three colors (optimal path check)
Test-WallsColoring -TestName "Medium: 3 walls, 3 colors" -Costs @(@(3, 5, 3), @(6, 17, 6), @(7, 13, 18)) -Expected 16

# Test 6: All same costs
Test-WallsColoring -TestName "Edge case: All same costs" -Costs @(@(5, 5, 5), @(5, 5, 5), @(5, 5, 5)) -Expected 15

# Test 7: Two colors, multiple walls
Test-WallsColoring -TestName "Alternating: 4 walls, 2 colors" -Costs @(@(1, 2), @(2, 1), @(1, 2), @(2, 1)) -Expected 4

# Test 8: Large costs
Test-WallsColoring -TestName "Large values: High cost numbers" -Costs @(@(10000, 20000, 30000), @(15000, 25000, 35000), @(12000, 22000, 32000)) -Expected 47000

# Test 9: Many colors, few walls
Test-WallsColoring -TestName "Wide: 2 walls, 5 colors" -Costs @(@(10, 20, 30, 40, 50), @(15, 25, 35, 45, 55)) -Expected 35

# Test 10: Many walls, few colors
Test-WallsColoring -TestName "Tall: 5 walls, 2 colors" -Costs @(@(1, 2), @(3, 2), @(1, 4), @(5, 1), @(2, 3)) -Expected 7

# Test 11: Optimal choice requires second minimum
Test-WallsColoring -TestName "Second minimum usage" -Costs @(@(1, 100, 100), @(100, 100, 1), @(1, 100, 100)) -Expected 3

# Test 12: Increasing costs
Test-WallsColoring -TestName "Pattern: Increasing costs" -Costs @(@(1, 2, 3), @(2, 3, 4), @(3, 4, 5), @(4, 5, 6)) -Expected 12

# Test 13: Empty walls (edge case)
Test-WallsColoring -TestName "Edge case: No walls" -Costs @() -Expected 0

# Test 14: Complex scenario with optimal path
Test-WallsColoring -TestName "Complex: 6 walls, 4 colors" -Costs @(@(1, 3, 5, 7), @(5, 6, 7, 8), @(2, 4, 6, 8), @(7, 3, 2, 9), @(1, 4, 7, 9), @(3, 5, 1, 8)) -Expected 13

# Test 15: Two walls with very different costs
Test-WallsColoring -TestName "Contrast: High vs low costs" -Costs @(@(1, 1000, 2000), @(2000, 1000, 1)) -Expected 2

# Summary
Write-Host ""
Write-Host $separator -ForegroundColor Cyan
Write-Host "TEST SUMMARY" -ForegroundColor Cyan
Write-Host $separator -ForegroundColor Cyan
Write-Host "Tests Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Tests Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })
Write-Host "Total Tests:  $($script:TestsPassed + $script:TestsFailed)"
Write-Host $separator -ForegroundColor Cyan

if ($script:TestsFailed -eq 0) {
    Write-Host ""
    Write-Host "All tests passed successfully!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host ""
    Write-Host "Some tests failed. Please review the output above." -ForegroundColor Red
    exit 1
}

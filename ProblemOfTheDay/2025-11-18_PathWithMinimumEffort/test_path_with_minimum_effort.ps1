<#
.SYNOPSIS
    Test suite for Path With Minimum Effort solution

.DESCRIPTION
    Comprehensive test cases including examples from problem statement,
    edge cases, and additional validation scenarios.
#>

# Import the solution
. "$PSScriptRoot\path_with_minimum_effort.ps1"

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-PathEffort {
    param(
        [string]$TestName,
        [int[][]]$Matrix,
        [int]$Expected
    )
    
    Write-Host "`n--- $TestName ---" -ForegroundColor Cyan
    
    # Display input
    Write-Host "Input Matrix:" -ForegroundColor White
    foreach ($row in $Matrix) {
        Write-Host "  [$($row -join ', ')]"
    }
    
    # Run the function
    $result = Get-MinimumEffortPath -matrix $Matrix
    
    # Check result
    $passed = $result -eq $Expected
    
    if ($passed) {
        Write-Host "PASSED" -ForegroundColor Green
        Write-Host "  Output: $result (Expected: $Expected)" -ForegroundColor Green
        $script:TestsPassed++
    } else {
        Write-Host "FAILED" -ForegroundColor Red
        Write-Host "  Output: $result" -ForegroundColor Red
        Write-Host "  Expected: $Expected" -ForegroundColor Red
        $script:TestsFailed++
    }
    
    $script:TestResults += [PSCustomObject]@{
        TestName = $TestName
        Passed = $passed
        Result = $result
        Expected = $Expected
    }
    
    return $passed
}

Write-Host "============================================" -ForegroundColor Magenta
Write-Host "  Path With Minimum Effort - Test Suite" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta

# Test 1: Example 1 from problem statement
Test-PathEffort -TestName "Test 1: Example 1 (2x4 matrix)" -Matrix @(@(7, 2, 6, 5), @(3, 1, 10, 8)) -Expected 4

# Test 2: Example 2 from problem statement
Test-PathEffort -TestName "Test 2: Example 2 (5x4 matrix with path of 0)" -Matrix @(@(2, 2, 2, 1), @(8, 1, 2, 7), @(2, 2, 2, 8), @(2, 1, 4, 7), @(2, 2, 2, 2)) -Expected 0

# Test 3: Single cell
Test-PathEffort -TestName "Test 3: Single cell (edge case)" -Matrix @(@(5)) -Expected 0

# Test 4: All same values
Test-PathEffort -TestName "Test 4: All same values" -Matrix @(@(1, 1, 1), @(1, 1, 1), @(1, 1, 1)) -Expected 0

# Test 5: Straight line (1 row)
Test-PathEffort -TestName "Test 5: Single row" -Matrix @(@(1, 2, 3, 4, 5)) -Expected 1

# Test 6: Straight line (1 column)
Test-PathEffort -TestName "Test 6: Single column" -Matrix @(@(1), @(2), @(3), @(4), @(5)) -Expected 1

# Test 7: Large differences
Test-PathEffort -TestName "Test 7: Large differences" -Matrix @(@(1, 100, 1), @(1, 1, 1), @(1, 100, 1)) -Expected 0

# Test 8: Zigzag path required
Test-PathEffort -TestName "Test 8: Zigzag path" -Matrix @(@(1, 2, 2), @(3, 8, 2), @(5, 3, 5)) -Expected 2

# Test 9: Large values (path: 1000000 -> 1000000 -> 1000000 -> 1000000)
Test-PathEffort -TestName "Test 9: Large values" -Matrix @(@(1000000, 999999, 1000000), @(1000000, 1000000, 1000000), @(999999, 1000000, 1000000)) -Expected 0

# Test 10: Increasing values (path: 1->2->3->6->9 or 1->4->5->6->9 has effort 3)
Test-PathEffort -TestName "Test 10: Increasing diagonal" -Matrix @(@(1, 2, 3), @(4, 5, 6), @(7, 8, 9)) -Expected 3

# Test 11: 2x2 matrix
Test-PathEffort -TestName "Test 11: 2x2 matrix" -Matrix @(@(1, 10), @(5, 2)) -Expected 4

# Test 12: Complex path
Test-PathEffort -TestName "Test 12: Complex path selection" -Matrix @(@(1, 2, 1, 1, 1), @(1, 2, 1, 2, 1), @(1, 2, 1, 2, 1), @(1, 2, 1, 2, 1), @(1, 1, 1, 2, 1)) -Expected 0

# Test 13: Barrier test
Test-PathEffort -TestName "Test 13: High barrier in middle" -Matrix @(@(1, 1, 100, 1, 1), @(1, 1, 100, 1, 1), @(1, 1, 1, 1, 1), @(1, 1, 100, 1, 1), @(1, 1, 100, 1, 1)) -Expected 0

# Print summary
Write-Host "`n============================================" -ForegroundColor Magenta
Write-Host "  Test Summary" -ForegroundColor Magenta
Write-Host "============================================" -ForegroundColor Magenta
Write-Host "Total Tests: $($script:TestsPassed + $script:TestsFailed)" -ForegroundColor White
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($script:TestsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed. Please review the results above." -ForegroundColor Red
    Write-Host "`nFailed Tests:" -ForegroundColor Yellow
    $script:TestResults | Where-Object { -not $_.Passed } | ForEach-Object {
        Write-Host "  - $($_.TestName): Got $($_.Result), Expected $($_.Expected)" -ForegroundColor Red
    }
    exit 1
}

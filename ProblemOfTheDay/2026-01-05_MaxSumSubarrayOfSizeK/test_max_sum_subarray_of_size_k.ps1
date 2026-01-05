<#
.SYNOPSIS
    Test suite for Max Sum Subarray of size K solution

.DESCRIPTION
    Comprehensive test cases to validate the Get-MaxSumSubarray function
    Tests cover normal cases, edge cases, and boundary conditions
#>

# Import the solution by dot-sourcing
. "$PSScriptRoot\max_sum_subarray_of_size_k.ps1"

# Test counter
$script:testsPassed = 0
$script:testsFailed = 0

function Test-MaxSumSubarray {
    param(
        [string]$TestName,
        [int[]]$InputArray,
        [int]$K,
        [int]$Expected
    )
    
    Write-Host "`nTest: $TestName" -ForegroundColor Cyan
    Write-Host "Input: arr = [$($InputArray -join ', ')], k = $K"
    
    $result = Get-MaxSumSubarray -arr $InputArray -k $K
    
    if ($result -eq $Expected) {
        Write-Host "PASSED: Got $result (expected $Expected)" -ForegroundColor Green
        $script:testsPassed++
    } else {
        Write-Host "FAILED: Got $result but expected $Expected" -ForegroundColor Red
        $script:testsFailed++
    }
}

# ============================================================================
# TEST SUITE
# ============================================================================

Write-Host "`n=====================================" -ForegroundColor Yellow
Write-Host "Max Sum Subarray of size K - Test Suite" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow

# Test 1: Basic example from problem
Test-MaxSumSubarray -TestName "Example 1: Basic case with positive numbers" -InputArray @(100, 200, 300, 400) -K 2 -Expected 700

# Test 2: Longer array from problem
Test-MaxSumSubarray -TestName "Example 2: Larger array" -InputArray @(1, 4, 2, 10, 23, 3, 1, 0, 20) -K 4 -Expected 39

# Test 3: k greater than array length
Test-MaxSumSubarray -TestName "Example 3: k > array length" -InputArray @(2, 3) -K 3 -Expected -1

# Test 4: k equals array length
Test-MaxSumSubarray -TestName "k equals array length" -InputArray @(5, 10, 15, 20) -K 4 -Expected 50

# Test 5: k = 1 (single element window)
Test-MaxSumSubarray -TestName "Window size of 1" -InputArray @(3, 7, 2, 9, 1, 5) -K 1 -Expected 9

# Test 6: All negative numbers
Test-MaxSumSubarray -TestName "Array with all negative numbers" -InputArray @(-5, -2, -8, -1, -4) -K 3 -Expected -11

# Test 7: Mixed positive and negative
Test-MaxSumSubarray -TestName "Mixed positive and negative numbers" -InputArray @(-1, 2, 3, -5, 8, 1) -K 3 -Expected 6

# Test 8: Array with zeros
Test-MaxSumSubarray -TestName "Array containing zeros" -InputArray @(0, 5, 0, 10, 0) -K 2 -Expected 10

# Test 9: All same numbers
Test-MaxSumSubarray -TestName "Array with all same numbers" -InputArray @(5, 5, 5, 5, 5) -K 3 -Expected 15

# Test 10: Large numbers
Test-MaxSumSubarray -TestName "Array with large numbers" -InputArray @(100000, 200000, 50000, 300000) -K 2 -Expected 350000

# Test 11: Two element array, k=2
Test-MaxSumSubarray -TestName "Two elements, window size 2" -InputArray @(10, 20) -K 2 -Expected 30

# Test 12: Alternating high and low values
Test-MaxSumSubarray -TestName "Alternating high and low values" -InputArray @(1, 100, 1, 100, 1, 100) -K 2 -Expected 101

# Test 13: Decreasing sequence
Test-MaxSumSubarray -TestName "Decreasing sequence" -InputArray @(10, 9, 8, 7, 6, 5) -K 3 -Expected 27

# Test 14: Increasing sequence
Test-MaxSumSubarray -TestName "Increasing sequence" -InputArray @(1, 2, 3, 4, 5, 6) -K 3 -Expected 15

# Test 15: Single element array
Test-MaxSumSubarray -TestName "Single element array" -InputArray @(42) -K 1 -Expected 42

# ============================================================================
# TEST SUMMARY
# ============================================================================

Write-Host "`n=====================================" -ForegroundColor Yellow
Write-Host "Test Summary" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Yellow

$totalTests = $script:testsPassed + $script:testsFailed
Write-Host "Total Tests: $totalTests" -ForegroundColor Cyan
Write-Host "Passed: $script:testsPassed" -ForegroundColor Green
Write-Host "Failed: $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })

if ($script:testsFailed -eq 0) {
    Write-Host "`nAll tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome tests failed!" -ForegroundColor Red
    exit 1
}

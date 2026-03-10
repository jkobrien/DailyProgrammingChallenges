<#
.SYNOPSIS
    Test script for Subarrays with First Element Minimum solution.

.DESCRIPTION
    Contains test cases to verify the correctness of the solution.
    Run this script to execute all tests.
#>

# Import the solution
. "$PSScriptRoot\subarrays_first_element_minimum.ps1"

# Test counter
$script:testsPassed = 0
$script:testsFailed = 0

function Test-Solution {
    param (
        [string]$TestName,
        [int[]]$InputArr,
        [long]$Expected
    )
    
    $result = Get-SubarraysWithFirstElementMinimum -arr $InputArr
    
    if ($result -eq $Expected) {
        Write-Host "[PASS] $TestName" -ForegroundColor Green
        Write-Host "       Input: [$($InputArr -join ', ')]" -ForegroundColor Gray
        Write-Host "       Expected: $Expected, Got: $result" -ForegroundColor Gray
        $script:testsPassed++
    } else {
        Write-Host "[FAIL] $TestName" -ForegroundColor Red
        Write-Host "       Input: [$($InputArr -join ', ')]" -ForegroundColor Yellow
        Write-Host "       Expected: $Expected, Got: $result" -ForegroundColor Yellow
        $script:testsFailed++
    }
    Write-Host ""
}

function Test-BruteForceComparison {
    param (
        [string]$TestName,
        [int[]]$InputArr
    )
    
    $optimized = Get-SubarraysWithFirstElementMinimum -arr $InputArr
    $bruteForce = Get-SubarraysWithFirstElementMinimumBruteForce -arr $InputArr
    
    if ($optimized -eq $bruteForce) {
        Write-Host "[PASS] $TestName (Optimized vs Brute Force)" -ForegroundColor Green
        Write-Host "       Input: [$($InputArr -join ', ')]" -ForegroundColor Gray
        Write-Host "       Both returned: $optimized" -ForegroundColor Gray
        $script:testsPassed++
    } else {
        Write-Host "[FAIL] $TestName (Optimized vs Brute Force)" -ForegroundColor Red
        Write-Host "       Input: [$($InputArr -join ', ')]" -ForegroundColor Yellow
        Write-Host "       Optimized: $optimized, Brute Force: $bruteForce" -ForegroundColor Yellow
        $script:testsFailed++
    }
    Write-Host ""
}

Write-Host ("=" * 60)
Write-Host "Testing: Subarrays with First Element Minimum"
Write-Host ("=" * 60)
Write-Host ""

# Test Case 1: Example from problem statement
Test-Solution -TestName "Example 1: [1, 2, 1]" -InputArr @(1, 2, 1) -Expected 5

# Test Case 2: Example from problem statement
Test-Solution -TestName "Example 2: [1, 3, 5, 2]" -InputArr @(1, 3, 5, 2) -Expected 8

# Test Case 3: Single element
Test-Solution -TestName "Single element [5]" -InputArr @(5) -Expected 1

# Test Case 4: Two elements - increasing
Test-Solution -TestName "Two elements increasing [1, 2]" -InputArr @(1, 2) -Expected 3

# Test Case 5: Two elements - decreasing
Test-Solution -TestName "Two elements decreasing [2, 1]" -InputArr @(2, 1) -Expected 2

# Test Case 6: Two elements - equal
Test-Solution -TestName "Two elements equal [3, 3]" -InputArr @(3, 3) -Expected 3

# Test Case 7: All same elements
Test-Solution -TestName "All same [2, 2, 2, 2]" -InputArr @(2, 2, 2, 2) -Expected 10

# Test Case 8: Strictly increasing array
# For [1, 2, 3, 4]: Every element can extend to the end
# Index 0: 4 subarrays, Index 1: 3 subarrays, Index 2: 2 subarrays, Index 3: 1 subarray
# Total = 4 + 3 + 2 + 1 = 10
Test-Solution -TestName "Strictly increasing [1, 2, 3, 4]" -InputArr @(1, 2, 3, 4) -Expected 10

# Test Case 9: Strictly decreasing array
# For [4, 3, 2, 1]: Each element can only form single-element subarray
# Total = 4
Test-Solution -TestName "Strictly decreasing [4, 3, 2, 1]" -InputArr @(4, 3, 2, 1) -Expected 4

# Test Case 10: V-shaped array
# [3, 1, 2]: 
# Index 0: Only [3] is valid (1 subarray)
# Index 1: [1], [1,2] are valid (2 subarrays)
# Index 2: [2] is valid (1 subarray)
# Total = 4
Test-Solution -TestName "V-shaped [3, 1, 2]" -InputArr @(3, 1, 2) -Expected 4

# Test Case 11: Mountain array
# [1, 3, 2]: 
# Index 0: [1], [1,3], [1,3,2] are valid (3 subarrays)
# Index 1: [3] is valid, but [3,2] invalid because 2 < 3 (1 subarray)
# Index 2: [2] is valid (1 subarray)
# Total = 5
Test-Solution -TestName "Mountain [1, 3, 2]" -InputArr @(1, 3, 2) -Expected 5

# Test Case 12: With duplicates
# [2, 1, 2, 1]:
# Index 0: [2] valid (1 subarray), [2,1] invalid
# Index 1: [1], [1,2], [1,2,1] valid (3 subarrays)
# Index 2: [2] valid (1 subarray), [2,1] invalid
# Index 3: [1] valid (1 subarray)
# Total = 6
Test-Solution -TestName "With duplicates [2, 1, 2, 1]" -InputArr @(2, 1, 2, 1) -Expected 6

# Test Case 13: Comparison with brute force for random array
Test-BruteForceComparison -TestName "Random array comparison [5, 2, 7, 1, 3, 8, 4]" -InputArr @(5, 2, 7, 1, 3, 8, 4)

# Test Case 14: Comparison with brute force for another array
Test-BruteForceComparison -TestName "Another comparison [3, 3, 3, 1, 2, 2, 1]" -InputArr @(3, 3, 3, 1, 2, 2, 1)

# Test Case 15: Larger array comparison
$largerArray = @(4, 2, 5, 1, 3, 6, 2, 4, 1, 5)
Test-BruteForceComparison -TestName "Larger array comparison (10 elements)" -InputArr $largerArray

# Test Case 16: Edge case - minimum at the start
Test-Solution -TestName "Minimum at start [1, 5, 4, 3, 2]" -InputArr @(1, 5, 4, 3, 2) -Expected 9

# Summary
Write-Host ("=" * 60)
Write-Host "Test Summary"
Write-Host ("=" * 60)
Write-Host "Tests Passed: $script:testsPassed" -ForegroundColor Green
if ($script:testsFailed -eq 0) {
    Write-Host "Tests Failed: $script:testsFailed" -ForegroundColor Green
} else {
    Write-Host "Tests Failed: $script:testsFailed" -ForegroundColor Red
}
Write-Host ""

if ($script:testsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "Some tests failed. Please review the solution." -ForegroundColor Red
}
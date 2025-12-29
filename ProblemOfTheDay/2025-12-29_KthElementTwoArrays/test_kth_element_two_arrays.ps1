<#
.SYNOPSIS
    Comprehensive test suite for K-th element of two sorted arrays solution

.DESCRIPTION
    Tests both binary search and simple approaches with various test cases
    including edge cases, boundary conditions, and performance validation
#>

# Import the solution functions
. "$PSScriptRoot\kth_element_two_arrays.ps1"

# Test counter
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestNumber = 0

function Test-KthElement {
    param(
        [string]$TestName,
        [int[]]$a,
        [int[]]$b,
        [int]$k,
        [int]$Expected
    )
    
    $script:TestNumber++
    Write-Host "`nTest $script:TestNumber : $TestName" -ForegroundColor Cyan
    Write-Host "Input: a = [$($a -join ', ')], b = [$($b -join ', ')], k = $k"
    Write-Host "Expected: $Expected"
    
    try {
        # Test binary search approach
        $resultBinary = Find-KthElement -a $a -b $b -k $k
        Write-Host "Binary Search Result: $resultBinary" -NoNewline
        
        if ($resultBinary -eq $Expected) {
            Write-Host " [OK]" -ForegroundColor Green
            $binaryPassed = $true
        }
        else {
            Write-Host " [FAIL] (Expected $Expected)" -ForegroundColor Red
            $binaryPassed = $false
        }
        
        # Test simple approach
        $resultSimple = Find-KthElement-Simple -a $a -b $b -k $k
        Write-Host "Simple Approach Result: $resultSimple" -NoNewline
        
        if ($resultSimple -eq $Expected) {
            Write-Host " [OK]" -ForegroundColor Green
            $simplePassed = $true
        }
        else {
            Write-Host " [FAIL] (Expected $Expected)" -ForegroundColor Red
            $simplePassed = $false
        }
        
        if ($binaryPassed -and $simplePassed) {
            Write-Host "Status: PASSED" -ForegroundColor Green
            $script:TestsPassed++
        }
        else {
            Write-Host "Status: FAILED" -ForegroundColor Red
            $script:TestsFailed++
        }
    }
    catch {
        Write-Host "Status: ERROR - $_" -ForegroundColor Red
        $script:TestsFailed++
    }
}

Write-Host "======================================" -ForegroundColor Magenta
Write-Host "K-th Element of Two Arrays - Test Suite" -ForegroundColor Magenta
Write-Host "======================================" -ForegroundColor Magenta

# Test 1: Example from problem
Test-KthElement -TestName "Example 1 from problem" `
    -a @(2, 3, 6, 7, 9) `
    -b @(1, 4, 8, 10) `
    -k 5 `
    -Expected 6

# Test 2: Example 2 from problem
Test-KthElement -TestName "Example 2 from problem" `
    -a @(1, 4, 8, 10, 12) `
    -b @(5, 7, 11, 15, 17) `
    -k 6 `
    -Expected 10

# Test 3: k = 1 (first element)
Test-KthElement -TestName "Edge case: k=1 (first element)" `
    -a @(100, 200) `
    -b @(50, 150, 250) `
    -k 1 `
    -Expected 50

# Test 4: k at the end
Test-KthElement -TestName "Edge case: k at end" `
    -a @(1, 2) `
    -b @(3, 4, 5) `
    -k 5 `
    -Expected 5

# Test 5: k at the last position
Test-KthElement -TestName "k equals total length" `
    -a @(1, 3, 5) `
    -b @(2, 4, 6, 8) `
    -k 7 `
    -Expected 8

# Test 6: All elements from first array come first
Test-KthElement -TestName "All elements of a[] smaller" `
    -a @(1, 2, 3) `
    -b @(10, 20, 30) `
    -k 2 `
    -Expected 2

# Test 7: All elements from second array come first
Test-KthElement -TestName "All elements of b[] smaller" `
    -a @(50, 60, 70) `
    -b @(1, 2, 3) `
    -k 2 `
    -Expected 2

# Test 8: Single element in first array
Test-KthElement -TestName "Single element in array a" `
    -a @(5) `
    -b @(1, 2, 3, 4, 6, 7) `
    -k 5 `
    -Expected 5

# Test 9: Single element in second array
Test-KthElement -TestName "Single element in array b" `
    -a @(1, 2, 3, 4, 6, 7) `
    -b @(5) `
    -k 5 `
    -Expected 5

# Test 10: Arrays with duplicate elements
Test-KthElement -TestName "Arrays with duplicates" `
    -a @(1, 2, 2, 3) `
    -b @(2, 3, 4, 5) `
    -k 4 `
    -Expected 2

# Test 11: k in middle position
Test-KthElement -TestName "k in middle position" `
    -a @(1, 5, 9, 13) `
    -b @(2, 6, 10, 14) `
    -k 4 `
    -Expected 6

# Test 12: Interleaved arrays
Test-KthElement -TestName "Perfectly interleaved arrays" `
    -a @(1, 3, 5, 7) `
    -b @(2, 4, 6, 8) `
    -k 5 `
    -Expected 5

# Test 13: Large values
Test-KthElement -TestName "Large array values" `
    -a @(100000000, 200000000) `
    -b @(50000000, 150000000, 250000000) `
    -k 3 `
    -Expected 150000000

# Test 14: k = 2 (second element)
Test-KthElement -TestName "k=2 (second element)" `
    -a @(10, 20, 30) `
    -b @(15, 25, 35) `
    -k 2 `
    -Expected 15

# Test 15: Equal sized arrays
Test-KthElement -TestName "Equal sized arrays" `
    -a @(1, 3, 5, 7, 9) `
    -b @(2, 4, 6, 8, 10) `
    -k 5 `
    -Expected 5

# Test 16: Array with zeros
Test-KthElement -TestName "Arrays containing zeros" `
    -a @(0, 1, 2) `
    -b @(0, 3, 4) `
    -k 3 `
    -Expected 1

# Test 17: k pointing to element from first array
Test-KthElement -TestName "Result from first array" `
    -a @(5, 10, 15) `
    -b @(20, 25, 30) `
    -k 3 `
    -Expected 15

# Test 18: k pointing to element from second array
Test-KthElement -TestName "Result from second array" `
    -a @(20, 25, 30) `
    -b @(5, 10, 15) `
    -k 3 `
    -Expected 15

# Performance test
Write-Host "`n======================================" -ForegroundColor Magenta
Write-Host "Performance Comparison" -ForegroundColor Magenta
Write-Host "======================================" -ForegroundColor Magenta

$largeA = 1..500 | ForEach-Object { $_ * 2 }
$largeB = 1..500 | ForEach-Object { $_ * 2 + 1 }
$largeK = 500

Write-Host "`nTesting with larger arrays (500 elements each, k=500)"

# Measure binary search
$binaryTime = Measure-Command {
    $result = Find-KthElement -a $largeA -b $largeB -k $largeK
}
Write-Host "Binary Search Time: $($binaryTime.TotalMilliseconds) ms" -ForegroundColor Yellow

# Measure simple approach
$simpleTime = Measure-Command {
    $result = Find-KthElement-Simple -a $largeA -b $largeB -k $largeK
}
Write-Host "Simple Approach Time: $($simpleTime.TotalMilliseconds) ms" -ForegroundColor Yellow

$speedup = [Math]::Round($simpleTime.TotalMilliseconds / $binaryTime.TotalMilliseconds, 2)
Write-Host "Binary Search is ${speedup}x faster" -ForegroundColor Green

# Summary
Write-Host "`n======================================" -ForegroundColor Magenta
Write-Host "Test Summary" -ForegroundColor Magenta
Write-Host "======================================" -ForegroundColor Magenta
Write-Host "Total Tests: $script:TestNumber"
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })

$successRate = [Math]::Round(($script:TestsPassed / $script:TestNumber) * 100, 2)
Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($successRate -eq 100) { "Green" } else { "Yellow" })

if ($script:TestsFailed -eq 0) {
    Write-Host "`n[PASS] All tests passed!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "`n[FAIL] Some tests failed!" -ForegroundColor Red
    exit 1
}

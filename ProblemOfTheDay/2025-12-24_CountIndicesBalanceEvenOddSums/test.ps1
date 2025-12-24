<#
.SYNOPSIS
    Test suite for Count Indices to Balance Even and Odd Sums

.DESCRIPTION
    Comprehensive test cases for the CountBalancedIndices function
#>

# Import the solution
. "$PSScriptRoot\solution.ps1"

function Test-CountBalancedIndices {
    $testsPassed = 0
    $testsFailed = 0
    
    Write-Host "`nRunning Test Suite..." -ForegroundColor Cyan
    Write-Host ("=" * 70) -ForegroundColor Cyan
    
    # Test Case 1: Example from problem
    Write-Host "`nTest 1: Basic example [2, 1, 6, 4]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(2, 1, 6, 4)
    $expected = 1
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 2: All elements same
    Write-Host "`nTest 2: All elements same [1, 1, 1]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(1, 1, 1)
    $expected = 3
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 3: Single element
    Write-Host "`nTest 3: Single element [5]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(5)
    $expected = 1
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 4: Two elements
    Write-Host "`nTest 4: Two elements [1, 1]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(1, 1)
    $expected = 0
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 5: No balanced indices
    Write-Host "`nTest 5: No balanced indices [1, 2, 3]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(1, 2, 3)
    $expected = 0
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 6: Array with zeros
    Write-Host "`nTest 6: Array with zeros [0, 0, 0, 0]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(0, 0, 0, 0)
    $expected = 4
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 7: Larger array
    Write-Host "`nTest 7: Larger array [5, 5, 2, 3, 5, 5]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(5, 5, 2, 3, 5, 5)
    $expected = 0
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 8: Alternating pattern
    Write-Host "`nTest 8: Alternating pattern [1, 2, 1, 2, 1]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(1, 2, 1, 2, 1)
    $expected = 1
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 9: Large values
    Write-Host "`nTest 9: Large values [10000, 10000]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(10000, 10000)
    $expected = 0
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Test Case 10: Mixed values
    Write-Host "`nTest 10: Mixed values [4, 3, 2, 1]" -ForegroundColor Yellow
    $result = CountBalancedIndices @(4, 3, 2, 1)
    $expected = 0
    if ($result -eq $expected) {
        Write-Host "[PASS] Output: $result" -ForegroundColor Green
        $testsPassed++
    } else {
        Write-Host "[FAIL] Expected: $expected, Got: $result" -ForegroundColor Red
        $testsFailed++
    }
    
    # Summary
    Write-Host "`n" -NoNewline
    Write-Host ("=" * 70) -ForegroundColor Cyan
    Write-Host "`nTest Summary:" -ForegroundColor Cyan
    Write-Host "Tests Passed: $testsPassed" -ForegroundColor Green
    Write-Host "Tests Failed: $testsFailed" -ForegroundColor $(if ($testsFailed -gt 0) { "Red" } else { "Green" })
    Write-Host "Total Tests:  $($testsPassed + $testsFailed)"
    
    if ($testsFailed -eq 0) {
        Write-Host "`n[SUCCESS] All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "`n[FAILURE] Some tests failed!" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Run the test suite
Test-CountBalancedIndices

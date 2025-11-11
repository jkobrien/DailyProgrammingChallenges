<#
.SYNOPSIS
    Test script for Shortest Common Supersequence solution

.DESCRIPTION
    Runs comprehensive tests for the Shortest Common Supersequence problem
    including all provided examples and edge cases.
#>

# Import the solution
. "$PSScriptRoot\shortest_common_supersequence.ps1"

# Test results tracking
$script:testsPassed = 0
$script:testsFailed = 0
$script:testResults = @()

function Test-ShortestCommonSupersequence {
    param (
        [string]$TestName,
        [string]$s1,
        [string]$s2,
        [int]$Expected
    )
    
    try {
        $result = Get-ShortestCommonSupersequence $s1 $s2
        
        if ($result -eq $Expected) {
            $script:testsPassed++
            $status = "PASS"
            $color = "Green"
        }
        else {
            $script:testsFailed++
            $status = "FAIL"
            $color = "Red"
        }
        
        $testResult = [PSCustomObject]@{
            Test     = $TestName
            Status   = $status
            Input    = "s1='$s1', s2='$s2'"
            Expected = $Expected
            Got      = $result
        }
        
        $script:testResults += $testResult
        
        Write-Host "[$status] $TestName" -ForegroundColor $color
        Write-Host "  Input: s1='$s1', s2='$s2'" -ForegroundColor Gray
        Write-Host "  Expected: $Expected, Got: $result" -ForegroundColor Gray
        
        if ($status -eq "FAIL") {
            Write-Host "  ERROR: Expected $Expected but got $result" -ForegroundColor Red
        }
        
        Write-Host ""
    }
    catch {
        $script:testsFailed++
        $status = "ERROR"
        
        Write-Host "[$status] $TestName" -ForegroundColor Red
        Write-Host "  Input: s1='$s1', s2='$s2'" -ForegroundColor Gray
        Write-Host "  Exception: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        
        $testResult = [PSCustomObject]@{
            Test     = $TestName
            Status   = "ERROR"
            Input    = "s1='$s1', s2='$s2'"
            Expected = $Expected
            Got      = "Exception: $($_.Exception.Message)"
        }
        
        $script:testResults += $testResult
    }
}

function Test-ShortestCommonSupersequenceString {
    param (
        [string]$TestName,
        [string]$s1,
        [string]$s2,
        [int]$ExpectedLength
    )
    
    try {
        $result = Get-ShortestCommonSupersequenceString $s1 $s2
        $actualLength = $result.Length
        
        # Verify the string contains both subsequences
        $containsS1 = Test-IsSubsequence $s1 $result
        $containsS2 = Test-IsSubsequence $s2 $result
        
        if ($actualLength -eq $ExpectedLength -and $containsS1 -and $containsS2) {
            $script:testsPassed++
            $status = "PASS"
            $color = "Green"
        }
        else {
            $script:testsFailed++
            $status = "FAIL"
            $color = "Red"
        }
        
        Write-Host "[$status] $TestName" -ForegroundColor $color
        Write-Host "  Input: s1='$s1', s2='$s2'" -ForegroundColor Gray
        Write-Host "  SCS: '$result' (length: $actualLength)" -ForegroundColor Gray
        Write-Host "  Contains s1: $containsS1, Contains s2: $containsS2" -ForegroundColor Gray
        
        if ($status -eq "FAIL") {
            Write-Host "  ERROR: Length mismatch or invalid supersequence" -ForegroundColor Red
        }
        
        Write-Host ""
    }
    catch {
        $script:testsFailed++
        Write-Host "[ERROR] $TestName" -ForegroundColor Red
        Write-Host "  Exception: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
    }
}

function Test-IsSubsequence {
    param (
        [string]$subsequence,
        [string]$string
    )
    
    $j = 0
    for ($i = 0; $i -lt $string.Length -and $j -lt $subsequence.Length; $i++) {
        if ($string.Chars($i) -eq $subsequence.Chars($j)) {
            $j++
        }
    }
    
    return $j -eq $subsequence.Length
}

# Run tests
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Testing Shortest Common Supersequence" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "=== Example Test Cases ===" -ForegroundColor Yellow
Write-Host ""

# Example 1
Test-ShortestCommonSupersequence "Example 1: Basic case" "geek" "eke" 5

# Example 2
Test-ShortestCommonSupersequence "Example 2: Complex case" "AGGTAB" "GXTXAYB" 9

# Example 3
Test-ShortestCommonSupersequence "Example 3: One substring of other" "geek" "ek" 4

Write-Host "=== Edge Cases ===" -ForegroundColor Yellow
Write-Host ""

# Edge case: Empty strings
Test-ShortestCommonSupersequence "Edge 1: Empty s1" "" "abc" 3
Test-ShortestCommonSupersequence "Edge 2: Empty s2" "abc" "" 3
Test-ShortestCommonSupersequence "Edge 3: Both empty" "" "" 0

# Edge case: No common characters
Test-ShortestCommonSupersequence "Edge 4: No common chars" "abcd" "efgh" 8

# Edge case: Identical strings
Test-ShortestCommonSupersequence "Edge 5: Identical strings" "test" "test" 4

# Edge case: Single characters
Test-ShortestCommonSupersequence "Edge 6: Single char match" "a" "a" 1
Test-ShortestCommonSupersequence "Edge 7: Single char different" "a" "b" 2

# Edge case: One character vs string
Test-ShortestCommonSupersequence "Edge 8: Single vs multiple" "a" "abc" 3
Test-ShortestCommonSupersequence "Edge 9: Single vs multiple (match)" "b" "abc" 3

Write-Host "=== Additional Test Cases ===" -ForegroundColor Yellow
Write-Host ""

# Additional tests
Test-ShortestCommonSupersequence "Add 1: Repeated characters" "aaa" "aa" 3
Test-ShortestCommonSupersequence "Add 2: Alternating pattern" "abab" "baba" 5
Test-ShortestCommonSupersequence "Add 3: Reverse strings" "abc" "cba" 5

Write-Host "=== Testing SCS String Construction ===" -ForegroundColor Yellow
Write-Host ""

# Test actual string construction
Test-ShortestCommonSupersequenceString "String 1: Basic case" "geek" "eke" 5
Test-ShortestCommonSupersequenceString "String 2: Complex case" "AGGTAB" "GXTXAYB" 9
Test-ShortestCommonSupersequenceString "String 3: No common" "abc" "def" 6

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Tests: $($script:testsPassed + $script:testsFailed)" -ForegroundColor White
Write-Host "Passed: $script:testsPassed" -ForegroundColor Green
Write-Host "Failed: $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($script:testsFailed -eq 0) {
    Write-Host "All tests passed! [OK]" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Some tests failed. [FAIL]" -ForegroundColor Red
    Write-Host ""
    Write-Host "Failed Tests:" -ForegroundColor Red
    $script:testResults | Where-Object { $_.Status -ne "PASS" } | Format-Table -AutoSize
    exit 1
}

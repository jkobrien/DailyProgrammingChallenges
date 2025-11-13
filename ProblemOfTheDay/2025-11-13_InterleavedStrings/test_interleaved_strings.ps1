<#
.SYNOPSIS
    Comprehensive test suite for Interleaved Strings solution

.DESCRIPTION
    Tests the Test-InterleavedStrings function with various test cases including:
    - Basic examples from the problem statement
    - Edge cases (empty strings, single characters)
    - Complex interleavings
    - Invalid cases
    - Both 1D and 2D DP implementations
#>

# Import the solution
. "$PSScriptRoot\interleaved_strings.ps1"

# Test result tracking
$script:testsPassed = 0
$script:testsFailed = 0
$script:testsTotal = 0

function Assert-Equal {
    param(
        [string]$TestName,
        [bool]$Expected,
        [bool]$Actual,
        [AllowEmptyString()][string]$s1,
        [AllowEmptyString()][string]$s2,
        [AllowEmptyString()][string]$s3
    )
    
    $script:testsTotal++
    
    if ($Expected -eq $Actual) {
        $script:testsPassed++
        Write-Host "  Pass: $TestName" -ForegroundColor Green
        Write-Host "    Input: s1='$s1', s2='$s2', s3='$s3' => $Actual" -ForegroundColor DarkGray
    }
    else {
        $script:testsFailed++
        Write-Host "  FAIL: $TestName" -ForegroundColor Red
        Write-Host "    Input: s1='$s1', s2='$s2', s3='$s3'" -ForegroundColor DarkGray
        Write-Host "    Expected: $Expected, Got: $Actual" -ForegroundColor Red
    }
}

function Test-Both {
    param(
        [string]$TestName,
        [bool]$Expected,
        [AllowEmptyString()][string]$s1,
        [AllowEmptyString()][string]$s2,
        [AllowEmptyString()][string]$s3
    )
    
    # Test 1D DP implementation
    $result1D = Test-InterleavedStrings $s1 $s2 $s3
    Assert-Equal "$TestName - 1D" $Expected $result1D $s1 $s2 $s3
    
    # Test 2D DP implementation
    $result2D = Test-InterleavedStrings2D $s1 $s2 $s3
    Assert-Equal "$TestName - 2D" $Expected $result2D $s1 $s2 $s3
}

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Interleaved Strings - Test Suite" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Test Category 1: Examples from Problem Statement
Write-Host "Test Category 1: Problem Examples" -ForegroundColor Yellow
Test-Both "Example 1" $true "AAB" "AAC" "AAAABC"
Test-Both "Example 2" $true "AB" "C" "ACB"
Test-Both "Example 3" $false "YX" "X" "XXY"
Write-Host ""

# Test Category 2: Edge Cases
Write-Host "Test Category 2: Edge Cases" -ForegroundColor Yellow
Test-Both "Empty s1" $true "" "abc" "abc"
Test-Both "Empty s2" $true "abc" "" "abc"
Test-Both "All empty" $true "" "" ""
Test-Both "Single char valid" $true "a" "b" "ab"
Test-Both "Single char valid 2" $true "a" "b" "ba"
Test-Both "Single char invalid" $false "a" "b" "aa"
Write-Host ""

# Test Category 3: Length Mismatch
Write-Host "Test Category 3: Length Mismatch" -ForegroundColor Yellow
Test-Both "s3 too short" $false "abc" "def" "abcde"
Test-Both "s3 too long" $false "ab" "cd" "abcdefg"
Test-Both "Wrong length" $false "a" "b" "abc"
Write-Host ""

# Test Category 4: Complex Valid Interleavings
Write-Host "Test Category 4: Complex Valid Interleavings" -ForegroundColor Yellow
Test-Both "Complex 1" $true "aabcc" "dbbca" "aadbbcbcac"
Test-Both "Complex 2" $true "abc" "def" "adbecf"
Test-Both "Complex 3" $true "abc" "def" "dabecf"
Test-Both "Repeated chars" $true "aa" "aa" "aaaa"
Test-Both "Alternate chars" $true "ace" "bdf" "abcdef"
Write-Host ""

# Test Category 5: Complex Invalid Interleavings
Write-Host "Test Category 5: Complex Invalid Interleavings" -ForegroundColor Yellow
Test-Both "Invalid 1" $false "aabcc" "dbbca" "aadbbbaccc"
Test-Both "Invalid 2" $false "abc" "def" "abcfed"
Test-Both "Wrong order 1" $false "abc" "def" "fedcba"
Test-Both "Wrong order 2" $false "ab" "cd" "dcba"
Write-Host ""

# Test Category 6: Patterns with Repetition
Write-Host "Test Category 6: Patterns with Repetition" -ForegroundColor Yellow
Test-Both "All same char valid" $true "aaa" "aaa" "aaaaaa"
Test-Both "Pattern 1" $true "aaaa" "bbbb" "aabbabab"
Test-Both "Pattern 2" $true "aaa" "bbb" "ababab"
Test-Both "Pattern invalid" $false "aaa" "bbb" "aabbbb"
Write-Host ""

# Test Category 7: Longer Strings
Write-Host "Test Category 7: Longer Strings" -ForegroundColor Yellow
Test-Both "Long valid" $true "abcdefgh" "12345678" "a1b2c3d4e5f6g7h8"
Test-Both "Long invalid" $false "abcdefgh" "12345678" "12345678abcdefgh"
Write-Host ""

# Test Category 8: Special Cases
Write-Host "Test Category 8: Special Cases" -ForegroundColor Yellow
Test-Both "One char interleaved" $true "a" "bcdef" "abcdef"
Test-Both "One char at end" $true "abcde" "f" "abcdef"
Test-Both "Identical strings" $true "abc" "abc" "aabbcc"
Test-Both "Identical invalid" $false "abc" "abc" "abcabc"
Write-Host ""

# Summary
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Test Results Summary" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Total Tests:  $script:testsTotal" -ForegroundColor White
Write-Host "Passed:       $script:testsPassed" -ForegroundColor Green
Write-Host "Failed:       $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($script:testsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Some tests failed!" -ForegroundColor Red
    exit 1
}

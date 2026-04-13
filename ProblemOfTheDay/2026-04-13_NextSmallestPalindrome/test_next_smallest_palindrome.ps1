<#
.SYNOPSIS
    Test script for Next Smallest Palindrome solution

.DESCRIPTION
    Comprehensive test suite for the next smallest palindrome problem.
    Tests include basic examples, edge cases, and performance validation.
#>

# Suppress output from dot-sourcing by redirecting to null
$null = . "$PSScriptRoot\next_smallest_palindrome.ps1" *>&1

# Test result tracking
$script:passedTests = 0
$script:failedTests = 0
$script:totalTests = 0

function Compare-Arrays {
    param(
        [int[]]$Array1,
        [int[]]$Array2
    )
    
    if ($Array1.Length -ne $Array2.Length) {
        return $false
    }
    
    for ($i = 0; $i -lt $Array1.Length; $i++) {
        if ($Array1[$i] -ne $Array2[$i]) {
            return $false
        }
    }
    
    return $true
}

function ConvertTo-NumberStringLocal {
    param([int[]]$digits)
    return ($digits -join '')
}

function Test-PalindromeLocal {
    param([int[]]$num)
    $n = $num.Length
    for ($i = 0; $i -lt $n / 2; $i++) {
        if ($num[$i] -ne $num[$n - 1 - $i]) {
            return $false
        }
    }
    return $true
}

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Input,
        [int[]]$Expected,
        [string]$Description = ""
    )
    
    $script:totalTests++
    
    Write-Host "`nTest $($script:totalTests): $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "  Description: $Description" -ForegroundColor Gray
    }
    Write-Host "  Input:    [$($Input -join ', ')] ($(ConvertTo-NumberStringLocal $Input))"
    Write-Host "  Expected: [$($Expected -join ', ')] ($(ConvertTo-NumberStringLocal $Expected))"
    
    try {
        $result = Get-NextPalindrome -num $Input
        $matches = Compare-Arrays -Array1 $result -Array2 $Expected
        
        if ($matches) {
            Write-Host "  Got:      [$($result -join ', ')] ($(ConvertTo-NumberStringLocal $result))" -ForegroundColor Green
            
            # Verify it's actually a palindrome
            $isPalindrome = Test-PalindromeLocal -num $result
            if (-not $isPalindrome) {
                Write-Host "  WARNING: Result is not a palindrome!" -ForegroundColor Red
                $script:failedTests++
                return $false
            }
            
            # Verify it's greater than input
            $resultNum = ConvertTo-NumberStringLocal $result
            $inputNum = ConvertTo-NumberStringLocal $Input
            if ($resultNum.Length -lt $inputNum.Length -or ($resultNum.Length -eq $inputNum.Length -and $resultNum -le $inputNum)) {
                Write-Host "  WARNING: Result is not greater than input!" -ForegroundColor Red
                $script:failedTests++
                return $false
            }
            
            Write-Host "  PASSED" -ForegroundColor Green
            $script:passedTests++
            return $true
        } else {
            Write-Host "  Got:      [$($result -join ', ')] ($(ConvertTo-NumberStringLocal $result))" -ForegroundColor Red
            Write-Host "  FAILED" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
    }
    catch {
        Write-Host "  FAILED with error: $_" -ForegroundColor Red
        $script:failedTests++
        return $false
    }
}

Write-Host "=================================================" -ForegroundColor Magenta
Write-Host "Next Smallest Palindrome - Test Suite" -ForegroundColor Magenta
Write-Host "GeeksforGeeks Problem of the Day - April 13, 2026" -ForegroundColor Magenta
Write-Host "=================================================" -ForegroundColor Magenta

# Test 1: Example from problem statement
Test-Case -TestName "Example 1 (Long odd)" -Input @(9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2) -Expected @(9, 4, 1, 8, 8, 0, 8, 8, 1, 4, 9) -Description "Large number with mirroring and increment"

# Test 2: Simple increment
Test-Case -TestName "Example 2 (Simple)" -Input @(1, 2, 3) -Expected @(1, 3, 1) -Description "Simple case where mirroring gives smaller number"

# Test 3: All 9s
Test-Case -TestName "Example 3 (All 9s)" -Input @(9, 9, 9) -Expected @(1, 0, 0, 1) -Description "All 9s overflow to next power of 10"

# Test 4: Already palindrome
Test-Case -TestName "Example 4 (Already palindrome)" -Input @(1, 2, 1) -Expected @(1, 3, 1) -Description "Input is already palindrome, need next one"

# Test 5: Single digit
Test-Case -TestName "Single Digit (5)" -Input @(5) -Expected @(6) -Description "Single digit increment"

# Test 6: Single digit 9
Test-Case -TestName "Single Digit (9)" -Input @(9) -Expected @(1, 1) -Description "Single 9 becomes 11"

# Test 7: Two digits
Test-Case -TestName "Two Digits (12)" -Input @(1, 2) -Expected @(2, 2) -Description "Two digit case"

# Test 8: Two digits palindrome
Test-Case -TestName "Two Digits Palindrome (88)" -Input @(8, 8) -Expected @(9, 9) -Description "Two digit palindrome increment"

# Test 9: Two digits 99
Test-Case -TestName "Two Digits (99)" -Input @(9, 9) -Expected @(1, 0, 1) -Description "99 becomes 101"

# Test 10: Even length
Test-Case -TestName "Even Length (1234)" -Input @(1, 2, 3, 4) -Expected @(1, 3, 3, 1) -Description "Even length number"

# Test 11: Carry propagation needed
Test-Case -TestName "Carry Propagation (1991)" -Input @(1, 9, 9, 1) -Expected @(2, 0, 0, 2) -Description "Palindrome that needs carry propagation"

# Test 12: Large even palindrome
Test-Case -TestName "Even Palindrome (9999)" -Input @(9, 9, 9, 9) -Expected @(1, 0, 0, 0, 1) -Description "Four 9s become 10001"

# Test 13: Odd length with carry
Test-Case -TestName "Odd Length Carry (12921)" -Input @(1, 2, 9, 2, 1) -Expected @(1, 3, 0, 3, 1) -Description "Palindrome with 9 in middle"

# Test 14: Mirror is larger
Test-Case -TestName "Mirror Larger (12345)" -Input @(1, 2, 3, 4, 5) -Expected @(1, 2, 4, 2, 1) -Description "Simple mirroring is not enough"

# Test 15: Large odd
Test-Case -TestName "Large Odd (123454321)" -Input @(1, 2, 3, 4, 5, 4, 3, 2, 1) -Expected @(1, 2, 3, 4, 6, 4, 3, 2, 1) -Description "Large palindrome increment"

# Test 16: Zeros in number
Test-Case -TestName "With Zeros (10201)" -Input @(1, 0, 2, 0, 1) -Expected @(1, 0, 3, 0, 1) -Description "Number with zeros"

# Test 17: Middle is 9
Test-Case -TestName "Middle is 9 (191)" -Input @(1, 9, 1) -Expected @(2, 0, 2) -Description "Middle digit is 9, causes carry"

# Test 18: Large even with 9s
Test-Case -TestName "Even with 9s (1991)" -Input @(1, 9, 9, 1) -Expected @(2, 0, 0, 2) -Description "Even palindrome with 9s"

# Test 19: Mirror exactly equals
Test-Case -TestName "Mirror Equals (54345)" -Input @(5, 4, 3, 4, 5) -Expected @(5, 4, 4, 4, 5) -Description "Mirror gives exact same number"

# Test 20: Small increment needed
Test-Case -TestName "Small Increment (12321)" -Input @(1, 2, 3, 2, 1) -Expected @(1, 2, 4, 2, 1) -Description "Already palindrome, increment middle"

# Test 21: Two digit non-palindrome
Test-Case -TestName "Two Non-Palindrome (23)" -Input @(2, 3) -Expected @(3, 3) -Description "Two digits not palindrome"

# Test 22: Three with middle 9
Test-Case -TestName "Three Middle 9 (292)" -Input @(2, 9, 2) -Expected @(3, 0, 3) -Description "Three digits with 9 in middle"

# Test 23: Four all same
Test-Case -TestName "Four Same (7777)" -Input @(7, 7, 7, 7) -Expected @(7, 8, 8, 7) -Description "Four same digits"

# Test 24: Long even with increment
Test-Case -TestName "Long Even (123321)" -Input @(1, 2, 3, 3, 2, 1) -Expected @(1, 2, 4, 4, 2, 1) -Description "Six digit palindrome"

# Test 25: Edge case single increment
Test-Case -TestName "Single Inc (1)" -Input @(1) -Expected @(2) -Description "Smallest increment"

# Test 26: Eight digit
Test-Case -TestName "Eight Digits (12344321)" -Input @(1, 2, 3, 4, 4, 3, 2, 1) -Expected @(1, 2, 3, 5, 5, 3, 2, 1) -Description "Eight digit palindrome"

# Test 27: Needs mirroring not increment
Test-Case -TestName "Just Mirror (12399)" -Input @(1, 2, 3, 9, 9) -Expected @(1, 2, 4, 2, 1) -Description "Mirroring gives smaller, need increment"

# Test 28: All 8s
Test-Case -TestName "All 8s (8888)" -Input @(8, 8, 8, 8) -Expected @(8, 9, 9, 8) -Description "All 8s increment"

# Test 29: Alternating
Test-Case -TestName "Alternating (121212)" -Input @(1, 2, 1, 2, 1, 2) -Expected @(1, 2, 1, 2, 2, 1) -Description "Alternating pattern"

# Test 30: Large number
Test-Case -TestName "Large (1234567890)" -Input @(1, 2, 3, 4, 5, 6, 7, 8, 9, 0) -Expected @(1, 2, 3, 4, 5, 5, 4, 3, 2, 1) -Description "Ten digit number"

# Performance test with large array
Write-Host ""
Write-Host "Performance Test" -ForegroundColor Cyan
$largeArray = @(1, 2, 3, 4, 5, 6, 7, 8, 9) * 1111  # ~10000 digits
$largeArray = $largeArray[0..9999]
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$result = Get-NextPalindrome -num $largeArray
$stopwatch.Stop()
Write-Host "  Array Size: $($largeArray.Length) digits"
$timeColor = if ($stopwatch.ElapsedMilliseconds -lt 500) { "Green" } else { "Yellow" }
Write-Host "  Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor $timeColor
Write-Host "  Result Length: $($result.Length) digits"
Write-Host "  Is Palindrome: $(Test-PalindromeLocal -num $result)"
Write-Host "  Status: " -NoNewline
if ($stopwatch.ElapsedMilliseconds -lt 1000) {
    Write-Host "PERFORMANT" -ForegroundColor Green
} else {
    Write-Host "SLOW" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "=================================================" -ForegroundColor Magenta
Write-Host "Test Summary" -ForegroundColor Magenta
Write-Host "=================================================" -ForegroundColor Magenta
Write-Host "Total Tests: $script:totalTests"
Write-Host "Passed: $script:passedTests" -ForegroundColor Green
$failColor = if ($script:failedTests -eq 0) { "Green" } else { "Red" }
Write-Host "Failed: $script:failedTests" -ForegroundColor $failColor

if ($script:totalTests -gt 0) {
    $successRate = [math]::Round(($script:passedTests / $script:totalTests) * 100, 2)
    Write-Host "Success Rate: $successRate%"
}

if ($script:failedTests -eq 0) {
    Write-Host ""
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host ""
    Write-Host "Some tests failed!" -ForegroundColor Red
    exit 1
}
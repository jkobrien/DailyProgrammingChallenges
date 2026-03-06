<#
.SYNOPSIS
    Test cases for the Smallest Window Containing All Characters problem.

.DESCRIPTION
    This script contains comprehensive test cases to verify the Get-SmallestWindow function.
    Run this script to validate the solution against various inputs.

.EXAMPLE
    .\test_smallest_window.ps1
#>

# Import the solution
. "$PSScriptRoot\smallest_window.ps1"

# Test framework helper functions
function Test-Case {
    param(
        [string]$Name,
        [string]$s,
        [string]$p,
        [string]$Expected
    )
    
    $result = Get-SmallestWindow -s $s -p $p
    
    if ($result -eq $Expected) {
        Write-Host "[PASS] $Name" -ForegroundColor Green
        Write-Host "       Input: s='$s', p='$p'" -ForegroundColor Gray
        Write-Host "       Output: '$result'" -ForegroundColor Gray
        return $true
    } else {
        Write-Host "[FAIL] $Name" -ForegroundColor Red
        Write-Host "       Input: s='$s', p='$p'" -ForegroundColor Gray
        Write-Host "       Expected: '$Expected'" -ForegroundColor Yellow
        Write-Host "       Got: '$result'" -ForegroundColor Red
        return $false
    }
}

# Run all tests
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Smallest Window - Test Suite" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$passed = 0
$failed = 0

# Test Case 1: Basic example from GFG
if (Test-Case -Name "GFG Example 1: timetopractice with toc" `
              -s "timetopractice" -p "toc" -Expected "toprac") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 2: Another GFG example
if (Test-Case -Name "GFG Example 2: zoomlazapzo with oza" `
              -s "zoomlazapzo" -p "oza" -Expected "apzo") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 3: No valid window exists
if (Test-Case -Name "No valid window: abc with xyz" `
              -s "abc" -p "xyz" -Expected "") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 4: Pattern equals source
if (Test-Case -Name "Pattern equals source: abc with abc" `
              -s "abc" -p "abc" -Expected "abc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 5: Single character
if (Test-Case -Name "Single character match: aaa with a" `
              -s "aaa" -p "a" -Expected "a") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 6: Pattern with duplicates
if (Test-Case -Name "Pattern with duplicates: aaabbbccc with abc" `
              -s "aaabbbccc" -p "abc" -Expected "abbbc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 7: Pattern is longer than source
if (Test-Case -Name "Pattern longer than source: ab with abcd" `
              -s "ab" -p "abcd" -Expected "") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 8: Window at the end
if (Test-Case -Name "Window at end: xyzabc with abc" `
              -s "xyzabc" -p "abc" -Expected "abc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 9: Window at the beginning
if (Test-Case -Name "Window at beginning: abcxyz with abc" `
              -s "abcxyz" -p "abc" -Expected "abc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 10: Multiple valid windows, should return first minimum
if (Test-Case -Name "Multiple valid windows: ADOBECODEBANC with ABC" `
              -s "ADOBECODEBANC" -p "ABC" -Expected "BANC") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 11: Repeated characters in pattern
if (Test-Case -Name "Repeated chars: aabbbcccc with aabbcc" `
              -s "aabbbcccc" -p "aabbcc" -Expected "aabbbcc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 12: Case sensitivity
if (Test-Case -Name "Case sensitive: AaBbCc with abc" `
              -s "AaBbCc" -p "abc" -Expected "aBbCc") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 13: Empty source
if (Test-Case -Name "Empty source: '' with abc" `
              -s "" -p "abc" -Expected "") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 14: Empty pattern
if (Test-Case -Name "Empty pattern: abc with ''" `
              -s "abc" -p "" -Expected "") {
    $passed++
} else { $failed++ }

Write-Host ""

# Test Case 15: Minimum window is entire string
if (Test-Case -Name "Entire string is window: cab with abc" `
              -s "cab" -p "abc" -Expected "cab") {
    $passed++
} else { $failed++ }

# Print summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Passed: $passed" -ForegroundColor Green
Write-Host "  Failed: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Green" })
Write-Host "  Total:  $($passed + $failed)" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if ($failed -eq 0) {
    Write-Host "All tests passed! " -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed. Please review the output above." -ForegroundColor Red
    exit 1
}
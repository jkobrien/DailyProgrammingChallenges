<#
.SYNOPSIS
    Test script for Largest Number in One Swap solution

.DESCRIPTION
    Comprehensive tests for the Get-LargestNumberInOneSwap function
    covering various edge cases and scenarios.

.NOTES
    Run this script to verify the solution works correctly.
#>

# Import the solution
. "$PSScriptRoot\largest_number_one_swap.ps1"

# Test framework
function Test-Case {
    param (
        [string]$Name,
        [string]$InputString,
        [string]$Expected
    )

    $result = Get-LargestNumberInOneSwap -s $InputString
    $passed = $result -eq $Expected

    [PSCustomObject]@{
        Name     = $Name
        Input    = $InputString
        Expected = $Expected
        Actual   = $result
        Passed   = $passed
    }
}

Write-Host ""
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host "  LARGEST NUMBER IN ONE SWAP - TEST SUITE" -ForegroundColor Cyan
Write-Host "  GeeksforGeeks Problem of the Day - March 9, 2026" -ForegroundColor Cyan
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host ""

$allTests = @()

# ============================================
# Basic Test Cases (from problem description)
# ============================================
Write-Host "Basic Test Cases:" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Example 1: 768" -InputString "768" -Expected "867"
$allTests += Test-Case -Name "Example 2: All same digits" -InputString "333" -Expected "333"

# ============================================
# Edge Cases
# ============================================
Write-Host ""
Write-Host "Edge Cases:" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Single digit" -InputString "9" -Expected "9"
$allTests += Test-Case -Name "Two digits - swap needed" -InputString "19" -Expected "91"
$allTests += Test-Case -Name "Two digits - no swap needed" -InputString "91" -Expected "91"
$allTests += Test-Case -Name "Two same digits" -InputString "55" -Expected "55"

# ============================================
# Already Maximum (Descending order)
# ============================================
Write-Host ""
Write-Host "Already Maximum (No swap helps):" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Descending 98765" -InputString "98765" -Expected "98765"
$allTests += Test-Case -Name "Descending 54321" -InputString "54321" -Expected "54321"
$allTests += Test-Case -Name "Descending 9876543210" -InputString "9876543210" -Expected "9876543210"

# ============================================
# Ascending order (needs swap)
# ============================================
Write-Host ""
Write-Host "Ascending Order (Swap needed):" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Ascending 12345" -InputString "12345" -Expected "52341"
$allTests += Test-Case -Name "Ascending 123" -InputString "123" -Expected "321"
$allTests += Test-Case -Name "Ascending with 0" -InputString "1234567890" -Expected "9234567810"

# ============================================
# Multiple same max digits (rightmost selection)
# ============================================
Write-Host ""
Write-Host "Multiple Same Max Digits (Rightmost selection):" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "1993 - two 9s" -InputString "1993" -Expected "9913"
$allTests += Test-Case -Name "2999 - three 9s" -InputString "2999" -Expected "9992"
$allTests += Test-Case -Name "98368" -InputString "98368" -Expected "98863"
$allTests += Test-Case -Name "1111191" -InputString "1111191" -Expected "9111111"

# ============================================
# Special patterns
# ============================================
Write-Host ""
Write-Host "Special Patterns:" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Zeros at end" -InputString "1000" -Expected "1000"
$allTests += Test-Case -Name "Zero at start" -InputString "0123" -Expected "3120"
$allTests += Test-Case -Name "All zeros" -InputString "0000" -Expected "0000"
$allTests += Test-Case -Name "987123987" -InputString "987123987" -Expected "997123887"

# ============================================
# Larger numbers
# ============================================
Write-Host ""
Write-Host "Larger Numbers:" -ForegroundColor Yellow
Write-Host ("-" * 40)

$allTests += Test-Case -Name "Large ascending" -InputString "123456789012345678901234567890" -Expected "923456789012345678901234567810"

# ============================================
# Display Results
# ============================================
Write-Host ""
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host "  TEST RESULTS" -ForegroundColor Cyan
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host ""

$passed = 0
$failed = 0

foreach ($test in $allTests) {
    if ($test.Passed) {
        $passed++
        Write-Host "[PASS] " -NoNewline -ForegroundColor Green
        Write-Host "$($test.Name)" -ForegroundColor White
        Write-Host "       Input: `"$($test.Input)`" => `"$($test.Actual)`"" -ForegroundColor DarkGray
    }
    else {
        $failed++
        Write-Host "[FAIL] " -NoNewline -ForegroundColor Red
        Write-Host "$($test.Name)" -ForegroundColor White
        Write-Host "       Input:    `"$($test.Input)`"" -ForegroundColor DarkGray
        Write-Host "       Expected: `"$($test.Expected)`"" -ForegroundColor Yellow
        Write-Host "       Actual:   `"$($test.Actual)`"" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host ("=" * 70) -ForegroundColor Cyan
$summaryColor = if ($failed -eq 0) { "Green" } else { "Yellow" }
Write-Host "  SUMMARY: $passed passed, $failed failed out of $($allTests.Count) tests" -ForegroundColor $summaryColor
Write-Host ("=" * 70) -ForegroundColor Cyan
Write-Host ""

# Return exit code based on test results
if ($failed -gt 0) {
    exit 1
}
exit 0
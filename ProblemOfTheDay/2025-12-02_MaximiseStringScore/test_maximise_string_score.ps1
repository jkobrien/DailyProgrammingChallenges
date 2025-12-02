<#
.SYNOPSIS
    Test suite for Maximise String Score solution

.DESCRIPTION
    Comprehensive tests for the Get-MaximiseStringScore function including
    example cases from the problem and additional edge cases
#>

# Import the solution
Import-Module "$PSScriptRoot\maximise_string_score.ps1" -Force

# Test helper function
function Test-Case {
    param(
        [string]$TestName,
        [string]$InputString,
        [array]$Jumps,
        [int]$Expected
    )
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Test: $TestName" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Input String: '$InputString'"
    Write-Host "Jump Rules:" -NoNewline
    foreach ($jump in $Jumps) {
        Write-Host " ['$($jump[0])' -> '$($jump[1])']" -NoNewline
    }
    Write-Host ""
    
    $result = Get-MaximiseStringScore -s $InputString -jumps $Jumps
    
    Write-Host "Expected: $Expected"
    Write-Host "Got:      $result"
    
    if ($result -eq $Expected) {
        Write-Host "PASSED" -ForegroundColor Green
        return $true
    } else {
        Write-Host "FAILED" -ForegroundColor Red
        return $false
    }
}

# Track test results
$totalTests = 0
$passedTests = 0

Write-Host "===================================================" -ForegroundColor Magenta
Write-Host "  Maximise String Score - Test Suite" -ForegroundColor Magenta
Write-Host "===================================================" -ForegroundColor Magenta

# Example 1 from problem
$totalTests++
if (Test-Case -TestName "Example 1: Basic jump sequence" -InputString "forgfg" -Jumps @(@('f', 'r'), @('r', 'g')) -Expected 429) {
    $passedTests++
}

Write-Host "`nDetailed trace for Example 1:"
Write-Host "String: f o r g f g"
Write-Host "Index:  0 1 2 3 4 5"
Write-Host "ASCII:  102 111 114 103 102 103"
Write-Host "Jump from f at 0 to r at 2: score = 102 + 111 = 213"
Write-Host "Jump from r at 2 to g at 5: score = 114 + 102 = 216 (excluding g=103)"
Write-Host "Total = 213 + 216 = 429"

# Example 2 from problem
$totalTests++
if (Test-Case -TestName "Example 2: Same character jump" -InputString "abcda" -Jumps @(@('b', 'd')) -Expected 297) {
    $passedTests++
}

Write-Host "`nDetailed trace for Example 2:"
Write-Host "String: a b c d a"
Write-Host "Index:  0 1 2 3 4"
Write-Host "ASCII:  97 98 99 100 97"
Write-Host "Jump from a at 0 to a at 4: score = 98 + 99 + 100 = 297 (excluding a=97)"

# Test 3: Single character string
$totalTests++
if (Test-Case -TestName "Edge Case: Single character" -InputString "a" -Jumps @(@('a', 'b')) -Expected 0) {
    $passedTests++
}

# Test 4: No valid jumps possible
$totalTests++
if (Test-Case -TestName "Edge Case: No valid jumps" -InputString "abc" -Jumps @(@('x', 'y')) -Expected 0) {
    $passedTests++
}

# Test 5: Multiple occurrences of same character
$totalTests++
if (Test-Case -TestName "Multiple same character jumps" -InputString "aaaa" -Jumps @(@('a', 'a')) -Expected 0) {
    $passedTests++
}

Write-Host "`nNote: All 'a' characters have same ASCII, so excluding 'a' from range leaves 0"

# Test 6: Long chain of jumps
$totalTests++
if (Test-Case -TestName "Chain of jumps" -InputString "abcabc" -Jumps @(@('a', 'b'), @('b', 'c')) -Expected 587) {
    $passedTests++
}

# Test 7: Complex scenario with multiple rules
$totalTests++
if (Test-Case -TestName "Multiple jump options" -InputString "abcd" -Jumps @(@('a', 'b'), @('a', 'c'), @('a', 'd'), @('b', 'c'), @('b', 'd'), @('c', 'd')) -Expected 494) {
    $passedTests++
}

# Test 8: Same character repeated
$totalTests++
if (Test-Case -TestName "Repeated characters with jumps" -InputString "aabba" -Jumps @(@('a', 'b')) -Expected 294) {
    $passedTests++
}

# Display summary
Write-Host "`n===================================================" -ForegroundColor Magenta
Write-Host "  Test Summary" -ForegroundColor Magenta
Write-Host "===================================================" -ForegroundColor Magenta
Write-Host "Total Tests:  $totalTests"
Write-Host "Passed:       $passedTests" -ForegroundColor Green
Write-Host "Failed:       $($totalTests - $passedTests)" -ForegroundColor $(if ($totalTests -eq $passedTests) { "Green" } else { "Red" })
Write-Host "Success Rate: $([math]::Round(($passedTests / $totalTests) * 100, 2))%"

if ($totalTests -eq $passedTests) {
    Write-Host "`nAll tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome tests failed!" -ForegroundColor Red
    exit 1
}

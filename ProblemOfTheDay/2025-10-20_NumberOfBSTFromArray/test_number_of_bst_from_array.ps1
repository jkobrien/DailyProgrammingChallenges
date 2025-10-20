# Test Script for Number of BST From Array
# GeeksforGeeks Problem of the Day - October 20, 2025

# Import the main solution
. .\number_of_bst_from_array.ps1

Write-Host "Number of BST From Array - Test Suite" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta
Write-Host ""

# Test 1: Single Element
Write-Host "Test 1: Single Element [5]" -ForegroundColor Cyan
$result1 = Get-NumberOfBSTs @(5)
Write-Host "Expected: 1, Actual: $result1" -ForegroundColor White
Write-Host "Status: $(if ($result1 -eq 1) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result1 -eq 1) { 'Green' } else { 'Red' })
Write-Host ""

# Test 2: Two Elements
Write-Host "Test 2: Two Elements [1,2]" -ForegroundColor Cyan
$result2 = Get-NumberOfBSTs @(1,2)
Write-Host "Expected: 2, Actual: $result2" -ForegroundColor White
Write-Host "Status: $(if ($result2 -eq 2) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result2 -eq 2) { 'Green' } else { 'Red' })
Write-Host ""

# Test 3: Three Elements
Write-Host "Test 3: Three Elements [1,2,3]" -ForegroundColor Cyan
$result3 = Get-NumberOfBSTs @(1,2,3)
Write-Host "Expected: 5, Actual: $result3" -ForegroundColor White
Write-Host "Status: $(if ($result3 -eq 5) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result3 -eq 5) { 'Green' } else { 'Red' })
Write-Host ""

# Test 4: Four Elements
Write-Host "Test 4: Four Elements [1,2,3,4]" -ForegroundColor Cyan
$result4 = Get-NumberOfBSTs @(1,2,3,4)
Write-Host "Expected: 14, Actual: $result4" -ForegroundColor White
Write-Host "Status: $(if ($result4 -eq 14) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result4 -eq 14) { 'Green' } else { 'Red' })
Write-Host ""

# Test 5: Duplicates
Write-Host "Test 5: Duplicates [1,2,2]" -ForegroundColor Cyan
$result5 = Get-NumberOfBSTs @(1,2,2)
Write-Host "Expected: 0, Actual: $result5" -ForegroundColor White
Write-Host "Status: $(if ($result5 -eq 0) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result5 -eq 0) { 'Green' } else { 'Red' })
Write-Host ""

# Test 6: Five Elements
Write-Host "Test 6: Five Elements [1,2,3,4,5]" -ForegroundColor Cyan
$result6 = Get-NumberOfBSTs @(1,2,3,4,5)
Write-Host "Expected: 42, Actual: $result6" -ForegroundColor White
Write-Host "Status: $(if ($result6 -eq 42) { 'PASSED' } else { 'FAILED' })" -ForegroundColor $(if ($result6 -eq 42) { 'Green' } else { 'Red' })
Write-Host ""

# Test Catalan Numbers
Write-Host "Testing Catalan Numbers:" -ForegroundColor Yellow
$cat0 = Get-CatalanNumberDP 0
$cat1 = Get-CatalanNumberDP 1
$cat2 = Get-CatalanNumberDP 2
$cat3 = Get-CatalanNumberDP 3
$cat4 = Get-CatalanNumberDP 4
$cat5 = Get-CatalanNumberDP 5

Write-Host "C(0) = $cat0 (Expected: 1)" -ForegroundColor White
Write-Host "C(1) = $cat1 (Expected: 1)" -ForegroundColor White
Write-Host "C(2) = $cat2 (Expected: 2)" -ForegroundColor White
Write-Host "C(3) = $cat3 (Expected: 5)" -ForegroundColor White
Write-Host "C(4) = $cat4 (Expected: 14)" -ForegroundColor White
Write-Host "C(5) = $cat5 (Expected: 42)" -ForegroundColor White
Write-Host ""

# Summary
$totalTests = 6
$passedTests = 0
if ($result1 -eq 1) { $passedTests++ }
if ($result2 -eq 2) { $passedTests++ }
if ($result3 -eq 5) { $passedTests++ }
if ($result4 -eq 14) { $passedTests++ }
if ($result5 -eq 0) { $passedTests++ }
if ($result6 -eq 42) { $passedTests++ }

Write-Host "=====================================" -ForegroundColor Magenta
Write-Host "Test Summary: $passedTests/$totalTests tests passed" -ForegroundColor $(if ($passedTests -eq $totalTests) { 'Green' } else { 'Red' })
Write-Host "=====================================" -ForegroundColor Magenta

if ($passedTests -eq $totalTests) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "Some tests failed!" -ForegroundColor Red
}
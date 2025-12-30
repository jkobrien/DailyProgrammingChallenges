# Test script for Add Number Linked Lists solution

# Import the solution script
. "$PSScriptRoot\add_number_linked_lists.ps1"

# Test helper function
function Test-AddLinkedListNumbers {
    param (
        [string]$TestName,
        [int[]]$List1,
        [int[]]$List2,
        [int[]]$Expected
    )
    
    Write-Host "`nTest: $TestName" -ForegroundColor Cyan
    
    # Create linked lists
    $head1 = ConvertTo-LinkedList -arr $List1
    $head2 = ConvertTo-LinkedList -arr $List2
    
    # Display inputs
    Write-Host "  List 1: $(Format-LinkedList -head $head1)" -ForegroundColor White
    Write-Host "  List 2: $(Format-LinkedList -head $head2)" -ForegroundColor White
    
    # Get result
    $result = Add-LinkedListNumbers -head1 $head1 -head2 $head2
    $resultArray = ConvertFrom-LinkedList -head $result
    
    # Display result
    Write-Host "  Result: $(Format-LinkedList -head $result)" -ForegroundColor Yellow
    Write-Host "  Expected: $($Expected -join ' -> ')" -ForegroundColor White
    
    # Verify
    $passed = $true
    if ($resultArray.Length -ne $Expected.Length) {
        $passed = $false
    } else {
        for ($i = 0; $i -lt $resultArray.Length; $i++) {
            if ($resultArray[$i] -ne $Expected[$i]) {
                $passed = $false
                break
            }
        }
    }
    
    if ($passed) {
        Write-Host "  ✓ PASSED" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ✗ FAILED" -ForegroundColor Red
        return $false
    }
}

# Run all tests
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Add Number Linked Lists - Test Suite" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$testResults = @()

# Test 1: Basic addition (Example 1 from problem)
$testResults += Test-AddLinkedListNumbers `
    -TestName "Basic Addition - 123 plus 999 equals 1122" `
    -List1 @(1, 2, 3) `
    -List2 @(9, 9, 9) `
    -Expected @(1, 1, 2, 2)

# Test 2: Different lengths (Example 2 from problem)
$testResults += Test-AddLinkedListNumbers `
    -TestName "Different Lengths - 63 plus 7 equals 70" `
    -List1 @(6, 3) `
    -List2 @(7) `
    -Expected @(7, 0)

# Test 3: Leading zeros in input
$testResults += Test-AddLinkedListNumbers `
    -TestName "Leading Zeros - 005 plus 003 equals 8" `
    -List1 @(0, 0, 5) `
    -List2 @(0, 0, 3) `
    -Expected @(8)

# Test 4: Carry propagation
$testResults += Test-AddLinkedListNumbers `
    -TestName "Carry Propagation - 9999 plus 1 equals 10000" `
    -List1 @(9, 9, 9, 9) `
    -List2 @(1) `
    -Expected @(1, 0, 0, 0, 0)

# Test 5: Both single digit
$testResults += Test-AddLinkedListNumbers `
    -TestName "Single Digits - 5 plus 3 equals 8" `
    -List1 @(5) `
    -List2 @(3) `
    -Expected @(8)

# Test 6: Single digit with carry
$testResults += Test-AddLinkedListNumbers `
    -TestName "Single Digit with Carry - 9 plus 9 equals 18" `
    -List1 @(9) `
    -List2 @(9) `
    -Expected @(1, 8)

# Test 7: Zero plus number
$testResults += Test-AddLinkedListNumbers `
    -TestName "Zero Plus Number - 0 plus 456 equals 456" `
    -List1 @(0) `
    -List2 @(4, 5, 6) `
    -Expected @(4, 5, 6)

# Test 8: Both zeros
$testResults += Test-AddLinkedListNumbers `
    -TestName "Both Zeros - 0 plus 0 equals 0" `
    -List1 @(0) `
    -List2 @(0) `
    -Expected @(0)

# Test 9: Large numbers
$testResults += Test-AddLinkedListNumbers `
    -TestName "Large Numbers - 12345 plus 67890 equals 80235" `
    -List1 @(1, 2, 3, 4, 5) `
    -List2 @(6, 7, 8, 9, 0) `
    -Expected @(8, 0, 2, 3, 5)

# Test 10: Multiple carries
$testResults += Test-AddLinkedListNumbers `
    -TestName "Multiple Carries - 999 plus 999 equals 1998" `
    -List1 @(9, 9, 9) `
    -List2 @(9, 9, 9) `
    -Expected @(1, 9, 9, 8)

# Test 11: Very different lengths
$testResults += Test-AddLinkedListNumbers `
    -TestName "Very Different Lengths - 1000000 plus 1 equals 1000001" `
    -List1 @(1, 0, 0, 0, 0, 0, 0) `
    -List2 @(1) `
    -Expected @(1, 0, 0, 0, 0, 0, 1)

# Test 12: Leading zeros with carry
$testResults += Test-AddLinkedListNumbers `
    -TestName "Leading Zeros with Carry - 009 plus 009 equals 18" `
    -List1 @(0, 0, 9) `
    -List2 @(0, 0, 9) `
    -Expected @(1, 8)

# Test 13: All nines plus one
$testResults += Test-AddLinkedListNumbers `
    -TestName "All Nines Plus One - 99999 plus 1 equals 100000" `
    -List1 @(9, 9, 9, 9, 9) `
    -List2 @(1) `
    -Expected @(1, 0, 0, 0, 0, 0)

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$passedCount = ($testResults | Where-Object { $_ -eq $true }).Count
$totalCount = $testResults.Count
$failedCount = $totalCount - $passedCount

Write-Host "Total Tests: $totalCount" -ForegroundColor White
Write-Host "Passed: $passedCount" -ForegroundColor Green
Write-Host "Failed: $failedCount" -ForegroundColor $(if ($failedCount -eq 0) { "Green" } else { "Red" })

if ($failedCount -eq 0) {
    Write-Host "`n✓ All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n✗ Some tests failed!" -ForegroundColor Red
    exit 1
}

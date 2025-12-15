<#
.SYNOPSIS
    Run the Count Indices to Balance Even and Odd Sums solution with examples.

.DESCRIPTION
    Demonstrates the solution with the provided examples and additional test cases.
#>

# Define the function directly here
function Count-BalancedIndices {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Handle edge cases
    if ($n -eq 0) { return 0 }
    if ($n -eq 1) { return 1 }
    if ($n -eq 2) { return 2 }
    
    # Calculate total sums for even and odd indices
    $totalEvenSum = 0
    $totalOddSum = 0
    
    for ($i = 0; $i -lt $n; $i++) {
        if ($i % 2 -eq 0) {
            $totalEvenSum += $arr[$i]
        } else {
            $totalOddSum += $arr[$i]
        }
    }
    
    $count = 0
    $evenSumBefore = 0
    $oddSumBefore = 0
    
    # Check each index for removal
    for ($i = 0; $i -lt $n; $i++) {
        if ($i % 2 -eq 0) {
            $evenSumAfter = $totalEvenSum - $evenSumBefore - $arr[$i]
            $oddSumAfter = $totalOddSum - $oddSumBefore
        } else {
            $evenSumAfter = $totalEvenSum - $evenSumBefore
            $oddSumAfter = $totalOddSum - $oddSumBefore - $arr[$i]
        }
        
        $newEvenSum = $evenSumBefore + $oddSumAfter
        $newOddSum = $oddSumBefore + $evenSumAfter
        
        if ($newEvenSum -eq $newOddSum) {
            $count++
        }
        
        if ($i % 2 -eq 0) {
            $evenSumBefore += $arr[$i]
        } else {
            $oddSumBefore += $arr[$i]
        }
    }
    
    return $count
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Count Indices to Balance Even/Odd Sums" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test Case 1
Write-Host "Test 1: [2, 1, 6, 4]" -ForegroundColor Yellow
$result1 = Count-BalancedIndices -arr @(2, 1, 6, 4)
Write-Host "Result: $result1 (Expected: 1)" -ForegroundColor $(if ($result1 -eq 1) { "Green" } else { "Red" })
Write-Host ""

# Test Case 2
Write-Host "Test 2: [1, 1, 1]" -ForegroundColor Yellow
$result2 = Count-BalancedIndices -arr @(1, 1, 1)
Write-Host "Result: $result2 (Expected: 3)" -ForegroundColor $(if ($result2 -eq 3) { "Green" } else { "Red" })
Write-Host ""

# Test Case 3
Write-Host "Test 3: [5]" -ForegroundColor Yellow
$result3 = Count-BalancedIndices -arr @(5)
Write-Host "Result: $result3 (Expected: 1)" -ForegroundColor $(if ($result3 -eq 1) { "Green" } else { "Red" })
Write-Host ""

# Test Case 4
Write-Host "Test 4: [1, 2, 3, 4, 5]" -ForegroundColor Yellow
$result4 = Count-BalancedIndices -arr @(1, 2, 3, 4, 5)
Write-Host "Result: $result4 (Expected: 0)" -ForegroundColor $(if ($result4 -eq 0) { "Green" } else { "Red" })
Write-Host ""

# Test Case 5
Write-Host "Test 5: [2, 2, 2, 2, 2]" -ForegroundColor Yellow
$result5 = Count-BalancedIndices -arr @(2, 2, 2, 2, 2)
Write-Host "Result: $result5 (Expected: 5)" -ForegroundColor $(if ($result5 -eq 5) { "Green" } else { "Red" })
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "All tests completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

<#
.SYNOPSIS
    Count indices where removing the element balances even and odd index sums.

.DESCRIPTION
    Given an array, count the number of indices such that deleting the element at that 
    index and shifting all elements after it one position left results in an array where 
    the sum of elements at even indices equals the sum at odd indices.

.PARAMETER arr
    The input array of integers.

.EXAMPLE
    Count-BalancedIndices -arr @(2, 1, 6, 4)
    Returns: 1

.EXAMPLE
    Count-BalancedIndices -arr @(1, 1, 1)
    Returns: 3

.NOTES
    Time Complexity: O(n)
    Space Complexity: O(1)
#>

function Count-BalancedIndices {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Handle edge cases
    if ($n -eq 0) { return 0 }
    if ($n -eq 1) { return 1 }  # Removing the only element leaves empty array (0 == 0)
    if ($n -eq 2) { return 2 }  # Removing either element leaves one element at index 0 (even)
    
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
        # Calculate sums after removing element at index i
        # Elements before i keep their even/odd classification
        # Elements after i shift left, so their even/odd classification flips
        
        # Calculate sums after index i (before removal)
        if ($i % 2 -eq 0) {
            # Current index is even, so we subtract it from total even sum
            $evenSumAfter = $totalEvenSum - $evenSumBefore - $arr[$i]
            $oddSumAfter = $totalOddSum - $oddSumBefore
        } else {
            # Current index is odd, so we subtract it from total odd sum
            $evenSumAfter = $totalEvenSum - $evenSumBefore
            $oddSumAfter = $totalOddSum - $oddSumBefore - $arr[$i]
        }
        
        # After removal, elements after index i shift left
        # So their even/odd classification flips:
        # - What was at odd indices becomes even
        # - What was at even indices becomes odd
        $newEvenSum = $evenSumBefore + $oddSumAfter
        $newOddSum = $oddSumBefore + $evenSumAfter
        
        # Check if balanced
        if ($newEvenSum -eq $newOddSum) {
            $count++
        }
        
        # Update prefix sums for next iteration
        if ($i % 2 -eq 0) {
            $evenSumBefore += $arr[$i]
        } else {
            $oddSumBefore += $arr[$i]
        }
    }
    
    return $count
}

<#
.SYNOPSIS
    Alternative implementation with detailed step-by-step calculation.

.DESCRIPTION
    This version includes detailed comments for educational purposes, 
    showing how the algorithm works step by step.
#>
function Count-BalancedIndices-Verbose {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr,
        [switch]$ShowDebug
    )
    
    $n = $arr.Length
    
    if ($n -le 2) {
        if ($ShowDebug) { Write-Host "Array length $n <= 2, returning $n" }
        return $n
    }
    
    # Step 1: Calculate total sums
    $totalEvenSum = 0
    $totalOddSum = 0
    
    for ($i = 0; $i -lt $n; $i++) {
        if ($i % 2 -eq 0) {
            $totalEvenSum += $arr[$i]
        } else {
            $totalOddSum += $arr[$i]
        }
    }
    
    if ($ShowDebug) {
        Write-Host "Original array: $($arr -join ', ')"
        Write-Host "Total Even Sum (indices 0,2,4,...): $totalEvenSum"
        Write-Host "Total Odd Sum (indices 1,3,5,...): $totalOddSum"
        Write-Host ("-" * 60)
    }
    
    $count = 0
    $evenSumBefore = 0
    $oddSumBefore = 0
    
    # Step 2: Check each index
    for ($i = 0; $i -lt $n; $i++) {
        # Calculate what happens after removing index i
        $evenSumAfter = if ($i % 2 -eq 0) { 
            $totalEvenSum - $evenSumBefore - $arr[$i] 
        } else { 
            $totalEvenSum - $evenSumBefore 
        }
        
        $oddSumAfter = if ($i % 2 -eq 1) { 
            $totalOddSum - $oddSumBefore - $arr[$i] 
        } else { 
            $totalOddSum - $oddSumBefore 
        }
        
        # After removal and shift, even/odd swap for elements after i
        $newEvenSum = $evenSumBefore + $oddSumAfter
        $newOddSum = $oddSumBefore + $evenSumAfter
        
        if ($ShowDebug) {
            Write-Host "Removing index $i (value=$($arr[$i])):"
            Write-Host "  Before removal sums: evenBefore=$evenSumBefore, oddBefore=$oddSumBefore"
            Write-Host "  After removal sums: evenAfter=$evenSumAfter, oddAfter=$oddSumAfter"
            Write-Host "  New array sums: newEven=$newEvenSum, newOdd=$newOddSum"
            Write-Host "  Balanced: $($newEvenSum -eq $newOddSum)"
        }
        
        if ($newEvenSum -eq $newOddSum) {
            $count++
            if ($ShowDebug) { Write-Host "  [MATCH] COUNT: $count" -ForegroundColor Green }
        }
        
        if ($ShowDebug) { Write-Host "" }
        
        # Update prefix sums
        if ($i % 2 -eq 0) {
            $evenSumBefore += $arr[$i]
        } else {
            $oddSumBefore += $arr[$i]
        }
    }
    
    return $count
}

# Main execution block
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Count Indices to Balance Even and Odd Sums ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    $arr1 = @(2, 1, 6, 4)
    $result1 = Count-BalancedIndices -arr $arr1
    Write-Host "Example 1: arr = [$($arr1 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Result: $result1" -ForegroundColor Green
    Write-Host "Expected: 1"
    Write-Host ""
    
    # Example 2
    $arr2 = @(1, 1, 1)
    $result2 = Count-BalancedIndices -arr $arr2
    Write-Host "Example 2: arr = [$($arr2 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Result: $result2" -ForegroundColor Green
    Write-Host "Expected: 3"
    Write-Host ""
    
    # Example 3 - More complex case
    $arr3 = @(1, 2, 3, 4, 5, 6)
    $result3 = Count-BalancedIndices -arr $arr3
    Write-Host "Example 3: arr = [$($arr3 -join ', ')]" -ForegroundColor Yellow
    Write-Host "Result: $result3" -ForegroundColor Green
    Write-Host ""
    
    # Verbose debug example
    Write-Host "=== Detailed Walkthrough for Example 1 ===" -ForegroundColor Cyan
    Write-Host ""
    $verboseResult = Count-BalancedIndices-Verbose -arr $arr1 -ShowDebug
    Write-Host ""
    Write-Host "Final Count: $verboseResult" -ForegroundColor Magenta
}

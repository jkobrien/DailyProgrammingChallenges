<#
.SYNOPSIS
    Count Indices to Balance Even and Odd Sums

.DESCRIPTION
    Given an array arr[], count the number of indices such that deleting 
    the element at that index and shifting all elements after it one position 
    left results in an array where the sum of elements at even indices equals 
    the sum at odd indices.

.PARAMETER arr
    An array of integers

.EXAMPLE
    CountBalancedIndices @(2, 1, 6, 4)
    Output: 1

.EXAMPLE
    CountBalancedIndices @(1, 1, 1)
    Output: 3
#>

function CountBalancedIndices {
    param (
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Edge case: array with single element
    if ($n -eq 1) {
        return 1  # After removing the only element, both sums are 0
    }
    
    # Edge case: array with two elements
    if ($n -eq 2) {
        # After removing either element, we have single element array
        # Single element at index 0 (even) means: evenSum = element, oddSum = 0
        # This is never balanced unless the element is 0
        if ($arr[0] -eq 0 -and $arr[1] -eq 0) {
            return 2
        } elseif ($arr[0] -eq 0) {
            return 1  # Removing index 1 leaves [0]
        } elseif ($arr[1] -eq 0) {
            return 1  # Removing index 0 leaves [0]
        }
        return 0
    }
    
    # Calculate initial even and odd sums
    $evenSum = 0
    $oddSum = 0
    
    for ($i = 0; $i -lt $n; $i++) {
        if ($i % 2 -eq 0) {
            $evenSum += $arr[$i]
        } else {
            $oddSum += $arr[$i]
        }
    }
    
    $count = 0
    $evenSumBefore = 0
    $oddSumBefore = 0
    
    # Try removing each element
    for ($i = 0; $i -lt $n; $i++) {
        # Calculate even and odd sums after removing element at index i
        
        # After removal, elements before i stay the same
        # Elements after i shift left, so even becomes odd and vice versa
        
        if ($i % 2 -eq 0) {
            # Removing element at even index
            # Even sum after removal = evenSumBefore + (oddSum - oddSumBefore)
            # Odd sum after removal = oddSumBefore + (evenSum - evenSumBefore - arr[i])
            $newEvenSum = $evenSumBefore + ($oddSum - $oddSumBefore)
            $newOddSum = $oddSumBefore + ($evenSum - $evenSumBefore - $arr[$i])
        } else {
            # Removing element at odd index
            # Even sum after removal = evenSumBefore + (oddSum - oddSumBefore - arr[i])
            # Odd sum after removal = oddSumBefore + (evenSum - evenSumBefore)
            $newEvenSum = $evenSumBefore + ($oddSum - $oddSumBefore - $arr[$i])
            $newOddSum = $oddSumBefore + ($evenSum - $evenSumBefore)
        }
        
        # Check if balanced
        if ($newEvenSum -eq $newOddSum) {
            $count++
        }
        
        # Update running sums
        if ($i % 2 -eq 0) {
            $evenSumBefore += $arr[$i]
        } else {
            $oddSumBefore += $arr[$i]
        }
    }
    
    return $count
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "Count Indices to Balance Even and Odd Sums" -ForegroundColor Cyan
    Write-Host ("=" * 50) -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    $arr1 = @(2, 1, 6, 4)
    $result1 = CountBalancedIndices $arr1
    Write-Host "Example 1:" -ForegroundColor Yellow
    Write-Host "Input:  arr[] = [$($arr1 -join ', ')]"
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 1"
    Write-Host ""
    
    # Example 2
    $arr2 = @(1, 1, 1)
    $result2 = CountBalancedIndices $arr2
    Write-Host "Example 2:" -ForegroundColor Yellow
    Write-Host "Input:  arr[] = [$($arr2 -join ', ')]"
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 3"
    Write-Host ""
    
    # Additional example
    $arr3 = @(1, 2, 3)
    $result3 = CountBalancedIndices $arr3
    Write-Host "Example 3:" -ForegroundColor Yellow
    Write-Host "Input:  arr[] = [$($arr3 -join ', ')]"
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host ""
}

<#
.SYNOPSIS
    Find the K-th element in two sorted arrays

.DESCRIPTION
    Given two sorted arrays a[] and b[] and an element k, find the element
    that would be at the k-th position of the combined sorted array.
    
    This implementation provides both:
    1. Simple two-pointer merge approach - O(k) time
    2. Optimal binary search approach - O(log(min(n,m))) time

.EXAMPLE
    $result = Find-KthElement -a @(2, 3, 6, 7, 9) -b @(1, 4, 8, 10) -k 5
    # Returns: 6

.NOTES
    Time Complexity: O(log(min(n,m))) for binary search
    Space Complexity: O(1)
#>

function Find-KthElement {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$a,
        
        [Parameter(Mandatory=$true)]
        [int[]]$b,
        
        [Parameter(Mandatory=$true)]
        [int]$k
    )
    
    $n = $a.Length
    $m = $b.Length
    
    # Ensure a is the smaller array for binary search optimization
    if ($n -gt $m) {
        return Find-KthElement -a $b -b $a -k $k
    }
    
    # Binary search on the smaller array
    $low = [Math]::Max(0, $k - $m)
    $high = [Math]::Min($k, $n)
    
    while ($low -le $high) {
        $cut1 = [Math]::Floor(($low + $high) / 2)
        $cut2 = $k - $cut1
        
        # Handle edge cases for partition boundaries
        $left1 = if ($cut1 -eq 0) { [int]::MinValue } else { $a[$cut1 - 1] }
        $left2 = if ($cut2 -eq 0) { [int]::MinValue } else { $b[$cut2 - 1] }
        
        $right1 = if ($cut1 -eq $n) { [int]::MaxValue } else { $a[$cut1] }
        $right2 = if ($cut2 -eq $m) { [int]::MaxValue } else { $b[$cut2] }
        
        # Check if we found the correct partition
        if ($left1 -le $right2 -and $left2 -le $right1) {
            # The k-th element is the maximum of left partition
            return [Math]::Max($left1, $left2)
        }
        elseif ($left1 -gt $right2) {
            # Move towards left in array a
            $high = $cut1 - 1
        }
        else {
            # Move towards right in array a
            $low = $cut1 + 1
        }
    }
    
    return -1  # Should never reach here with valid input
}

function Find-KthElement-Simple {
    <#
    .SYNOPSIS
        Simple two-pointer approach to find k-th element
    
    .DESCRIPTION
        Merges two sorted arrays using two pointers until k-th element is found.
        Time Complexity: O(k)
        Space Complexity: O(1)
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$a,
        
        [Parameter(Mandatory=$true)]
        [int[]]$b,
        
        [Parameter(Mandatory=$true)]
        [int]$k
    )
    
    $n = $a.Length
    $m = $b.Length
    $i = 0
    $j = 0
    $count = 0
    $result = -1
    
    # Traverse both arrays simultaneously
    while ($i -lt $n -and $j -lt $m) {
        if ($a[$i] -le $b[$j]) {
            $result = $a[$i]
            $i++
        }
        else {
            $result = $b[$j]
            $j++
        }
        
        $count++
        if ($count -eq $k) {
            return $result
        }
    }
    
    # If elements remain in array a
    while ($i -lt $n) {
        $result = $a[$i]
        $i++
        $count++
        if ($count -eq $k) {
            return $result
        }
    }
    
    # If elements remain in array b
    while ($j -lt $m) {
        $result = $b[$j]
        $j++
        $count++
        if ($count -eq $k) {
            return $result
        }
    }
    
    return $result
}

# Main execution example
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== K-th Element of Two Sorted Arrays ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $a1 = @(2, 3, 6, 7, 9)
    $b1 = @(1, 4, 8, 10)
    $k1 = 5
    Write-Host "Input: a = [$($a1 -join ', ')], b = [$($b1 -join ', ')], k = $k1"
    
    $result1_binary = Find-KthElement -a $a1 -b $b1 -k $k1
    $result1_simple = Find-KthElement-Simple -a $a1 -b $b1 -k $k1
    
    Write-Host "Output (Binary Search): $result1_binary" -ForegroundColor Green
    Write-Host "Output (Simple): $result1_simple" -ForegroundColor Green
    Write-Host "Expected: 6"
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $a2 = @(1, 4, 8, 10, 12)
    $b2 = @(5, 7, 11, 15, 17)
    $k2 = 6
    Write-Host "Input: a = [$($a2 -join ', ')], b = [$($b2 -join ', ')], k = $k2"
    
    $result2_binary = Find-KthElement -a $a2 -b $b2 -k $k2
    $result2_simple = Find-KthElement-Simple -a $a2 -b $b2 -k $k2
    
    Write-Host "Output (Binary Search): $result2_binary" -ForegroundColor Green
    Write-Host "Output (Simple): $result2_simple" -ForegroundColor Green
    Write-Host "Expected: 10"
    Write-Host ""
    
    # Example 3 - Edge case with k=1
    Write-Host "Example 3 (Edge case k=1):" -ForegroundColor Yellow
    $a3 = @(100, 200)
    $b3 = @(50, 150, 250)
    $k3 = 1
    Write-Host "Input: a = [$($a3 -join ', ')], b = [$($b3 -join ', ')], k = $k3"
    
    $result3_binary = Find-KthElement -a $a3 -b $b3 -k $k3
    $result3_simple = Find-KthElement-Simple -a $a3 -b $b3 -k $k3
    
    Write-Host "Output (Binary Search): $result3_binary" -ForegroundColor Green
    Write-Host "Output (Simple): $result3_simple" -ForegroundColor Green
    Write-Host "Expected: 50"
    Write-Host ""
    
    # Example 4 - Edge case with k at the end
    Write-Host "Example 4 (Edge case k at end):" -ForegroundColor Yellow
    $a4 = @(1, 2)
    $b4 = @(3, 4, 5)
    $k4 = 5
    Write-Host "Input: a = [$($a4 -join ', ')], b = [$($b4 -join ', ')], k = $k4"
    
    $result4_binary = Find-KthElement -a $a4 -b $b4 -k $k4
    $result4_simple = Find-KthElement-Simple -a $a4 -b $b4 -k $k4
    
    Write-Host "Output (Binary Search): $result4_binary" -ForegroundColor Green
    Write-Host "Output (Simple): $result4_simple" -ForegroundColor Green
    Write-Host "Expected: 5"
    Write-Host ""
    
    Write-Host "=== Algorithm Explanation ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Binary Search Approach (Optimal):" -ForegroundColor Yellow
    Write-Host "1. Ensure we binary search on the smaller array"
    Write-Host "2. Find a partition point where left partition has exactly k elements"
    Write-Host "3. The k-th element is the maximum of the left partition"
    Write-Host "4. Time Complexity: O(log(min(n, m)))"
    Write-Host ""
    Write-Host "Two-Pointer Approach (Simple):" -ForegroundColor Yellow
    Write-Host "1. Use two pointers to traverse both arrays"
    Write-Host "2. Compare elements and move the pointer with smaller element"
    Write-Host "3. Stop when we reach the k-th element"
    Write-Host "4. Time Complexity: O(k)"
}

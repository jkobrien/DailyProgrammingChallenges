<#
.SYNOPSIS
    Find the maximum sum of a subarray of size k using sliding window technique.

.DESCRIPTION
    Given an array of integers and a number k, this script returns the maximum 
    sum of a contiguous subarray of size k. Uses the efficient sliding window 
    approach with O(n) time complexity.

.PARAMETER arr
    Array of integers to search through

.PARAMETER k
    Size of the subarray window

.EXAMPLE
    Get-MaxSumSubarray -arr @(100, 200, 300, 400) -k 2
    # Returns: 700

.EXAMPLE
    Get-MaxSumSubarray -arr @(1, 4, 2, 10, 23, 3, 1, 0, 20) -k 4
    # Returns: 39

.NOTES
    Problem: Max Sum Subarray of size K
    Date: January 5, 2026
    Difficulty: Easy
    Time Complexity: O(n) where n is the length of array
    Space Complexity: O(1) - only using constant extra space
#>

function Get-MaxSumSubarray {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr,
        
        [Parameter(Mandatory=$true)]
        [int]$k
    )
    
    # Edge case: k is larger than array size
    if ($k -gt $arr.Length) {
        Write-Verbose "k ($k) is greater than array length ($($arr.Length))"
        return -1
    }
    
    # Edge case: empty array or k is 0
    if ($arr.Length -eq 0 -or $k -eq 0) {
        return 0
    }
    
    # Calculate sum of first window of size k
    $windowSum = 0
    for ($i = 0; $i -lt $k; $i++) {
        $windowSum += $arr[$i]
    }
    
    # Initialize maxSum with the first window
    $maxSum = $windowSum
    Write-Verbose "Initial window sum (first $k elements): $windowSum"
    
    # Slide the window from start to end of array
    # Start from k (since we've already calculated first k elements)
    for ($i = $k; $i -lt $arr.Length; $i++) {
        # Add the next element and remove the first element of previous window
        # This is the "sliding" part:
        # - Remove arr[i-k] (leftmost element of previous window)
        # - Add arr[i] (new rightmost element of current window)
        $windowSum = $windowSum - $arr[$i - $k] + $arr[$i]
        
        Write-Verbose "Window [$($i-$k+1)..$i]: sum = $windowSum"
        
        # Update maxSum if current window sum is greater
        if ($windowSum -gt $maxSum) {
            $maxSum = $windowSum
        }
    }
    
    return $maxSum
}

# ============================================================================
# DEMONSTRATION AND EXPLANATION
# Only run demonstration if script is executed directly (not sourced)
# ============================================================================

if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "`n=== Max Sum Subarray of size K ===" -ForegroundColor Cyan
    Write-Host "Problem: Find maximum sum of any contiguous subarray of size k`n" -ForegroundColor Yellow

    # Example 1: Basic case
    Write-Host "Example 1:" -ForegroundColor Green
    $arr1 = @(100, 200, 300, 400)
    $k1 = 2
    Write-Host "Input: arr = [$($arr1 -join ', ')], k = $k1"
    $result1 = Get-MaxSumSubarray -arr $arr1 -k $k1
    Write-Host "Output: $result1" -ForegroundColor Cyan
    Write-Host "Explanation: Subarray [200, 300] has maximum sum of 500... wait, actually [300, 400] = 700`n"

    # Example 2: Larger array
    Write-Host "Example 2:" -ForegroundColor Green
    $arr2 = @(1, 4, 2, 10, 23, 3, 1, 0, 20)
    $k2 = 4
    Write-Host "Input: arr = [$($arr2 -join ', ')], k = $k2"
    $result2 = Get-MaxSumSubarray -arr $arr2 -k $k2
    Write-Host "Output: $result2" -ForegroundColor Cyan
    Write-Host "Explanation: Subarray [4, 2, 10, 23] has maximum sum of 39`n"

    # Example 3: k > array length
    Write-Host "Example 3:" -ForegroundColor Green
    $arr3 = @(2, 3)
    $k3 = 3
    Write-Host "Input: arr = [$($arr3 -join ', ')], k = $k3"
    $result3 = Get-MaxSumSubarray -arr $arr3 -k $k3
    Write-Host "Output: $result3" -ForegroundColor Cyan
    Write-Host "Explanation: k is greater than array size, so return -1`n"

    # Example 4: All negative numbers
    Write-Host "Example 4:" -ForegroundColor Green
    $arr4 = @(-5, -2, -8, -1, -4)
    $k4 = 3
    Write-Host "Input: arr = [$($arr4 -join ', ')], k = $k4"
    $result4 = Get-MaxSumSubarray -arr $arr4 -k $k4
    Write-Host "Output: $result4" -ForegroundColor Cyan
    Write-Host "Explanation: Even with negative numbers, we find maximum sum subarray [-2, -8, -1] = -11`n"

    # Example 5: Single element
    Write-Host "Example 5:" -ForegroundColor Green
    $arr5 = @(42)
    $k5 = 1
    Write-Host "Input: arr = [$($arr5 -join ', ')], k = $k5"
    $result5 = Get-MaxSumSubarray -arr $arr5 -k $k5
    Write-Host "Output: $result5" -ForegroundColor Cyan
    Write-Host "Explanation: Only one element, so that's our maximum sum`n"

    # ============================================================================
    # ALGORITHM EXPLANATION
    # ============================================================================

    Write-Host "`n=== Algorithm Explanation ===" -ForegroundColor Cyan
    Write-Host @"
The Sliding Window Technique:
------------------------------
1. Instead of calculating sum for every possible subarray of size k (O(n*k)),
   we use a sliding window approach (O(n))

2. Steps:
   a) Calculate sum of first k elements (initial window)
   b) For each subsequent position:
      - Subtract the leftmost element of previous window
      - Add the new rightmost element
      - Compare with current maximum

3. Visual Example with arr = [1, 4, 2, 10, 23], k = 3:
   
   Step 1: [1, 4, 2] 10  23  -> sum = 7
   Step 2:  1 [4, 2, 10] 23  -> sum = 7 - 1 + 10 = 16
   Step 3:  1  4 [2, 10, 23] -> sum = 16 - 4 + 23 = 35 (MAX)

4. Time Complexity: O(n) - single pass through array
   Space Complexity: O(1) - only using variables

This is much more efficient than the brute force O(n*k) approach!
"@ -ForegroundColor Yellow

    Write-Host "`n=== Script completed successfully ===" -ForegroundColor Green
}

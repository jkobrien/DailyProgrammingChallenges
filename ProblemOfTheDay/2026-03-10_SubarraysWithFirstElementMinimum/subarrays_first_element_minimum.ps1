<#
.SYNOPSIS
    Counts subarrays where the first element is the minimum of that subarray.

.DESCRIPTION
    Given an integer array, this function counts the number of subarrays where 
    the first element is less than or equal to all other elements in the subarray.
    
    Approach: For each index i, find the next smaller element index j.
    The count of valid subarrays starting at i is (j - i).
    Uses a monotonic stack for O(n) time complexity.

.PARAMETER arr
    An array of integers.

.EXAMPLE
    Get-SubarraysWithFirstElementMinimum -arr @(1, 2, 1)
    Returns: 5

.EXAMPLE
    Get-SubarraysWithFirstElementMinimum -arr @(1, 3, 5, 2)
    Returns: 8
#>

function Get-SubarraysWithFirstElementMinimum {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Edge case: empty array
    if ($n -eq 0) {
        return 0
    }
    
    # Edge case: single element
    if ($n -eq 1) {
        return 1
    }
    
    # Array to store the index of next smaller element for each index
    # If no smaller element exists, store n (length of array)
    $nextSmaller = [int[]]::new($n)
    for ($idx = 0; $idx -lt $n; $idx++) {
        $nextSmaller[$idx] = $n
    }
    
    # Monotonic increasing stack (stores indices)
    # Stack contains indices of elements in increasing order of their values
    $stack = [System.Collections.Generic.Stack[int]]::new()
    
    # Process array from right to left
    for ($i = $n - 1; $i -ge 0; $i--) {
        # Pop elements from stack while they are >= current element
        # We need strictly smaller, so we pop elements that are >= arr[i]
        while ($stack.Count -gt 0 -and $arr[$stack.Peek()] -ge $arr[$i]) {
            $stack.Pop() | Out-Null
        }
        
        # If stack is not empty, top contains index of next smaller element
        if ($stack.Count -gt 0) {
            $nextSmaller[$i] = $stack.Peek()
        }
        # else nextSmaller[$i] remains n (no smaller element to the right)
        
        # Push current index to stack
        $stack.Push($i)
    }
    
    # Calculate the total count of valid subarrays
    # For each starting index i, the count is (nextSmaller[i] - i)
    [long]$totalCount = 0
    for ($i = 0; $i -lt $n; $i++) {
        $totalCount += ($nextSmaller[$i] - $i)
    }
    
    return $totalCount
}

<#
.SYNOPSIS
    Alternative brute force solution for verification (O(n²) time complexity).

.DESCRIPTION
    For each starting index, extends the subarray while the first element
    remains the minimum. Used for testing correctness.
#>
function Get-SubarraysWithFirstElementMinimumBruteForce {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    [long]$count = 0
    
    for ($i = 0; $i -lt $n; $i++) {
        $firstElement = $arr[$i]
        # The single element subarray is always valid
        $count++
        
        # Extend the subarray to the right
        for ($j = $i + 1; $j -lt $n; $j++) {
            # If we find an element smaller than the first, stop
            if ($arr[$j] -lt $firstElement) {
                break
            }
            # Otherwise, this subarray is valid
            $count++
        }
    }
    
    return $count
}

# Note: When dot-sourcing this script, both functions will be available automatically

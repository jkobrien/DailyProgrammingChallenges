<#
.SYNOPSIS
    Finds the longest span (subarray) with the same sum in two binary arrays.

.DESCRIPTION
    Given two binary arrays a1[] and a2[] of equal length, this function finds
    the length of the longest common span (i, j) where i <= j such that:
    sum(a1[i..j]) = sum(a2[i..j])

.PARAMETER a1
    First binary array (containing only 0s and 1s)

.PARAMETER a2
    Second binary array (containing only 0s and 1s)

.OUTPUTS
    Integer representing the length of the longest span with equal sum

.EXAMPLE
    Get-LongestSpan -a1 @(0,1,0,0,0,0) -a2 @(1,0,1,0,0,1)
    Returns: 4

.NOTES
    Algorithm: Difference Array + Prefix Sum + HashMap
    Time Complexity: O(n)
    Space Complexity: O(n)

    Key Insight:
    - If sum(a1[i..j]) = sum(a2[i..j]), then sum(diff[i..j]) = 0
      where diff[k] = a1[k] - a2[k]
    - Problem reduces to finding longest subarray with sum = 0
    - Use prefix sums: if prefixSum[j] == prefixSum[i-1], then sum(diff[i..j]) = 0
#>

function Get-LongestSpan {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [int[]]$a1 = @(),

        [Parameter(Mandatory = $false)]
        [int[]]$a2 = @()
    )

    # Handle empty arrays
    if ($null -eq $a1 -or $a1.Length -eq 0) {
        return 0
    }
    if ($null -eq $a2 -or $a2.Length -eq 0) {
        return 0
    }

    # Validate inputs
    if ($a1.Length -ne $a2.Length) {
        throw "Arrays must have equal length"
    }

    $n = $a1.Length

    # HashMap to store first occurrence of each prefix sum
    # Key: prefix sum value, Value: first index where this sum was seen
    # Initialize with {0: -1} to handle subarrays starting from index 0
    $prefixSumMap = @{}
    $prefixSumMap[0] = -1

    $prefixSum = 0
    $maxLength = 0

    for ($i = 0; $i -lt $n; $i++) {
        # Calculate difference and add to prefix sum
        # diff[i] = a1[i] - a2[i]
        $diff = $a1[$i] - $a2[$i]
        $prefixSum += $diff

        if ($prefixSumMap.ContainsKey($prefixSum)) {
            # We've seen this prefix sum before!
            # The subarray from (firstOccurrence + 1) to current index has sum = 0
            $length = $i - $prefixSumMap[$prefixSum]
            if ($length -gt $maxLength) {
                $maxLength = $length
            }
        }
        else {
            # First time seeing this prefix sum, store the index
            $prefixSumMap[$prefixSum] = $i
        }
    }

    return $maxLength
}

# ===============================================
# EXPLANATION OF THE ALGORITHM
# ===============================================
<#
Let's trace through Example 1:
a1 = [0, 1, 0, 0, 0, 0]
a2 = [1, 0, 1, 0, 0, 1]

Step 1: Create difference array (conceptually)
diff = [0-1, 1-0, 0-1, 0-0, 0-0, 0-1]
     = [-1,  1,  -1,   0,   0,  -1]

Step 2: Calculate prefix sums and track in HashMap

Index | a1[i] | a2[i] | diff | prefixSum | Action                    | maxLength
------|-------|-------|------|-----------|---------------------------|----------
init  |       |       |      | 0         | Store {0: -1}             | 0
  0   |   0   |   1   |  -1  | -1        | Store {-1: 0}             | 0
  1   |   1   |   0   |   1  | 0         | Found 0 at -1! len=1-(-1)=2| 2
  2   |   0   |   1   |  -1  | -1        | Found -1 at 0! len=2-0=2  | 2
  3   |   0   |   0   |   0  | -1        | Found -1 at 0! len=3-0=3  | 3
  4   |   0   |   0   |   0  | -1        | Found -1 at 0! len=4-0=4  | 4
  5   |   0   |   1   |  -1  | -2        | Store {-2: 5}             | 4

Result: 4 (subarray from index 1 to 4)

Why does this work?
- prefixSum[j] - prefixSum[i-1] = sum(diff[i..j])
- If prefixSum[j] == prefixSum[i-1], then sum(diff[i..j]) = 0
- sum(diff[i..j]) = 0 means sum(a1[i..j]) = sum(a2[i..j])
#>

# ===============================================
# ALTERNATIVE BRUTE FORCE SOLUTION (for verification)
# ===============================================
function Get-LongestSpanBruteForce {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$a1,

        [Parameter(Mandatory = $true)]
        [int[]]$a2
    )

    $n = $a1.Length
    $maxLength = 0

    # Try all possible subarrays
    for ($i = 0; $i -lt $n; $i++) {
        $sum1 = 0
        $sum2 = 0
        for ($j = $i; $j -lt $n; $j++) {
            $sum1 += $a1[$j]
            $sum2 += $a2[$j]

            if ($sum1 -eq $sum2) {
                $length = $j - $i + 1
                if ($length -gt $maxLength) {
                    $maxLength = $length
                }
            }
        }
    }

    return $maxLength
}

# ===============================================
# DEMO / MAIN EXECUTION
# ===============================================
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "Longest Span in Two Binary Arrays" -ForegroundColor Cyan
    Write-Host "=" * 60 -ForegroundColor Cyan

    # Example 1
    $a1 = @(0, 1, 0, 0, 0, 0)
    $a2 = @(1, 0, 1, 0, 0, 1)
    Write-Host "`nExample 1:" -ForegroundColor Yellow
    Write-Host "  a1 = [$($a1 -join ', ')]"
    Write-Host "  a2 = [$($a2 -join ', ')]"
    $result = Get-LongestSpan -a1 $a1 -a2 $a2
    Write-Host "  Longest span with equal sum: $result" -ForegroundColor Green
    Write-Host "  Expected: 4"

    # Example 2
    $a1 = @(0, 1, 0, 1, 1, 1, 1)
    $a2 = @(1, 1, 1, 1, 1, 0, 1)
    Write-Host "`nExample 2:" -ForegroundColor Yellow
    Write-Host "  a1 = [$($a1 -join ', ')]"
    Write-Host "  a2 = [$($a2 -join ', ')]"
    $result = Get-LongestSpan -a1 $a1 -a2 $a2
    Write-Host "  Longest span with equal sum: $result" -ForegroundColor Green
    Write-Host "  Expected: 6"

    # Example 3 - No common span
    $a1 = @(0, 0, 0)
    $a2 = @(1, 1, 1)
    Write-Host "`nExample 3 (no common span):" -ForegroundColor Yellow
    Write-Host "  a1 = [$($a1 -join ', ')]"
    Write-Host "  a2 = [$($a2 -join ', ')]"
    $result = Get-LongestSpan -a1 $a1 -a2 $a2
    Write-Host "  Longest span with equal sum: $result" -ForegroundColor Green
    Write-Host "  Expected: 0"

    # Example 4 - Identical arrays
    $a1 = @(1, 0, 1, 1, 0)
    $a2 = @(1, 0, 1, 1, 0)
    Write-Host "`nExample 4 (identical arrays):" -ForegroundColor Yellow
    Write-Host "  a1 = [$($a1 -join ', ')]"
    Write-Host "  a2 = [$($a2 -join ', ')]"
    $result = Get-LongestSpan -a1 $a1 -a2 $a2
    Write-Host "  Longest span with equal sum: $result" -ForegroundColor Green
    Write-Host "  Expected: 5 (entire array)"

    Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
}
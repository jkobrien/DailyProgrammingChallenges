<#
Minimize the Heights II - PowerShell implementation
Problem (paraphrased):
Given an array of non-negative integers representing heights and an integer K,
you may either increase or decrease each height by K (once). After modification,
heights must remain non-negative. Return the minimum possible difference between
the maximum and minimum heights.

This implements the standard greedy approach:
1. Sort the array.
2. Initialize answer as the difference between max and min of the sorted array.
3. For each i from 1 to n-1, consider splitting the array at i — make first i elements +K
   and last n-i elements -K (or vice versa) and compute new potential max/min.
4. Track the minimum difference encountered (ensuring heights remain >= 0 by clamping)

Time complexity: O(n log n) due to sorting.
#>

function Minimize-HeightsII {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [int[]]$Heights,
        [Parameter(Mandatory=$true, Position=1)]
        [int]$K
    )

    if ($null -eq $Heights -or $Heights.Count -le 1) {
        return 0
    }

    $arr = $Heights | Sort-Object
    $n = $arr.Count

    # Initial answer: original range
    $ans = $arr[$n - 1] - $arr[0]

    for ($i = 1; $i -lt $n; $i++) {
        # Candidate maximum: either the previous element increased by K,
        # or the original maximum decreased by K
        $maxh = [Math]::Max(($arr[$i - 1] + $K), ($arr[$n - 1] - $K))

        # Candidate minimum: either the original minimum increased by K,
        # or current element decreased by K. Clamp at 0 to avoid negatives.
        $candidateLow = $arr[$i] - $K
        if ($candidateLow -lt 0) { $candidateLow = 0 }
        $minh = [Math]::Min(($arr[0] + $K), $candidateLow)

        $ans = [Math]::Min($ans, ($maxh - $minh))
    }

    return $ans
}

# If this file is invoked directly, allow a quick example usage.
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "Example: [1, 5, 8, 10], K=2 =>" (Minimize-HeightsII -Heights @(1,5,8,10) -K 2)
}

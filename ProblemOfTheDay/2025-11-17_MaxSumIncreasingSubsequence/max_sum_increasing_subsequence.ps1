<#
.SYNOPSIS
    Max Sum Increasing Subsequence - GeeksforGeeks Problem of the Day (Nov 17, 2025)

.DESCRIPTION
    Given an array of positive integers, find the maximum sum of a subsequence 
    such that the elements form a strictly increasing sequence.

.EXAMPLE
    Get-MaxSumIncreasingSubsequence -arr @(1, 101, 2, 3, 100)
    Returns: 106 (from subsequence [1, 2, 3, 100])

.NOTES
    Time Complexity: O(n^2)
    Space Complexity: O(n)
    
    Company Tags: Morgan Stanley, Amazon, Microsoft
    Topic Tags: Dynamic Programming, Algorithms
#>

function Get-MaxSumIncreasingSubsequence {
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Handle edge cases
    if ($n -eq 0) {
        return 0
    }
    
    if ($n -eq 1) {
        return $arr[0]
    }
    
    # Initialize DP array where dp[i] represents the maximum sum
    # of an increasing subsequence ending at index i
    $dp = @(0) * $n
    
    # Base case: Each element can form a subsequence by itself
    for ($i = 0; $i -lt $n; $i++) {
        $dp[$i] = $arr[$i]
    }
    
    # Fill the DP array
    for ($i = 1; $i -lt $n; $i++) {
        for ($j = 0; $j -lt $i; $j++) {
            # If arr[j] < arr[i], we can extend the subsequence ending at j
            if ($arr[$j] -lt $arr[$i]) {
                $dp[$i] = [Math]::Max($dp[$i], $dp[$j] + $arr[$i])
            }
        }
    }
    
    # Find the maximum sum in dp array
    $maxSum = $dp[0]
    for ($i = 1; $i -lt $n; $i++) {
        if ($dp[$i] -gt $maxSum) {
            $maxSum = $dp[$i]
        }
    }
    
    return $maxSum
}

function Get-MaxSumIncreasingSubsequenceWithPath {
    <#
    .SYNOPSIS
        Returns both the maximum sum and the actual subsequence
    
    .DESCRIPTION
        Extended version that tracks the actual subsequence path
    #>
    param (
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    if ($n -eq 0) {
        return @{Sum = 0; Subsequence = @()}
    }
    
    if ($n -eq 1) {
        return @{Sum = $arr[0]; Subsequence = @($arr[0])}
    }
    
    # Initialize DP array and parent tracking
    $dp = @(0) * $n
    $parent = @(-1) * $n
    
    for ($i = 0; $i -lt $n; $i++) {
        $dp[$i] = $arr[$i]
    }
    
    # Fill DP array and track parents
    for ($i = 1; $i -lt $n; $i++) {
        for ($j = 0; $j -lt $i; $j++) {
            if ($arr[$j] -lt $arr[$i]) {
                if ($dp[$j] + $arr[$i] -gt $dp[$i]) {
                    $dp[$i] = $dp[$j] + $arr[$i]
                    $parent[$i] = $j
                }
            }
        }
    }
    
    # Find index with maximum sum
    $maxSum = $dp[0]
    $maxIndex = 0
    for ($i = 1; $i -lt $n; $i++) {
        if ($dp[$i] -gt $maxSum) {
            $maxSum = $dp[$i]
            $maxIndex = $i
        }
    }
    
    # Reconstruct the subsequence
    $subsequence = [System.Collections.ArrayList]@()
    $current = $maxIndex
    
    while ($current -ne -1) {
        $subsequence.Insert(0, $arr[$current])
        $current = $parent[$current]
    }
    
    return @{
        Sum = $maxSum
        Subsequence = $subsequence.ToArray()
    }
}

# Main execution for direct script run
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Max Sum Increasing Subsequence ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test Case 1
    Write-Host "Test Case 1:" -ForegroundColor Yellow
    $test1 = @(1, 101, 2, 3, 100)
    Write-Host "Input: $($test1 -join ', ')"
    $result1 = Get-MaxSumIncreasingSubsequence -arr $test1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 106"
    Write-Host ""
    
    # Test Case 2
    Write-Host "Test Case 2:" -ForegroundColor Yellow
    $test2 = @(4, 1, 2, 3)
    Write-Host "Input: $($test2 -join ', ')"
    $result2 = Get-MaxSumIncreasingSubsequence -arr $test2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 6"
    Write-Host ""
    
    # Test Case 3
    Write-Host "Test Case 3:" -ForegroundColor Yellow
    $test3 = @(4, 1, 2, 4)
    Write-Host "Input: $($test3 -join ', ')"
    $result3 = Get-MaxSumIncreasingSubsequence -arr $test3
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: 7"
    Write-Host ""
    
    # Test Case 4 - With Path
    Write-Host "Test Case 4 (with subsequence path):" -ForegroundColor Yellow
    $test4 = @(1, 101, 2, 3, 100)
    Write-Host "Input: $($test4 -join ', ')"
    $result4 = Get-MaxSumIncreasingSubsequenceWithPath -arr $test4
    Write-Host "Maximum Sum: $($result4.Sum)" -ForegroundColor Green
    Write-Host "Subsequence: $($result4.Subsequence -join ', ')" -ForegroundColor Green
    Write-Host ""
}

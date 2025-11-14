<#
.SYNOPSIS
    Minimum Cost to Merge Stones - GeeksforGeeks Problem of the Day (Nov 14, 2025)

.DESCRIPTION
    Given an array of stone piles, find the minimum cost to merge all piles into one.
    In each move, you can merge exactly k consecutive piles, and the cost equals
    the total stones in those k piles.
    
    This solution uses 3D dynamic programming:
    - dp[i][j][p] = minimum cost to merge stones from index i to j into p piles
    - Time Complexity: O(n^3)
    - Space Complexity: O(n^2 * k)

.PARAMETER stones
    Array of integers representing the number of stones in each pile

.PARAMETER k
    Number of consecutive piles that can be merged in one move

.EXAMPLE
    Get-MinimumCostToMergeStones -stones @(1, 2, 3) -k 2
    Returns: 9

.EXAMPLE
    Get-MinimumCostToMergeStones -stones @(1, 5, 3, 2, 4) -k 2
    Returns: 35

.EXAMPLE
    Get-MinimumCostToMergeStones -stones @(1, 5, 3, 2, 4) -k 4
    Returns: -1 (impossible to merge)
#>

function Get-MinimumCostToMergeStones {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int[]]$stones,
        
        [Parameter(Mandatory = $true)]
        [int]$k
    )
    
    $n = $stones.Length
    
    # Check if it's possible to merge all piles into one
    # Each merge reduces piles by (k-1), so we need (n-1) reductions
    # This is only possible if (n-1) is divisible by (k-1)
    if (($n - 1) % ($k - 1) -ne 0) {
        return -1
    }
    
    # Create prefix sum array for efficient range sum queries
    # prefixSum[i] = sum of stones[0..i-1]
    $prefixSum = New-Object int[] ($n + 1)
    for ($i = 0; $i -lt $n; $i++) {
        $prefixSum[$i + 1] = $prefixSum[$i] + $stones[$i]
    }
    
    # Helper function to get sum of stones from index i to j (inclusive)
    function Get-RangeSum {
        param($i, $j)
        return $prefixSum[$j + 1] - $prefixSum[$i]
    }
    
    # Initialize DP table
    # dp[i][j][p] = minimum cost to merge stones[i..j] into p piles
    # Use large value (infinity) for impossible states
    $INF = [int]::MaxValue / 2
    $dp = New-Object 'int[,,]' $n, $n, ($k + 1)
    
    # Initialize all values to infinity
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = 0; $j -lt $n; $j++) {
            for ($p = 0; $p -le $k; $p++) {
                $dp[$i,$j,$p] = $INF
            }
        }
    }
    
    # Base case: single pile costs 0 (already one pile)
    for ($i = 0; $i -lt $n; $i++) {
        $dp[$i,$i,1] = 0
    }
    
    # Fill DP table for increasing lengths
    for ($len = 2; $len -le $n; $len++) {
        for ($i = 0; $i -le $n - $len; $i++) {
            $j = $i + $len - 1
            
            # Try to form p piles (2 to k)
            for ($p = 2; $p -le $k; $p++) {
                # Split into first pile and remaining (p-1) piles
                for ($m = $i; $m -lt $j; $m += ($k - 1)) {
                    $cost1 = $dp[$i,$m,1]
                    $cost2 = $dp[($m + 1),$j,($p - 1)]
                    
                    if ($cost1 -ne $INF -and $cost2 -ne $INF) {
                        $totalCost = $cost1 + $cost2
                        if ($totalCost -lt $dp[$i,$j,$p]) {
                            $dp[$i,$j,$p] = $totalCost
                        }
                    }
                }
            }
            
            # Merge k piles into 1 pile
            if ($dp[$i,$j,$k] -ne $INF) {
                $rangeSum = Get-RangeSum $i $j
                $dp[$i,$j,1] = $dp[$i,$j,$k] + $rangeSum
            }
        }
    }
    
    $result = $dp[0,($n - 1),1]
    
    # If result is still infinity, it's impossible
    if ($result -eq $INF) {
        return -1
    }
    
    return $result
}

# Main execution block for standalone testing
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Minimum Cost to Merge Stones ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test Case 1
    Write-Host "Test Case 1:" -ForegroundColor Yellow
    $stones1 = @(1, 2, 3)
    $k1 = 2
    $result1 = Get-MinimumCostToMergeStones -stones $stones1 -k $k1
    Write-Host "Input: stones = [$($stones1 -join ', ')], k = $k1"
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 9"
    Write-Host ""
    
    # Test Case 2
    Write-Host "Test Case 2:" -ForegroundColor Yellow
    $stones2 = @(1, 5, 3, 2, 4)
    $k2 = 2
    $result2 = Get-MinimumCostToMergeStones -stones $stones2 -k $k2
    Write-Host "Input: stones = [$($stones2 -join ', ')], k = $k2"
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 35"
    Write-Host ""
    
    # Test Case 3
    Write-Host "Test Case 3:" -ForegroundColor Yellow
    $stones3 = @(1, 5, 3, 2, 4)
    $k3 = 4
    $result3 = Get-MinimumCostToMergeStones -stones $stones3 -k $k3
    Write-Host "Input: stones = [$($stones3 -join ', ')], k = $k3"
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: -1 (impossible)"
    Write-Host ""
    
    # Test Case 4: Edge case with k=3
    Write-Host "Test Case 4:" -ForegroundColor Yellow
    $stones4 = @(3, 2, 4, 1)
    $k4 = 3
    $result4 = Get-MinimumCostToMergeStones -stones $stones4 -k $k4
    Write-Host "Input: stones = [$($stones4 -join ', ')], k = $k4"
    Write-Host "Output: $result4" -ForegroundColor Green
    Write-Host "Expected: 20"
    Write-Host ""
    
    # Test Case 5: Single pile
    Write-Host "Test Case 5:" -ForegroundColor Yellow
    $stones5 = @(5)
    $k5 = 2
    $result5 = Get-MinimumCostToMergeStones -stones $stones5 -k $k5
    Write-Host "Input: stones = [$($stones5 -join ', ')], k = $k5"
    Write-Host "Output: $result5" -ForegroundColor Green
    Write-Host "Expected: 0 (already one pile)"
    Write-Host ""
}

# Export the function for module usage (only when imported as module)
if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript') {
    # Not in a module, don't export
} else {
    Export-ModuleMember -Function Get-MinimumCostToMergeStones
}

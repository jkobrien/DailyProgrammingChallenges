<#
.SYNOPSIS
    Find the minimum number of perfect squares that sum to n.

.DESCRIPTION
    Given a positive integer n, this function finds the minimum number of 
    perfect squares (squares of integers) that sum up to n using dynamic programming.
    
    This is a classic DP problem where we build up solutions for smaller numbers
    to solve larger ones. For each number, we try all possible perfect squares
    less than or equal to it and find the minimum.

.PARAMETER n
    A positive integer (1 ≤ n ≤ 10^4)

.EXAMPLE
    Get-MinimumSquares -n 100
    Returns: 1 (because 10² = 100)

.EXAMPLE
    Get-MinimumSquares -n 6
    Returns: 3 (because 1² + 1² + 2² = 6)

.NOTES
    Time Complexity: O(n * √n)
    Space Complexity: O(n)
    
    Algorithm:
    1. Check if n is a perfect square (return 1 if yes)
    2. Create DP array where dp[i] = minimum squares needed for sum i
    3. For each number i from 1 to n:
       - Try all perfect squares j² ≤ i
       - dp[i] = min(dp[i], dp[i - j²] + 1)
    4. Return dp[n]
#>

function Get-MinimumSquares {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 10000)]
        [int]$n
    )
    
    # Edge case: if n is 0
    if ($n -eq 0) {
        return 0
    }
    
    # Optimization: Check if n is already a perfect square
    $sqrt = [Math]::Floor([Math]::Sqrt($n))
    if ($sqrt * $sqrt -eq $n) {
        return 1
    }
    
    # Initialize DP array
    # dp[i] represents minimum number of perfect squares that sum to i
    $dp = New-Object int[] ($n + 1)
    
    # Base case
    $dp[0] = 0
    
    # Fill DP array for all numbers from 1 to n
    for ($i = 1; $i -le $n; $i++) {
        # Initialize with worst case (all 1s)
        $dp[$i] = $i
        
        # Try all perfect squares less than or equal to i
        for ($j = 1; $j * $j -le $i; $j++) {
            $square = $j * $j
            # Update minimum: current value OR (squares needed for (i - square) + 1)
            $dp[$i] = [Math]::Min($dp[$i], $dp[$i - $square] + 1)
        }
    }
    
    return $dp[$n]
}

# Alternative recursive approach with memoization (commented out - DP is more efficient)
<#
function Get-MinimumSquaresRecursive {
    param(
        [int]$n,
        [hashtable]$memo = @{}
    )
    
    if ($n -eq 0) { return 0 }
    if ($memo.ContainsKey($n)) { return $memo[$n] }
    
    $sqrt = [Math]::Floor([Math]::Sqrt($n))
    if ($sqrt * $sqrt -eq $n) {
        $memo[$n] = 1
        return 1
    }
    
    $minSquares = $n  # worst case: all 1s
    
    for ($i = 1; $i * $i -le $n; $i++) {
        $square = $i * $i
        $result = 1 + (Get-MinimumSquaresRecursive -n ($n - $square) -memo $memo)
        $minSquares = [Math]::Min($minSquares, $result)
    }
    
    $memo[$n] = $minSquares
    return $minSquares
}
#>

# Helper function to show the actual squares that sum to n (for debugging/visualization)
function Get-MinimumSquaresWithDetails {
    param(
        [Parameter(Mandatory=$true)]
        [int]$n
    )
    
    $result = Get-MinimumSquares -n $n
    
    # Reconstruct the actual squares used
    $squares = @()
    $remaining = $n
    
    while ($remaining -gt 0) {
        # Find the largest perfect square <= remaining
        $sqrt = [Math]::Floor([Math]::Sqrt($remaining))
        $square = $sqrt * $sqrt
        $squares += $square
        $remaining -= $square
    }
    
    return @{
        Count = $result
        Squares = $squares
        Sum = ($squares | Measure-Object -Sum).Sum
        Expression = ($squares | ForEach-Object { 
            $root = [Math]::Sqrt($_)
            "$root²"
        }) -join " + "
    }
}

# Main execution block for direct script execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Get Minimum Squares ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test cases
    $testCases = @(
        @{ n = 100; expected = 1 }
        @{ n = 6; expected = 3 }
        @{ n = 12; expected = 3 }
        @{ n = 13; expected = 2 }
        @{ n = 1; expected = 1 }
        @{ n = 4; expected = 1 }
        @{ n = 7; expected = 4 }
        @{ n = 10; expected = 2 }
    )
    
    $passed = 0
    $failed = 0
    
    foreach ($test in $testCases) {
        $result = Get-MinimumSquares -n $test.n
        $details = Get-MinimumSquaresWithDetails -n $test.n
        
        if ($result -eq $test.expected) { 
            $passed++
            $status = "PASS"
            $color = "Green"
        } else { 
            $failed++
            $status = "FAIL"
            $color = "Red"
        }
        
        Write-Host "Test: n = $($test.n)" -ForegroundColor White
        Write-Host "  Expected: $($test.expected)" -ForegroundColor Gray
        Write-Host "  Got:      $result" -ForegroundColor Gray
        Write-Host "  Squares:  $($details.Expression) = $($details.Sum)" -ForegroundColor Gray
        Write-Host "  $status" -ForegroundColor $color
        Write-Host ""
    }
    
    Write-Host "Results: $passed passed, $failed failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Yellow" })
}

# Export function for module usage (only if loaded as module)
if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript') {
    # Running as script - no export needed
} else {
    Export-ModuleMember -Function Get-MinimumSquares, Get-MinimumSquaresWithDetails
}

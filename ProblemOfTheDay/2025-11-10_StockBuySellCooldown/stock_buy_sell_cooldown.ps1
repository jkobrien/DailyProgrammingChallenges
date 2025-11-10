<#
.SYNOPSIS
    Stock Buy and Sell with Cooldown - GeeksforGeeks Problem of the Day (Nov 10, 2025)

.DESCRIPTION
    Find the maximum profit from buying and selling stocks with a cooldown period.
    After selling a stock, you cannot buy on the next day (one-day cooldown).
    
    This solution uses dynamic programming with three states:
    - hold: Maximum profit while holding a stock
    - sell: Maximum profit after selling a stock
    - cooldown: Maximum profit during cooldown or ready to buy
    
    Time Complexity: O(n)
    Space Complexity: O(1)

.PARAMETER prices
    Array of stock prices where prices[i] is the price on day i

.EXAMPLE
    Get-MaxProfitWithCooldown -prices @(0, 2, 1, 2, 3)
    Returns: 3

.EXAMPLE
    Get-MaxProfitWithCooldown -prices @(3, 1, 6, 1, 2, 4)
    Returns: 7
#>

function Get-MaxProfitWithCooldown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$prices
    )
    
    # Handle edge cases
    if ($prices.Length -eq 0) {
        return 0
    }
    
    if ($prices.Length -eq 1) {
        return 0
    }
    
    # Initialize states
    # hold: max profit if we're holding a stock
    # sell: max profit if we just sold a stock
    # cooldown: max profit if we're in cooldown or ready to buy
    
    $hold = -$prices[0]  # Buy on first day
    $sell = 0            # Can't sell on first day
    $cooldown = 0        # No profit on first day if we don't buy
    
    # Iterate through each day starting from day 1
    for ($i = 1; $i -lt $prices.Length; $i++) {
        $currentPrice = $prices[$i]
        
        # Store previous values before updating
        $prevHold = $hold
        $prevSell = $sell
        $prevCooldown = $cooldown
        
        # Update states
        # hold: Either we already held from previous day, or we buy today after cooldown
        $hold = [Math]::Max($prevHold, $prevCooldown - $currentPrice)
        
        # sell: We must have been holding, and we sell today
        $sell = $prevHold + $currentPrice
        
        # cooldown: Either we continue not holding, or we're in cooldown from a previous sell
        $cooldown = [Math]::Max($prevCooldown, $prevSell)
    }
    
    # Maximum profit is either from selling or being in cooldown
    # (we can't end in hold state for maximum profit)
    return [Math]::Max($sell, $cooldown)
}

# Alternative implementation with detailed state tracking for debugging
function Get-MaxProfitWithCooldownDetailed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$prices,
        
        [Parameter(Mandatory = $false)]
        [switch]$ShowStates
    )
    
    if ($prices.Length -eq 0) { return 0 }
    if ($prices.Length -eq 1) { return 0 }
    
    $n = $prices.Length
    $hold = @(-$prices[0])
    $sell = @(0)
    $cooldown = @(0)
    
    for ($i = 1; $i -lt $n; $i++) {
        $hold += [Math]::Max($hold[$i-1], $cooldown[$i-1] - $prices[$i])
        $sell += $hold[$i-1] + $prices[$i]
        $cooldown += [Math]::Max($cooldown[$i-1], $sell[$i-1])
    }
    
    if ($ShowStates) {
        Write-Host "`nState Transitions:"
        Write-Host "Day`tPrice`tHold`tSell`tCooldown"
        Write-Host "---`t-----`t----`t----`t--------"
        for ($i = 0; $i -lt $n; $i++) {
            Write-Host "$i`t$($prices[$i])`t$($hold[$i])`t$($sell[$i])`t$($cooldown[$i])"
        }
        Write-Host ""
    }
    
    return [Math]::Max($sell[$n-1], $cooldown[$n-1])
}

# Export functions
Export-ModuleMember -Function Get-MaxProfitWithCooldown, Get-MaxProfitWithCooldownDetailed

# If running as a script (not imported as module), run examples
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Stock Buy and Sell with Cooldown ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $prices1 = @(0, 2, 1, 2, 3)
    Write-Host "Input: prices = [$($prices1 -join ', ')]"
    $result1 = Get-MaxProfitWithCooldown -prices $prices1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 3"
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $prices2 = @(3, 1, 6, 1, 2, 4)
    Write-Host "Input: prices = [$($prices2 -join ', ')]"
    $result2 = Get-MaxProfitWithCooldown -prices $prices2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 7"
    Write-Host ""
    
    # Example 3 - Single price
    Write-Host "Example 3 (Edge Case - Single Day):" -ForegroundColor Yellow
    $prices3 = @(5)
    Write-Host "Input: prices = [$($prices3 -join ', ')]"
    $result3 = Get-MaxProfitWithCooldown -prices $prices3
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: 0"
    Write-Host ""
    
    # Example 4 - Decreasing prices
    Write-Host "Example 4 (Decreasing Prices):" -ForegroundColor Yellow
    $prices4 = @(5, 4, 3, 2, 1)
    Write-Host "Input: prices = [$($prices4 -join ', ')]"
    $result4 = Get-MaxProfitWithCooldown -prices $prices4
    Write-Host "Output: $result4" -ForegroundColor Green
    Write-Host "Expected: 0 (no profit possible)"
    Write-Host ""
    
    # Detailed example with state tracking
    Write-Host "Detailed State Tracking for Example 1:" -ForegroundColor Yellow
    $detailedResult = Get-MaxProfitWithCooldownDetailed -prices $prices1 -ShowStates
    Write-Host "Final Result: $detailedResult" -ForegroundColor Green
}

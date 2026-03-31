<#
.SYNOPSIS
    Buy Stock with Transaction Fee - GeeksforGeeks Problem of the Day (March 31, 2026)

.DESCRIPTION
    Find the maximum profit from buying and selling stocks with a transaction fee.
    You can complete as many transactions as you like, but must pay a fee for each.
    
    This solution uses dynamic programming with two states:
    - hold: Maximum profit while holding a stock
    - cash: Maximum profit without holding a stock
    
    Time Complexity: O(n)
    Space Complexity: O(1)

.PARAMETER prices
    Array of stock prices where prices[i] is the price on day i

.PARAMETER fee
    Transaction fee to pay for each complete buy-sell transaction

.EXAMPLE
    Get-MaxProfitWithFee -prices @(1, 3, 2, 8, 4, 9) -fee 2
    Returns: 8

.EXAMPLE
    Get-MaxProfitWithFee -prices @(1, 3, 7, 5, 10, 3) -fee 3
    Returns: 6
#>

function Get-MaxProfitWithFee {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$prices,
        
        [Parameter(Mandatory = $true)]
        [int]$fee
    )
    
    # Handle edge cases
    if ($prices.Length -eq 0) {
        return 0
    }
    
    if ($prices.Length -eq 1) {
        return 0
    }
    
    # Initialize states
    # cash: max profit when we don't hold a stock (can buy)
    # hold: max profit when we're holding a stock (can sell)
    
    $cash = 0                # No profit initially without any stock
    $hold = -$prices[0]      # If we buy on first day, profit is negative
    
    # Iterate through each day starting from day 1
    for ($i = 1; $i -lt $prices.Length; $i++) {
        $currentPrice = $prices[$i]
        
        # Store previous cash value before updating
        $prevCash = $cash
        
        # Update states
        # cash: Either we already had cash, or we sell today (get price minus fee)
        $cash = [Math]::Max($cash, $hold + $currentPrice - $fee)
        
        # hold: Either we already held, or we buy today (spend from cash)
        $hold = [Math]::Max($hold, $prevCash - $currentPrice)
    }
    
    # Maximum profit is when we're not holding any stock
    return $cash
}

# Alternative implementation with detailed state tracking for debugging
function Get-MaxProfitWithFeeDetailed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$prices,
        
        [Parameter(Mandatory = $true)]
        [int]$fee,
        
        [Parameter(Mandatory = $false)]
        [switch]$ShowStates
    )
    
    if ($prices.Length -eq 0) { return 0 }
    if ($prices.Length -eq 1) { return 0 }
    
    $n = $prices.Length
    $cash = @(0)
    $hold = @(-$prices[0])
    
    for ($i = 1; $i -lt $n; $i++) {
        $newCash = [Math]::Max($cash[$i-1], $hold[$i-1] + $prices[$i] - $fee)
        $newHold = [Math]::Max($hold[$i-1], $cash[$i-1] - $prices[$i])
        $cash += $newCash
        $hold += $newHold
    }
    
    if ($ShowStates) {
        Write-Host "`nState Transitions (Fee = $fee):"
        Write-Host "Day`tPrice`tCash`tHold"
        Write-Host "---`t-----`t----`t----"
        for ($i = 0; $i -lt $n; $i++) {
            Write-Host "$i`t$($prices[$i])`t$($cash[$i])`t$($hold[$i])"
        }
        Write-Host ""
    }
    
    return $cash[$n-1]
}

# Function to explain the optimal trading strategy
function Show-TradingStrategy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int[]]$prices,
        
        [Parameter(Mandatory = $true)]
        [int]$fee
    )
    
    if ($prices.Length -le 1) {
        Write-Host "No trading possible with fewer than 2 days of prices."
        return
    }
    
    $n = $prices.Length
    $cash = @(0)
    $hold = @(-$prices[0])
    $actions = @("Start (can buy)")
    
    for ($i = 1; $i -lt $n; $i++) {
        $sellProfit = $hold[$i-1] + $prices[$i] - $fee
        $buyProfit = $cash[$i-1] - $prices[$i]
        
        $newCash = [Math]::Max($cash[$i-1], $sellProfit)
        $newHold = [Math]::Max($hold[$i-1], $buyProfit)
        
        $action = ""
        if ($newCash -gt $cash[$i-1] -and $newCash -eq $sellProfit) {
            $action = "SELL at $($prices[$i]) (profit after fee: $($prices[$i] - $fee))"
        } elseif ($newHold -gt $hold[$i-1] -and $newHold -eq $buyProfit) {
            $action = "BUY at $($prices[$i])"
        } else {
            $action = "Hold"
        }
        
        $cash += $newCash
        $hold += $newHold
        $actions += $action
    }
    
    Write-Host "`nOptimal Trading Strategy (Fee = $fee):" -ForegroundColor Cyan
    Write-Host "Day`tPrice`tAction`t`t`t`tCash`tHold"
    Write-Host "---`t-----`t------`t`t`t`t----`t----"
    for ($i = 0; $i -lt $n; $i++) {
        Write-Host "$i`t$($prices[$i])`t$($actions[$i])`t$($cash[$i])`t$($hold[$i])"
    }
    Write-Host "`nTotal Profit: $($cash[$n-1])" -ForegroundColor Green
}

# Export functions if running as module
if ($MyInvocation.MyCommand.ScriptBlock.Module) {
    Export-ModuleMember -Function Get-MaxProfitWithFee, Get-MaxProfitWithFeeDetailed, Show-TradingStrategy
}

# If running as a script (not imported as module), run examples
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Buy Stock with Transaction Fee ===" -ForegroundColor Cyan
    Write-Host "GeeksforGeeks Problem of the Day - March 31, 2026"
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $prices1 = @(1, 3, 2, 8, 4, 9)
    $fee1 = 2
    Write-Host "Input: prices = [$($prices1 -join ', ')], fee = $fee1"
    $result1 = Get-MaxProfitWithFee -prices $prices1 -fee $fee1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 8"
    Write-Host "Explanation: Buy at 1, sell at 8 (profit: 8-1-2=5), Buy at 4, sell at 9 (profit: 9-4-2=3)"
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $prices2 = @(1, 3, 7, 5, 10, 3)
    $fee2 = 3
    Write-Host "Input: prices = [$($prices2 -join ', ')], fee = $fee2"
    $result2 = Get-MaxProfitWithFee -prices $prices2 -fee $fee2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 6"
    Write-Host "Explanation: Buy at 1, sell at 10 (profit: 10-1-3=6)"
    Write-Host ""
    
    # Example 3 - Decreasing prices
    Write-Host "Example 3 (Decreasing Prices):" -ForegroundColor Yellow
    $prices3 = @(5, 4, 3, 2, 1)
    $fee3 = 1
    Write-Host "Input: prices = [$($prices3 -join ', ')], fee = $fee3"
    $result3 = Get-MaxProfitWithFee -prices $prices3 -fee $fee3
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: 0 (no profit possible)"
    Write-Host ""
    
    # Example 4 - Single price
    Write-Host "Example 4 (Edge Case - Single Day):" -ForegroundColor Yellow
    $prices4 = @(5)
    $fee4 = 1
    Write-Host "Input: prices = [$($prices4 -join ', ')], fee = $fee4"
    $result4 = Get-MaxProfitWithFee -prices $prices4 -fee $fee4
    Write-Host "Output: $result4" -ForegroundColor Green
    Write-Host "Expected: 0"
    Write-Host ""
    
    # Example 5 - Zero fee
    Write-Host "Example 5 (Zero Fee):" -ForegroundColor Yellow
    $prices5 = @(1, 3, 2, 8, 4, 9)
    $fee5 = 0
    Write-Host "Input: prices = [$($prices5 -join ', ')], fee = $fee5"
    $result5 = Get-MaxProfitWithFee -prices $prices5 -fee $fee5
    Write-Host "Output: $result5" -ForegroundColor Green
    Write-Host "Expected: 13 (buy every dip, sell every peak: 3-1 + 8-2 + 9-4 = 2+6+5 = 13)"
    Write-Host ""
    
    # Detailed state tracking
    Write-Host "Detailed State Tracking for Example 1:" -ForegroundColor Yellow
    $detailedResult = Get-MaxProfitWithFeeDetailed -prices $prices1 -fee $fee1 -ShowStates
    Write-Host "Final Result: $detailedResult" -ForegroundColor Green
    Write-Host ""
    
    # Trading strategy visualization
    Show-TradingStrategy -prices $prices1 -fee $fee1
}
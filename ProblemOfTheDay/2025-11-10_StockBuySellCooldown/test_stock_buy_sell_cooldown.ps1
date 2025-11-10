<#
.SYNOPSIS
    Test script for Stock Buy and Sell with Cooldown solution

.DESCRIPTION
    Comprehensive test suite for the stock trading with cooldown problem.
    Tests include basic examples, edge cases, and performance validation.
#>

# Import the solution
. "$PSScriptRoot\stock_buy_sell_cooldown.ps1"

# Test result tracking
$script:passedTests = 0
$script:failedTests = 0
$script:totalTests = 0

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Prices,
        [int]$Expected,
        [string]$Description = ""
    )
    
    $script:totalTests++
    
    Write-Host "`nTest $($script:totalTests): $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "  Description: $Description" -ForegroundColor Gray
    }
    Write-Host "  Input: [$($Prices -join ', ')]"
    Write-Host "  Expected: $Expected"
    
    try {
        $result = Get-MaxProfitWithCooldown -prices $Prices
        if ($result -eq $Expected) {
            Write-Host "  Got: $result" -ForegroundColor Green
            Write-Host "  PASSED" -ForegroundColor Green
            $script:passedTests++
            return $true
        } else {
            Write-Host "  Got: $result" -ForegroundColor Red
            Write-Host "  FAILED" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
    }
    catch {
        Write-Host "  FAILED with error: $_" -ForegroundColor Red
        $script:failedTests++
        return $false
    }
}

Write-Host "=====================================" -ForegroundColor Magenta
Write-Host "Stock Buy and Sell with Cooldown Tests" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta

# Test 1: Example from problem statement
Test-Case -TestName "Example 1" -Prices @(0, 2, 1, 2, 3) -Expected 3 -Description "Buy day 1, sell day 2, cooldown day 3, buy day 4, sell day 5"

# Test 2: Second example from problem statement
Test-Case -TestName "Example 2" -Prices @(3, 1, 6, 1, 2, 4) -Expected 7 -Description "Buy day 2, sell day 3, cooldown day 4, buy day 5, sell day 6"

# Test 3: Single day (edge case)
Test-Case -TestName "Single Day" -Prices @(5) -Expected 0 -Description "Cannot trade with only one day"

# Test 4: Two days - profit possible
Test-Case -TestName "Two Days - Profit" -Prices @(1, 5) -Expected 4 -Description "Buy day 1, sell day 2"

# Test 5: Two days - no profit
Test-Case -TestName "Two Days - No Profit" -Prices @(5, 1) -Expected 0 -Description "Price decreases, no transaction"

# Test 6: All decreasing prices
Test-Case -TestName "Decreasing Prices" -Prices @(5, 4, 3, 2, 1) -Expected 0 -Description "No profit possible with continuously decreasing prices"

# Test 7: All same prices
Test-Case -TestName "Same Prices" -Prices @(3, 3, 3, 3, 3) -Expected 0 -Description "No profit when all prices are equal"

# Test 8: All increasing prices
Test-Case -TestName "Increasing Prices" -Prices @(1, 2, 3, 4, 5) -Expected 4 -Description "Best to buy at start and sell at end"

# Test 9: Multiple peaks and valleys
Test-Case -TestName "Multiple Peaks" -Prices @(1, 4, 2, 7, 1, 3) -Expected 6 -Description "Multiple buy-sell cycles"

# Test 10: V-shape pattern
Test-Case -TestName "V-Shape" -Prices @(5, 1, 5) -Expected 4 -Description "Buy at lowest, sell at peak"

# Test 11: W-shape pattern
Test-Case -TestName "W-Shape" -Prices @(5, 1, 5, 1, 5) -Expected 4 -Description "Buy-sell-cooldown-buy-sell pattern"

# Test 12: Long cooldown benefit
Test-Case -TestName "Long Cooldown Benefit" -Prices @(1, 2, 3, 0, 2) -Expected 3 -Description "Sometimes waiting for better price is optimal"

# Test 13: Immediate cooldown test
Test-Case -TestName "Immediate Cooldown" -Prices @(1, 4, 2) -Expected 3 -Description "Sell and cooldown immediately"

# Test 14: Large array with pattern
Test-Case -TestName "Large Array Pattern" -Prices @(1, 3, 2, 8, 4, 9) -Expected 8 -Description "Complex trading pattern"

# Test 15: Zero prices (edge case)
Test-Case -TestName "Zero Prices" -Prices @(0, 0, 0) -Expected 0 -Description "All prices zero"

# Test 16: Starting with zero
Test-Case -TestName "Starting Zero" -Prices @(0, 1, 2, 3) -Expected 3 -Description "Buy at 0, sell at 3"

# Test 17: Large numbers
Test-Case -TestName "Large Numbers" -Prices @(1000, 5000, 3000, 8000) -Expected 7000 -Description "Testing with large price values"

# Test 18: Three days optimal
Test-Case -TestName "Three Days" -Prices @(1, 5, 3) -Expected 4 -Description "Buy day 1, sell day 2"

# Test 19: Four days with cooldown
Test-Case -TestName "Four Days Cooldown" -Prices @(1, 2, 3, 0) -Expected 2 -Description "Buy at 1, sell at 3"

# Test 20: Complex pattern
Test-Case -TestName "Complex Pattern" -Prices @(2, 1, 4, 5, 2, 9, 7) -Expected 10 -Description "Multiple opportunities to trade"

# Performance test with large array
Write-Host ""
Write-Host "Performance Test" -ForegroundColor Cyan
$largeArray = 1..1000 | ForEach-Object { Get-Random -Minimum 1 -Maximum 10000 }
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$result = Get-MaxProfitWithCooldown -prices $largeArray
$stopwatch.Stop()
Write-Host "  Array Size: 1000 elements"
$timeColor = if ($stopwatch.ElapsedMilliseconds -lt 100) { "Green" } else { "Yellow" }
Write-Host "  Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor $timeColor
Write-Host "  Result: $result"

# Summary
Write-Host ""
Write-Host "=====================================" -ForegroundColor Magenta
Write-Host "Test Summary" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta
Write-Host "Total Tests: $script:totalTests"
Write-Host "Passed: $script:passedTests" -ForegroundColor Green
$failColor = if ($script:failedTests -eq 0) { "Green" } else { "Red" }
Write-Host "Failed: $script:failedTests" -ForegroundColor $failColor
$successRate = [math]::Round(($script:passedTests / $script:totalTests) * 100, 2)
Write-Host "Success Rate: $successRate%"

if ($script:failedTests -eq 0) {
    Write-Host ""
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host ""
    Write-Host "Some tests failed!" -ForegroundColor Red
    exit 1
}

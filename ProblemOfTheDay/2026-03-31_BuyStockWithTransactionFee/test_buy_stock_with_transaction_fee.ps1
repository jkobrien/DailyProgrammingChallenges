<#
.SYNOPSIS
    Test script for Buy Stock with Transaction Fee solution

.DESCRIPTION
    Comprehensive test suite for the stock trading with transaction fee problem.
    Tests include basic examples, edge cases, and performance validation.
#>

# Import the solution
. "$PSScriptRoot\buy_stock_with_transaction_fee.ps1"

# Test result tracking
$script:passedTests = 0
$script:failedTests = 0
$script:totalTests = 0

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Prices,
        [int]$Fee,
        [int]$Expected,
        [string]$Description = ""
    )
    
    $script:totalTests++
    
    Write-Host "`nTest $($script:totalTests): $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "  Description: $Description" -ForegroundColor Gray
    }
    Write-Host "  Input: prices=[$($Prices -join ', ')], fee=$Fee"
    Write-Host "  Expected: $Expected"
    
    try {
        $result = Get-MaxProfitWithFee -prices $Prices -fee $Fee
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

Write-Host "=============================================" -ForegroundColor Magenta
Write-Host "Buy Stock with Transaction Fee - Test Suite" -ForegroundColor Magenta
Write-Host "GeeksforGeeks Problem of the Day - March 31, 2026" -ForegroundColor Magenta
Write-Host "=============================================" -ForegroundColor Magenta

# Test 1: Example 1 from problem statement
Test-Case -TestName "Example 1" -Prices @(1, 3, 2, 8, 4, 9) -Fee 2 -Expected 8 -Description "Two transactions: Buy@1,Sell@8 + Buy@4,Sell@9"

# Test 2: Example 2 from problem statement
Test-Case -TestName "Example 2" -Prices @(1, 3, 7, 5, 10, 3) -Fee 3 -Expected 6 -Description "One transaction: Buy@1, Sell@10"

# Test 3: Decreasing prices (no profit)
Test-Case -TestName "Decreasing Prices" -Prices @(5, 4, 3, 2, 1) -Fee 1 -Expected 0 -Description "No profitable transaction possible"

# Test 4: Single day (edge case)
Test-Case -TestName "Single Day" -Prices @(5) -Fee 1 -Expected 0 -Description "Cannot trade with only one day"

# Test 5: Two days - profit exceeds fee
Test-Case -TestName "Two Days - Profit" -Prices @(1, 10) -Fee 2 -Expected 7 -Description "Buy@1, Sell@10, Fee=2, Profit=7"

# Test 6: Two days - profit equals fee
Test-Case -TestName "Two Days - Break Even" -Prices @(1, 4) -Fee 3 -Expected 0 -Description "Profit would be 3, equals fee, so no trade"

# Test 7: Two days - profit less than fee
Test-Case -TestName "Two Days - Fee Too High" -Prices @(1, 3) -Fee 5 -Expected 0 -Description "Profit would be 2, less than fee 5"

# Test 8: Zero fee
Test-Case -TestName "Zero Fee" -Prices @(1, 3, 2, 8, 4, 9) -Fee 0 -Expected 13 -Description "Buy every dip, sell every peak: (3-1)+(8-2)+(9-4)=13"

# Test 9: All same prices
Test-Case -TestName "Same Prices" -Prices @(5, 5, 5, 5, 5) -Fee 1 -Expected 0 -Description "No profit when all prices are equal"

# Test 10: All increasing prices
Test-Case -TestName "Increasing Prices" -Prices @(1, 2, 3, 4, 5) -Fee 1 -Expected 3 -Description "Buy@1, Sell@5, Profit=4-1=3"

# Test 11: V-shape pattern
Test-Case -TestName "V-Shape" -Prices @(5, 1, 5) -Fee 1 -Expected 3 -Description "Buy@1, Sell@5, Fee=1, Profit=3"

# Test 12: High fee discourages trading
Test-Case -TestName "High Fee" -Prices @(1, 4, 2, 8, 3, 9) -Fee 10 -Expected 0 -Description "Fee too high for any profitable trade"

# Test 13: Multiple small profits vs one large
Test-Case -TestName "Multiple vs Single Trade" -Prices @(1, 2, 3, 4, 5, 6) -Fee 1 -Expected 4 -Description "Better to do one trade: 6-1-1=4 vs multiple (1-1)+(1-1)+(1-1)=0"

# Test 14: Large numbers - Two transactions are better: Buy@1000,Sell@5000 (3500) + Buy@3000,Sell@8000 (4500) = 8000
Test-Case -TestName "Large Numbers" -Prices @(1000, 5000, 3000, 8000) -Fee 500 -Expected 8000 -Description "Two trades better: (5000-1000-500)+(8000-3000-500)=8000"

# Test 15: Three days pattern
Test-Case -TestName "Three Days" -Prices @(1, 5, 3) -Fee 1 -Expected 3 -Description "Buy@1, Sell@5, Fee=1, Profit=3"

# Test 16: Four days with dip
Test-Case -TestName "Four Days Dip" -Prices @(1, 4, 2, 8) -Fee 2 -Expected 5 -Description "Buy@1, Sell@8 (skip selling at 4 due to fee)"

# Test 17: Alternating high-low
Test-Case -TestName "Alternating" -Prices @(1, 5, 2, 6, 3, 7) -Fee 2 -Expected 6 -Description "Buy@1, Sell@7 is optimal with fee=2"

# Test 18: Fee equals potential profit
Test-Case -TestName "Fee Equals Profit" -Prices @(1, 6, 3, 8) -Fee 5 -Expected 2 -Description "Buy@1, Sell@8, Fee=5, Profit=2"

# Test 19: Two elements only
Test-Case -TestName "Two Elements" -Prices @(2, 5) -Fee 1 -Expected 2 -Description "Buy@2, Sell@5, Fee=1, Profit=2"

# Test 20: Complex pattern - Buy@1,Sell@5 (3) + Buy@2,Sell@9 (6) = 9
Test-Case -TestName "Complex Pattern" -Prices @(2, 1, 4, 5, 2, 9, 7) -Fee 1 -Expected 9 -Description "Buy@1,Sell@5,Buy@2,Sell@9 = 3+6=9"

# Test 21: Starting high then recovering
Test-Case -TestName "High Start Recovery" -Prices @(10, 2, 3, 4, 5, 15) -Fee 3 -Expected 10 -Description "Buy@2, Sell@15, Fee=3, Profit=10"

# Test 22: Long sequence with small fee - (3-1-1)+(5-2-1)+(7-3-1)+(9-4-1) = 1+2+3+4 = 10
Test-Case -TestName "Long Sequence Small Fee" -Prices @(1, 3, 2, 5, 3, 7, 4, 9) -Fee 1 -Expected 10 -Description "Multiple strategic trades: 1+2+3+4=10"

# Test 23: Exactly two prices, large spread
Test-Case -TestName "Large Spread" -Prices @(1, 100000) -Fee 1 -Expected 99998 -Description "Buy@1, Sell@100000, Fee=1"

# Test 24: Mountain shape
Test-Case -TestName "Mountain Shape" -Prices @(1, 2, 3, 4, 5, 4, 3, 2, 1) -Fee 1 -Expected 3 -Description "Buy@1, Sell@5, Fee=1"

# Test 25: Valley shape
Test-Case -TestName "Valley Shape" -Prices @(5, 4, 3, 2, 1, 2, 3, 4, 5) -Fee 1 -Expected 3 -Description "Buy@1, Sell@5, Fee=1"

# Performance test with large array
Write-Host ""
Write-Host "Performance Test" -ForegroundColor Cyan
$largeArray = 1..10000 | ForEach-Object { Get-Random -Minimum 1 -Maximum 10000 }
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$result = Get-MaxProfitWithFee -prices $largeArray -fee 100
$stopwatch.Stop()
Write-Host "  Array Size: 10000 elements"
$timeColor = if ($stopwatch.ElapsedMilliseconds -lt 500) { "Green" } else { "Yellow" }
Write-Host "  Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor $timeColor
Write-Host "  Result: $result"
Write-Host "  Status: " -NoNewline
if ($stopwatch.ElapsedMilliseconds -lt 1000) {
    Write-Host "PERFORMANT" -ForegroundColor Green
} else {
    Write-Host "SLOW" -ForegroundColor Yellow
}

# Stress test
Write-Host ""
Write-Host "Stress Test (100000 elements):" -ForegroundColor Cyan
$stressArray = 1..100000 | ForEach-Object { Get-Random -Minimum 1 -Maximum 100000 }
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$stressResult = Get-MaxProfitWithFee -prices $stressArray -fee 500
$stopwatch.Stop()
Write-Host "  Array Size: 100000 elements"
$stressTimeColor = if ($stopwatch.ElapsedMilliseconds -lt 2000) { "Green" } else { "Yellow" }
Write-Host "  Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor $stressTimeColor
Write-Host "  Result: $stressResult"

# Summary
Write-Host ""
Write-Host "=============================================" -ForegroundColor Magenta
Write-Host "Test Summary" -ForegroundColor Magenta
Write-Host "=============================================" -ForegroundColor Magenta
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
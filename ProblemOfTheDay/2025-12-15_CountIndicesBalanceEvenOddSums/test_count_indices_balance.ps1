<#
.SYNOPSIS
    Test suite for Count Indices to Balance Even and Odd Sums problem.

.DESCRIPTION
    Comprehensive test cases to validate the solution implementation.
#>

# Import the solution (suppress output from main execution block)
$null = . "$PSScriptRoot\count_indices_balance.ps1" 2>&1

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Input,
        [int]$Expected,
        [string]$Description = ""
    )
    
    Write-Host "Running: $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "  Description: $Description" -ForegroundColor Gray
    }
    Write-Host "  Input: [$($Input -join ', ')]" -ForegroundColor Gray
    Write-Host "  Expected: $Expected" -ForegroundColor Gray
    
    try {
        $result = Count-BalancedIndices -arr $Input
        Write-Host "  Got: $result" -ForegroundColor Gray
        
        if ($result -eq $Expected) {
            Write-Host "  [PASS] PASSED" -ForegroundColor Green
            $script:TestsPassed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "PASSED"
                Expected = $Expected
                Got = $result
            }
        } else {
            Write-Host "  [FAIL] FAILED" -ForegroundColor Red
            $script:TestsFailed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "FAILED"
                Expected = $Expected
                Got = $result
            }
        }
    } catch {
        Write-Host "  [ERROR] ERROR: $($_.Exception.Message)" -ForegroundColor Red
        $script:TestsFailed++
        $script:TestResults += [PSCustomObject]@{
            Test = $TestName
            Status = "ERROR"
            Expected = $Expected
            Got = "Exception"
        }
    }
    
    Write-Host ""
}

Write-Host "=======================================" -ForegroundColor Magenta
Write-Host "  Test Suite: Count Balanced Indices  " -ForegroundColor Magenta
Write-Host "=======================================" -ForegroundColor Magenta
Write-Host ""

# Test Case 1: Example from problem
Test-Case -TestName "Example 1" `
    -Input @(2, 1, 6, 4) `
    -Expected 1 `
    -Description "After removing arr[1]=1, [2,6,4] has even sum=6 and odd sum=6"

# Test Case 2: All equal elements
Test-Case -TestName "Example 2" `
    -Input @(1, 1, 1) `
    -Expected 3 `
    -Description "Removing any element balances the array"

# Test Case 3: Single element
Test-Case -TestName "Single Element" `
    -Input @(5) `
    -Expected 1 `
    -Description "Removing the only element leaves empty array"

# Test Case 4: Two elements
Test-Case -TestName "Two Elements" `
    -Input @(3, 7) `
    -Expected 2 `
    -Description "Removing either element leaves one at even index"

# Test Case 5: No valid removals
Test-Case -TestName "No Valid Removals" `
    -Input @(1, 2, 3, 4, 5) `
    -Expected 0 `
    -Description "No removal creates balance"

# Test Case 6: All zeros
Test-Case -TestName "All Zeros" `
    -Input @(0, 0, 0, 0) `
    -Expected 4 `
    -Description "All zeros means any removal balances"

# Test Case 7: Larger array with pattern
Test-Case -TestName "Pattern Array" `
    -Input @(1, 2, 3, 4, 5, 6) `
    -Expected 0 `
    -Description "Even sum=9(1+3+5), Odd sum=12(2+4+6)"

# Test Case 8: Already balanced before removal
Test-Case -TestName "Pre-Balanced Array" `
    -Input @(2, 3, 4, 3) `
    -Expected 0 `
    -Description "Even sum=6(2+4), Odd sum=6(3+3), but removal may unbalance"

# Test Case 9: Multiple valid removals
Test-Case -TestName "Multiple Solutions" `
    -Input @(2, 2, 2, 2, 2) `
    -Expected 5 `
    -Description "All elements equal, any removal works"

# Test Case 10: Edge case with larger numbers
Test-Case -TestName "Large Numbers" `
    -Input @(100, 200, 300, 400) `
    -Expected 0 `
    -Description "Even sum=400, Odd sum=600"

# Test Case 11: Alternating pattern
Test-Case -TestName "Alternating Pattern" `
    -Input @(1, 5, 1, 5, 1, 5) `
    -Expected 0 `
    -Description "Even indices all 1, odd indices all 5"

# Test Case 12: Complex case
Test-Case -TestName "Complex Case 1" `
    -Input @(5, 2, 6, 1, 3) `
    -Expected 1 `
    -Description "Even sum=14(5+6+3), Odd sum=3(2+1)"

# Test Case 13: Four elements balanced
Test-Case -TestName "Four Elements Balanced" `
    -Input @(1, 4, 2, 3) `
    -Expected 2 `
    -Description "Removing index 0 or 3 creates balance"

# Test Case 14: Long array all ones
Test-Case -TestName "Long Array All Ones" `
    -Input @(1, 1, 1, 1, 1, 1, 1, 1) `
    -Expected 8 `
    -Description "All elements same, any removal balances"

# Test Case 15: Mixed values
Test-Case -TestName "Mixed Values" `
    -Input @(10, 5, 10, 5, 10, 5) `
    -Expected 0 `
    -Description "Pattern 10,5,10,5,10,5 - even sum=30, odd sum=15"

# Display Summary
Write-Host "=======================================" -ForegroundColor Magenta
Write-Host "           TEST SUMMARY                " -ForegroundColor Magenta
Write-Host "=======================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Total Tests: $($script:TestsPassed + $script:TestsFailed)" -ForegroundColor White
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($script:TestsFailed -gt 0) {
    Write-Host "Failed Tests:" -ForegroundColor Red
    $script:TestResults | Where-Object { $_.Status -ne "PASSED" } | Format-Table -AutoSize
    exit 1
} else {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
}

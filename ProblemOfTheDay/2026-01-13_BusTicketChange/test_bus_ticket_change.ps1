<#
.SYNOPSIS
    Comprehensive test suite for Bus Ticket Change problem

.DESCRIPTION
    Tests the Get-BusTicketChange function with various test cases

.NOTES
    Run this script to validate the solution
#>

# Dot-source the solution to load the function
. "$PSScriptRoot\bus_ticket_change.ps1"

# Test result tracking
$TestsPassed = 0
$TestsFailed = 0

function Test-BusTicketChange {
    param(
        [string]$TestName,
        [int[]]$Input,
        [bool]$Expected,
        [string]$Description = ""
    )
    
    try {
        $result = Get-BusTicketChange -arr $Input
        $passed = ($result -eq $Expected)
        
        if ($passed) {
            $script:TestsPassed++
            Write-Host "[PASS] $TestName" -ForegroundColor Green
        } else {
            $script:TestsFailed++
            Write-Host "[FAIL] $TestName" -ForegroundColor Red
        }
        
        Write-Host "  Input: [$($Input -join ', ')]" -ForegroundColor Gray
        Write-Host "  Expected: $Expected | Got: $result" -ForegroundColor Gray
        if ($Description) {
            Write-Host "  Description: $Description" -ForegroundColor Gray
        }
        Write-Host ""
    }
    catch {
        $script:TestsFailed++
        Write-Host "[ERROR] $TestName" -ForegroundColor Red
        Write-Host "  Error: $_" -ForegroundColor Red
        Write-Host ""
    }
}

# Run test suite
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Bus Ticket Change - Test Suite" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "CATEGORY: Basic Examples" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "Example 1" -Input @(5, 5, 5, 10, 20) -Expected $true -Description "From problem: Should successfully serve all passengers"
Test-BusTicketChange -TestName "Example 2" -Input @(5, 5, 10, 10, 20) -Expected $false -Description "From problem: Cannot give change for last passenger"

Write-Host "CATEGORY: Edge Cases" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "All Exact Change" -Input @(5, 5, 5, 5, 5) -Expected $true -Description "All customers pay with exact change"
Test-BusTicketChange -TestName "Single Customer with `$5" -Input @(5) -Expected $true -Description "Single customer with exact change"
Test-BusTicketChange -TestName "First Customer with `$10" -Input @(10) -Expected $false -Description "Cannot give change to first customer"
Test-BusTicketChange -TestName "First Customer with `$20" -Input @(20) -Expected $false -Description "Cannot give change to first customer"
Test-BusTicketChange -TestName "Empty Array" -Input @() -Expected $true -Description "No customers to serve"

Write-Host "CATEGORY: Greedy Strategy Tests" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "Prefer `$10+`$5 over 3x`$5" -Input @(5, 5, 5, 10, 20) -Expected $true -Description "Should use `$10+`$5 change for `$20 bill"
Test-BusTicketChange -TestName "Use 3x`$5 when no `$10" -Input @(5, 5, 5, 5, 20) -Expected $true -Description "Should use three `$5 bills when no `$10 available"
Test-BusTicketChange -TestName "Insufficient `$5 bills" -Input @(5, 5, 20) -Expected $false -Description "Only 2 `$5 bills available, need 3 for change"

Write-Host "CATEGORY: Complex Scenarios" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "Long Valid Sequence" -Input @(5, 5, 10, 20, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5, 5, 20, 5, 20, 5) -Expected $true -Description "Long sequence with multiple transaction types"
Test-BusTicketChange -TestName "Multiple `$20 Bills" -Input @(5, 5, 5, 5, 10, 10, 20, 20) -Expected $true -Description "Multiple `$20 bills requiring different change strategies"
Test-BusTicketChange -TestName "Alternating Pattern" -Input @(5, 10, 5, 10, 5, 10) -Expected $true -Description "Alternating `$5 and `$10 bills"
Test-BusTicketChange -TestName "Near Miss Scenario" -Input @(5, 5, 10, 5, 20, 5, 10) -Expected $true -Description "Scenario that nearly runs out of change"

Write-Host "CATEGORY: Boundary Tests" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "All `$10 Bills (Should Fail)" -Input @(10, 10, 10) -Expected $false -Description "Cannot serve any customer without initial `$5 bills"
Test-BusTicketChange -TestName "All `$20 Bills (Should Fail)" -Input @(20, 20, 20) -Expected $false -Description "Cannot serve any customer without initial `$5 bills"
$largeArray = @(5) * 100
Test-BusTicketChange -TestName "Large Array - All `$5" -Input $largeArray -Expected $true -Description "Performance test: 100 customers with exact change"

Write-Host "CATEGORY: Strategic Depletion Tests" -ForegroundColor Yellow
Write-Host "----------------------------------------`n" -ForegroundColor Yellow

Test-BusTicketChange -TestName "Deplete `$5 then fail" -Input @(5, 5, 10, 10, 20) -Expected $false -Description "Gradually depletes `$5 bills until unable to serve"
Test-BusTicketChange -TestName "Optimal Change Distribution" -Input @(5, 5, 5, 10, 5, 20, 5, 10, 20) -Expected $true -Description "Tests optimal distribution of `$5 and `$10 bills"

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$TotalTests = $TestsPassed + $TestsFailed
Write-Host "Total Tests: $TotalTests" -ForegroundColor White
Write-Host "Passed: $TestsPassed" -ForegroundColor Green
Write-Host "Failed: $TestsFailed" -ForegroundColor $(if ($TestsFailed -eq 0) { "Green" } else { "Red" })

if ($TotalTests -gt 0) {
    $passRate = [math]::Round(($TestsPassed / $TotalTests) * 100, 2)
    Write-Host "Pass Rate: $passRate%" -ForegroundColor $(if ($passRate -eq 100) { "Green" } elseif ($passRate -ge 80) { "Yellow" } else { "Red" })
}

Write-Host ""

# Exit with appropriate code
if ($TestsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed. Please review." -ForegroundColor Red
    exit 1
}

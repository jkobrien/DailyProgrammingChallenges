<#
.SYNOPSIS
    Comprehensive test suite for Maximum People Visible in a Line solution
    
.DESCRIPTION
    Tests the solution with various test cases including edge cases,
    boundary conditions, and performance tests.
#>

# Import the solution
$solutionPath = Join-Path $PSScriptRoot "maximum_people_visible_in_line.ps1"
. $solutionPath

# Test state variables
$script:PassedTests = 0
$script:FailedTests = 0
$script:FailedTestDetails = @()

# Test runner function
function RunTest {
    param(
        [string]$testName,
        [int[]]$input,
        [int]$expected,
        [string]$description
    )
    
    Write-Host "`n[TEST] $testName" -ForegroundColor Cyan
    Write-Host "Description: $description" -ForegroundColor Gray
    Write-Host "Input: [$($input -join ', ')]" -ForegroundColor Gray
    
    try {
        $startTime = Get-Date
        $result = Get-MaximumPeopleVisible -arr $input
        $endTime = Get-Date
        $executionTime = ($endTime - $startTime).TotalMilliseconds
        
        if ($result -eq $expected) {
            $script:PassedTests++
            Write-Host "Result: $result (Expected: $expected)" -ForegroundColor Green
            Write-Host "Status: PASSED ✓" -ForegroundColor Green
            Write-Host "Execution Time: $($executionTime.ToString('F2')) ms" -ForegroundColor Gray
        }
        else {
            $script:FailedTests++
            Write-Host "Result: $result (Expected: $expected)" -ForegroundColor Red
            Write-Host "Status: FAILED ✗" -ForegroundColor Red
            $script:FailedTestDetails += @{
                Name = $testName
                Input = $input
                Expected = $expected
                Got = $result
            }
        }
    }
    catch {
        $script:FailedTests++
        Write-Host "Status: ERROR ✗" -ForegroundColor Red
        Write-Host "Error: $_" -ForegroundColor Red
        $script:FailedTestDetails += @{
            Name = $testName
            Input = $input
            Expected = $expected
            Error = $_.Exception.Message
        }
    }
}

function PrintSummary {
    Write-Host "`n======================================================================" -ForegroundColor Cyan
    Write-Host "TEST SUMMARY" -ForegroundColor Cyan
    Write-Host "======================================================================" -ForegroundColor Cyan
    
    $total = $script:PassedTests + $script:FailedTests
    Write-Host "Total Tests: $total" -ForegroundColor White
    Write-Host "Passed: $($script:PassedTests)" -ForegroundColor Green
    Write-Host "Failed: $($script:FailedTests)" -ForegroundColor $(if ($script:FailedTests -eq 0) { "Green" } else { "Red" })
    
    if ($script:FailedTests -gt 0) {
        Write-Host "`nFailed Test Details:" -ForegroundColor Red
        foreach ($failure in $script:FailedTestDetails) {
            Write-Host "  - $($failure.Name)" -ForegroundColor Red
            Write-Host "    Input: [$($failure.Input -join ', ')]" -ForegroundColor Gray
            if ($failure.ContainsKey('Error')) {
                Write-Host "    Error: $($failure.Error)" -ForegroundColor Red
            }
            else {
                Write-Host "    Expected: $($failure.Expected), Got: $($failure.Got)" -ForegroundColor Red
            }
        }
    }
    
    Write-Host "`n======================================================================" -ForegroundColor Cyan
    
    if ($script:FailedTests -eq 0) {
        Write-Host "ALL TESTS PASSED! ✓" -ForegroundColor Green
    }
    else {
        Write-Host "SOME TESTS FAILED!" -ForegroundColor Red
    }
    Write-Host "======================================================================" -ForegroundColor Cyan
}

# Main test execution
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "Maximum People Visible in a Line - Test Suite" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan

# Test Category 1: Basic Examples from Problem Statement
Write-Host "`n### Category 1: Problem Statement Examples ###" -ForegroundColor Yellow

RunTest -testName "Example 1 - Mixed heights" -input @(6, 2, 5, 4, 5, 1, 6) -expected 6 -description "Person at position 0 or 6 can see 6 people total"

RunTest -testName "Example 2 - Small array" -input @(1, 3, 6, 4) -expected 4 -description "Person with height 6 can see all others plus themselves"

# Test Category 2: Edge Cases
Write-Host "`n### Category 2: Edge Cases ###" -ForegroundColor Yellow

RunTest -testName "Single Element" -input @(5) -expected 1 -description "Single person can only see themselves"

RunTest -testName "Two Elements - First Taller" -input @(5, 3) -expected 2 -description "Taller person can see shorter person"

RunTest -testName "Two Elements - Second Taller" -input @(3, 5) -expected 2 -description "Taller person can see shorter person"

RunTest -testName "Two Equal Heights" -input @(5, 5) -expected 1 -description "Equal heights cannot see each other"

# Test Category 3: Special Sequences
Write-Host "`n### Category 3: Special Sequences ###" -ForegroundColor Yellow

RunTest -testName "Strictly Increasing" -input @(1, 2, 3, 4, 5) -expected 5 -description "Last person can see all others"

RunTest -testName "Strictly Decreasing" -input @(5, 4, 3, 2, 1) -expected 5 -description "First person can see all others"

RunTest -testName "All Equal Heights" -input @(3, 3, 3, 3, 3) -expected 1 -description "No one can see anyone else when all equal"

RunTest -testName "Alternating High-Low" -input @(5, 1, 5, 1, 5) -expected 3 -description "Tall people can see neighbors but not across"

# Test Category 4: Peak and Valley Patterns
Write-Host "`n### Category 4: Peak and Valley Patterns ###" -ForegroundColor Yellow

RunTest -testName "Mountain Pattern" -input @(1, 2, 3, 4, 5, 4, 3, 2, 1) -expected 9 -description "Peak can see everyone"

RunTest -testName "Valley Pattern" -input @(5, 4, 3, 2, 1, 2, 3, 4, 5) -expected 5 -description "Edges can see down to valley"

RunTest -testName "Multiple Peaks" -input @(1, 5, 2, 5, 1) -expected 3 -description "Multiple peaks with valleys between"

# Test Category 5: Complex Patterns
Write-Host "`n### Category 5: Complex Patterns ###" -ForegroundColor Yellow

RunTest -testName "Random Heights 1" -input @(10, 5, 8, 3, 6, 2, 9) -expected 5 -description "Complex mixed pattern"

RunTest -testName "Random Heights 2" -input @(7, 3, 8, 5, 2, 9, 4, 6, 1) -expected 6 -description "Another complex pattern"

RunTest -testName "Plateaus" -input @(1, 3, 3, 3, 5, 5, 2) -expected 4 -description "Heights with plateaus (consecutive equal values)"

# Test Category 6: Boundary Conditions
Write-Host "`n### Category 6: Boundary Conditions ###" -ForegroundColor Yellow

RunTest -testName "Large Numbers" -input @(100000, 50000, 75000, 25000, 90000) -expected 5 -description "Testing with maximum constraint values"

RunTest -testName "All Minimum Height" -input @(1, 1, 1, 1, 1) -expected 1 -description "All minimum height values"

RunTest -testName "All Maximum Height" -input @(100000, 100000, 100000) -expected 1 -description "All maximum height values"

# Test Category 7: Larger Arrays
Write-Host "`n### Category 7: Performance Tests (Larger Arrays) ###" -ForegroundColor Yellow

RunTest -testName "Medium Array - 100 elements" -input (1..100) -expected 100 -description "Increasing sequence of 100 elements"

RunTest -testName "Medium Array - Decreasing" -input (100..1) -expected 100 -description "Decreasing sequence of 100 elements"

# Create a larger random-like pattern
$largePattern = @(50, 30, 70, 20, 60, 10, 80, 40, 90, 25, 
                  45, 35, 65, 15, 75, 5, 85, 55, 95, 100,
                  48, 28, 68, 18, 58, 8, 78, 38, 88, 23)

RunTest -testName "Large Mixed Pattern" -input $largePattern -expected 9 -description "30 elements with complex pattern"

# Test Category 8: Special Cases
Write-Host "`n### Category 8: Special Cases ###" -ForegroundColor Yellow

RunTest -testName "Tall Person at Start" -input @(100, 1, 2, 3, 4, 5) -expected 6 -description "Tallest at beginning"

RunTest -testName "Tall Person at End" -input @(1, 2, 3, 4, 5, 100) -expected 6 -description "Tallest at end"

RunTest -testName "Tall Person in Middle" -input @(1, 2, 100, 3, 4) -expected 5 -description "Tallest in middle"

RunTest -testName "Multiple Equal Tall" -input @(1, 10, 2, 10, 3, 10, 4) -expected 3 -description "Multiple people with same tallest height"

# Print final summary
PrintSummary

# Return exit code based on test results
if ($script:FailedTests -eq 0) {
    exit 0
}
else {
    exit 1
}

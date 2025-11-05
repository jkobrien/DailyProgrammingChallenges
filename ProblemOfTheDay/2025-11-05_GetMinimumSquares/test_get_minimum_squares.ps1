<#
.SYNOPSIS
    Comprehensive test suite for Get-MinimumSquares function.

.DESCRIPTION
    Tests the Get-MinimumSquares function with various test cases including:
    - Basic examples from problem statement
    - Edge cases
    - Perfect squares
    - Various numbers requiring different decompositions
    - Boundary values

.NOTES
    Run this script to validate the solution against multiple test scenarios.
#>

# Import the solution
. "$PSScriptRoot\get_minimum_squares.ps1"

function Test-GetMinimumSquares {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "     Get Minimum Squares - Comprehensive Test Suite        " -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""

    $allTests = @(
        # Problem examples
        @{
            Name = "Example 1: Perfect square (100)"
            Input = 100
            Expected = 1
            Explanation = "10^2 = 100"
        }
        @{
            Name = "Example 2: Sum of three squares (6)"
            Input = 6
            Expected = 3
            Explanation = "1^2 + 1^2 + 2^2 = 6"
        }
        
        # Edge cases
        @{
            Name = "Edge: Minimum value (1)"
            Input = 1
            Expected = 1
            Explanation = "1^2 = 1"
        }
        
        # Perfect squares
        @{
            Name = "Perfect square: 4"
            Input = 4
            Expected = 1
            Explanation = "2^2 = 4"
        }
        @{
            Name = "Perfect square: 9"
            Input = 9
            Expected = 1
            Explanation = "3^2 = 9"
        }
        @{
            Name = "Perfect square: 16"
            Input = 16
            Expected = 1
            Explanation = "4^2 = 16"
        }
        @{
            Name = "Perfect square: 25"
            Input = 25
            Expected = 1
            Explanation = "5^2 = 25"
        }
        
        # Two squares
        @{
            Name = "Two squares: 2"
            Input = 2
            Expected = 2
            Explanation = "1^2 + 1^2 = 2"
        }
        @{
            Name = "Two squares: 5"
            Input = 5
            Expected = 2
            Explanation = "2^2 + 1^2 = 5"
        }
        @{
            Name = "Two squares: 8"
            Input = 8
            Expected = 2
            Explanation = "2^2 + 2^2 = 8"
        }
        @{
            Name = "Two squares: 10"
            Input = 10
            Expected = 2
            Explanation = "3^2 + 1^2 = 10"
        }
        @{
            Name = "Two squares: 13"
            Input = 13
            Expected = 2
            Explanation = "3^2 + 2^2 = 13"
        }
        
        # Three squares
        @{
            Name = "Three squares: 3"
            Input = 3
            Expected = 3
            Explanation = "1^2 + 1^2 + 1^2 = 3"
        }
        @{
            Name = "Three squares: 12"
            Input = 12
            Expected = 3
            Explanation = "2^2 + 2^2 + 2^2 = 12"
        }
        @{
            Name = "Three squares: 11"
            Input = 11
            Expected = 3
            Explanation = "3^2 + 1^2 + 1^2 = 11"
        }
        
        # Four squares
        @{
            Name = "Four squares: 7"
            Input = 7
            Expected = 4
            Explanation = "2^2 + 1^2 + 1^2 + 1^2 = 7"
        }
        @{
            Name = "Four squares: 15"
            Input = 15
            Expected = 4
            Explanation = "3^2 + 2^2 + 1^2 + 1^2 = 15"
        }
        
        # Larger values
        @{
            Name = "Larger value: 50"
            Input = 50
            Expected = 2
            Explanation = "7^2 + 1^2 = 50 or 5^2 + 5^2 = 50"
        }
        @{
            Name = "Larger value: 99"
            Input = 99
            Expected = 3
            Explanation = "9^2 + 3^2 + 3^2 = 99"
        }
        @{
            Name = "Larger value: 63"
            Input = 63
            Expected = 4
            Explanation = "7^2 + 3^2 + 2^2 + 1^2 = 63"
        }
        
        # Boundary
        @{
            Name = "Large value: 1000"
            Input = 1000
            Expected = 2
            Explanation = "30^2 + 10^2 = 1000"
        }
    )

    $passed = 0
    $failed = 0
    $failedTests = @()

    foreach ($test in $allTests) {
        Write-Host "Test: $($test.Name)" -ForegroundColor White
        Write-Host "  Input:  n = $($test.Input)" -ForegroundColor Gray
        
        try {
            $result = Get-MinimumSquares -n $test.Input
            $details = Get-MinimumSquaresWithDetails -n $test.Input
            
            Write-Host "  Expected: $($test.Expected)" -ForegroundColor Gray
            Write-Host "  Got:      $result" -ForegroundColor Gray
            Write-Host "  Decomposition: $($details.Expression) = $($details.Sum)" -ForegroundColor Gray
            Write-Host "  Explanation: $($test.Explanation)" -ForegroundColor Gray
            
            if ($result -eq $test.Expected) {
                Write-Host "  PASS" -ForegroundColor Green
                $passed++
            } else {
                Write-Host "  FAIL" -ForegroundColor Red
                $failed++
                $failedTests += $test.Name
            }
        }
        catch {
            Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
            $failed++
            $failedTests += $test.Name
        }
        
        Write-Host ""
    }

    # Summary
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "                      Test Summary                          " -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Total Tests: $($allTests.Count)" -ForegroundColor White
    Write-Host "Passed: $passed" -ForegroundColor Green
    Write-Host "Failed: $failed" -ForegroundColor $(if ($failed -eq 0) { "Green" } else { "Red" })
    
    if ($failed -gt 0) {
        Write-Host ""
        Write-Host "Failed Tests:" -ForegroundColor Red
        foreach ($failedTest in $failedTests) {
            Write-Host "  - $failedTest" -ForegroundColor Red
        }
    } else {
        Write-Host ""
        Write-Host "*** All tests passed! ***" -ForegroundColor Green
    }
    
    Write-Host ""
    
    # Return success/failure
    return $failed -eq 0
}

# Performance test
function Test-Performance {
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "                   Performance Test                         " -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $testValues = @(100, 1000, 5000, 10000)
    
    foreach ($n in $testValues) {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $result = Get-MinimumSquares -n $n
        $stopwatch.Stop()
        
        $timeMs = $stopwatch.ElapsedMilliseconds
        Write-Host "n = $n : Result = $result, Time = $timeMs ms" -ForegroundColor Cyan
    }
    
    Write-Host ""
}

# Run all tests
$success = Test-GetMinimumSquares

# Run performance test
Test-Performance

# Exit with appropriate code
if ($success) {
    exit 0
} else {
    exit 1
}

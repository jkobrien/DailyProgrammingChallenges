<#
.SYNOPSIS
    Comprehensive test suite for Min Add to Make Parentheses Valid solution

.DESCRIPTION
    Tests both the main algorithm and the stack-based alternative implementation
    with various edge cases and scenarios.
#>

# Import the main solution
. "$PSScriptRoot\min_add_parentheses_valid.ps1"

function Test-MinAddParenthesesValid {
    [CmdletBinding()]
    param()
    
    Write-Host "=== Comprehensive Test Suite for Min Add Parentheses Valid ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test cases with expected results
    $testCases = @(
        # Basic cases from problem examples
        @{ Input = "(()(" ; Expected = 2 ; Category = "Problem Examples" ; Description = "Two unmatched opening parentheses" }
        @{ Input = ")))" ; Expected = 3 ; Category = "Problem Examples" ; Description = "Three unmatched closing parentheses" }
        
        # Edge cases
        @{ Input = "" ; Expected = 0 ; Category = "Edge Cases" ; Description = "Empty string" }
        @{ Input = "()" ; Expected = 0 ; Category = "Edge Cases" ; Description = "Already valid parentheses" }
        @{ Input = "(" ; Expected = 1 ; Category = "Edge Cases" ; Description = "Single opening parenthesis" }
        @{ Input = ")" ; Expected = 1 ; Category = "Edge Cases" ; Description = "Single closing parenthesis" }
        
        # Only opening parentheses
        @{ Input = "(((" ; Expected = 3 ; Category = "Only Opening" ; Description = "Three opening parentheses" }
        @{ Input = "((((" ; Expected = 4 ; Category = "Only Opening" ; Description = "Four opening parentheses" }
        
        # Only closing parentheses
        @{ Input = ")))" ; Expected = 3 ; Category = "Only Closing" ; Description = "Three closing parentheses" }
        @{ Input = "))))" ; Expected = 4 ; Category = "Only Closing" ; Description = "Four closing parentheses" }
        
        # Mixed unmatched cases
        @{ Input = "())" ; Expected = 1 ; Category = "Mixed" ; Description = "One unmatched closing" }
        @{ Input = "(()" ; Expected = 1 ; Category = "Mixed" ; Description = "One unmatched opening" }
        @{ Input = ")()(" ; Expected = 2 ; Category = "Mixed" ; Description = "One unmatched closing + one unmatched opening" }
        @{ Input = "())" ; Expected = 1 ; Category = "Mixed" ; Description = "Valid pair with extra closing" }
        
        # Complex nested cases
        @{ Input = "(())" ; Expected = 0 ; Category = "Complex Valid" ; Description = "Nested valid parentheses" }
        @{ Input = "()()" ; Expected = 0 ; Category = "Complex Valid" ; Description = "Multiple valid pairs" }
        @{ Input = "((()))" ; Expected = 0 ; Category = "Complex Valid" ; Description = "Deeply nested valid" }
        @{ Input = "()()()"; Expected = 0 ; Category = "Complex Valid" ; Description = "Multiple consecutive valid pairs" }
        
        # Complex invalid cases
        @{ Input = "((()"; Expected = 2 ; Category = "Complex Invalid" ; Description = "Nested with two unmatched opening" }
        @{ Input = "()))"; Expected = 1 ; Category = "Complex Invalid" ; Description = "Nested with one unmatched closing" }
        @{ Input = ")(()" ; Expected = 1 ; Category = "Complex Invalid" ; Description = "Leading unmatched closing" }
        @{ Input = "(()("; Expected = 2 ; Category = "Complex Invalid" ; Description = "Mixed nested unmatched" }
        @{ Input = "))((" ; Expected = 4 ; Category = "Complex Invalid" ; Description = "Two closing + two opening unmatched" }
        
        # Stress test cases
        @{ Input = "(((((((("; Expected = 8 ; Category = "Stress Test" ; Description = "Eight unmatched opening" }
        @{ Input = "))))))))"; Expected = 8 ; Category = "Stress Test" ; Description = "Eight unmatched closing" }
        @{ Input = "()()()()"; Expected = 0 ; Category = "Stress Test" ; Description = "Four valid pairs" }
        @{ Input = "(((())))"; Expected = 0 ; Category = "Stress Test" ; Description = "Four nested valid pairs" }
    )
    
    $totalTests = $testCases.Count
    $passedTests = 0
    $failedTests = 0
    
    # Group tests by category
    $groupedTests = $testCases | Group-Object Category
    
    foreach ($group in $groupedTests) {
        Write-Host "--- $($group.Name) ---" -ForegroundColor Yellow
        
        foreach ($test in $group.Group) {
            # Test main algorithm
            $result1 = Get-MinAddParenthesesValid $test.Input
            
            # Test stack algorithm
            $result2 = Get-MinAddParenthesesValidStack $test.Input
            
            # Check if both algorithms agree
            $algorithmsAgree = $result1 -eq $result2
            
            # Check if result matches expected
            $isCorrect = $result1 -eq $test.Expected
            
            if ($isCorrect -and $algorithmsAgree) {
                $passedTests++
                $status = "✓ PASS"
                $statusColor = "Green"
            } else {
                $failedTests++
                $status = "✗ FAIL"
                $statusColor = "Red"
            }
            
            Write-Host "Input: '$($test.Input)' -> " -NoNewline
            Write-Host "Balance: $result1, Stack: $result2 | Expected: $($test.Expected) | " -NoNewline
            Write-Host $status -ForegroundColor $statusColor
            
            if (-not $algorithmsAgree) {
                Write-Host "  WARNING: Algorithms disagree!" -ForegroundColor Magenta
            }
            
            Write-Host "  $($test.Description)" -ForegroundColor Gray
        }
        Write-Host ""
    }
    
    # Summary
    Write-Host "=== Test Summary ===" -ForegroundColor Cyan
    Write-Host "Total Tests: $totalTests" -ForegroundColor White
    Write-Host "Passed: $passedTests" -ForegroundColor Green
    Write-Host "Failed: $failedTests" -ForegroundColor Red
    
    $successRate = [math]::Round(($passedTests / $totalTests) * 100, 2)
    Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($successRate -eq 100) { "Green" } else { "Yellow" })
    
    return @{
        Total = $totalTests
        Passed = $passedTests
        Failed = $failedTests
        SuccessRate = $successRate
    }
}

function Test-Performance {
    [CmdletBinding()]
    param()
    
    Write-Host "=== Performance Comparison ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Generate test strings of different sizes
    $testSizes = @(100, 1000, 10000)
    
    foreach ($size in $testSizes) {
        Write-Host "Testing with string length: $size" -ForegroundColor Yellow
        
        # Generate test string with mixed parentheses
        $testString = ""
        for ($i = 0; $i -lt $size; $i++) {
            $testString += if ($i % 2 -eq 0) { "(" } else { ")" }
        }
        
        # Test balance method
        $balanceTime = Measure-Command {
            $result1 = Get-MinAddParenthesesValid $testString
        }
        
        # Test stack method
        $stackTime = Measure-Command {
            $result2 = Get-MinAddParenthesesValidStack $testString
        }
        
        Write-Host "  Balance Method: $($balanceTime.TotalMilliseconds) ms (Result: $result1)"
        Write-Host "  Stack Method:   $($stackTime.TotalMilliseconds) ms (Result: $result2)"
        Write-Host "  Speed Ratio:    $(($stackTime.TotalMilliseconds / $balanceTime.TotalMilliseconds).ToString('F2'))x faster (Balance)"
        Write-Host ""
    }
}

function Test-EdgeCasesDetailed {
    [CmdletBinding()]
    param()
    
    Write-Host "=== Detailed Edge Case Analysis ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Test null and empty inputs
    Write-Host "Testing null/empty inputs:" -ForegroundColor Yellow
    
    try {
        $result = Get-MinAddParenthesesValid ""
        Write-Host "Empty string: $result (Expected: 0)" -ForegroundColor $(if ($result -eq 0) { "Green" } else { "Red" })
    }
    catch {
        Write-Host "Empty string: ERROR - $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Test very long strings
    Write-Host "`nTesting very long strings:" -ForegroundColor Yellow
    
    $longString = "(" * 1000 + ")" * 500  # 500 unmatched opening
    $result = Get-MinAddParenthesesValid $longString
    Write-Host "1000 '(' + 500 ')': $result (Expected: 500)" -ForegroundColor $(if ($result -eq 500) { "Green" } else { "Red" })
    
    $longString2 = ")" * 1000 + "(" * 500  # 500 unmatched closing
    $result2 = Get-MinAddParenthesesValid $longString2
    Write-Host "1000 ')' + 500 '(': $result2 (Expected: 1000)" -ForegroundColor $(if ($result2 -eq 1000) { "Green" } else { "Red" })
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    $testResults = Test-MinAddParenthesesValid
    Write-Host ""
    Test-Performance
    Write-Host ""
    Test-EdgeCasesDetailed
    
    # Exit with appropriate code
    if ($testResults.Failed -eq 0) {
        Write-Host "`n🎉 All tests passed!" -ForegroundColor Green
        exit 0
    } else {
        Write-Host "`n❌ Some tests failed!" -ForegroundColor Red
        exit 1
    }
}

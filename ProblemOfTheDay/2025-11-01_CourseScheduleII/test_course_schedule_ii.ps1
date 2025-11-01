# Test Script for Course Schedule II
# Comprehensive testing with multiple test cases and edge cases

# Import the main solution
. "$PSScriptRoot\course_schedule_ii.ps1"

function Run-TestCase {
    param(
        [string]$testName,
        [int]$n,
        [array]$prerequisites,
        [string]$expectedDescription
    )
    
    Write-Host "=== $testName ===" -ForegroundColor Cyan
    Write-Host "Input: n = $n, prerequisites = $($prerequisites | ConvertTo-Json -Compress)"
    Write-Host "Expected: $expectedDescription"
    Write-Host ""
    
    try {
        $result = Solve-CourseScheduleII -n $n -prerequisites $prerequisites
        
        if ($result.Count -gt 0) {
            Write-Host "Result: SUCCESS - Order found: [$($result -join ', ')]" -ForegroundColor Green
        } else {
            Write-Host "Result: IMPOSSIBLE - No valid order exists" -ForegroundColor Red
        }
        
        Write-Host ""
        return $result
    }
    catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        return $null
    }
}

function Test-CourseScheduleII {
    Write-Host "Course Schedule II - Comprehensive Test Suite" -ForegroundColor Yellow
    Write-Host "=============================================" -ForegroundColor Yellow
    Write-Host ""
    
    $testResults = @()
    
    # Test Case 1: Basic valid case from example 1
    $result1 = Run-TestCase -testName "Test 1: Basic Linear Chain" `
                           -n 3 `
                           -prerequisites @(@(1, 0), @(2, 1)) `
                           -expectedDescription "Valid order like [0, 1, 2]"
    $testResults += @{ Name = "Test 1"; Passed = ($result1.Count -eq 3) }
    
    # Test Case 2: Multiple valid orders from example 2
    $result2 = Run-TestCase -testName "Test 2: Multiple Dependencies" `
                           -n 4 `
                           -prerequisites @(@(2, 0), @(2, 1), @(3, 2)) `
                           -expectedDescription "Valid order like [0, 1, 2, 3] or [1, 0, 2, 3]"
    $testResults += @{ Name = "Test 2"; Passed = ($result2.Count -eq 4) }
    
    # Test Case 3: Simple cycle (impossible)
    $result3 = Run-TestCase -testName "Test 3: Simple Cycle" `
                           -n 3 `
                           -prerequisites @(@(0, 1), @(1, 2), @(2, 0)) `
                           -expectedDescription "Impossible due to cycle"
    $testResults += @{ Name = "Test 3"; Passed = ($result3.Count -eq 0) }
    
    # Test Case 4: No prerequisites (all courses independent)
    $result4 = Run-TestCase -testName "Test 4: No Prerequisites" `
                           -n 4 `
                           -prerequisites @() `
                           -expectedDescription "Any order is valid, e.g., [0, 1, 2, 3]"
    $testResults += @{ Name = "Test 4"; Passed = ($result4.Count -eq 4) }
    
    # Test Case 5: Single course
    $result5 = Run-TestCase -testName "Test 5: Single Course" `
                           -n 1 `
                           -prerequisites @() `
                           -expectedDescription "Single course [0]"
    $testResults += @{ Name = "Test 5"; Passed = ($result5.Count -eq 1 -and $result5[0] -eq 0) }
    
    # Test Case 6: Complex valid case
    $result6 = Run-TestCase -testName "Test 6: Complex Valid Case" `
                           -n 6 `
                           -prerequisites @(@(1, 0), @(2, 0), @(3, 1), @(3, 2), @(4, 3), @(5, 4)) `
                           -expectedDescription "Valid order respecting all dependencies"
    $testResults += @{ Name = "Test 6"; Passed = ($result6.Count -eq 6) }
    
    # Test Case 7: Complex cycle
    $result7 = Run-TestCase -testName "Test 7: Complex Cycle" `
                           -n 5 `
                           -prerequisites @(@(1, 0), @(2, 1), @(3, 2), @(4, 3), @(0, 4)) `
                           -expectedDescription "Impossible due to complex cycle"
    $testResults += @{ Name = "Test 7"; Passed = ($result7.Count -eq 0) }
    
    # Test Case 8: Self-prerequisite (if allowed by constraints)
    # Note: Problem states prerequisites[i][0] ≠ prerequisites[i][1], so this shouldn't happen
    # But let's test edge case handling
    
    # Test Case 9: Large valid case
    $result9 = Run-TestCase -testName "Test 9: Large Valid Case" `
                           -n 8 `
                           -prerequisites @(@(1, 0), @(2, 0), @(3, 1), @(4, 1), @(5, 2), @(6, 3), @(7, 4)) `
                           -expectedDescription "Valid order for larger graph"
    $testResults += @{ Name = "Test 9"; Passed = ($result9.Count -eq 8) }
    
    # Test Case 10: Star pattern (one course depends on all others)
    $result10 = Run-TestCase -testName "Test 10: Star Pattern" `
                            -n 5 `
                            -prerequisites @(@(4, 0), @(4, 1), @(4, 2), @(4, 3)) `
                            -expectedDescription "Course 4 depends on all others"
    $testResults += @{ Name = "Test 10"; Passed = ($result10.Count -eq 5 -and $result10[-1] -eq 4) }
    
    Write-Host "=== Test Summary ===" -ForegroundColor Yellow
    $passedCount = ($testResults | Where-Object { $_.Passed }).Count
    $totalCount = $testResults.Count
    
    foreach ($test in $testResults) {
        $status = if ($test.Passed) { "PASS" } else { "FAIL" }
        $color = if ($test.Passed) { "Green" } else { "Red" }
        Write-Host "$($test.Name): $status" -ForegroundColor $color
    }
    
    Write-Host ""
    Write-Host "Tests Passed: $passedCount / $totalCount" -ForegroundColor $(if ($passedCount -eq $totalCount) { "Green" } else { "Yellow" })
    
    if ($passedCount -eq $totalCount) {
        Write-Host "All tests passed! 🎉" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed. Please review the implementation." -ForegroundColor Yellow
    }
}

# Performance test function
function Test-Performance {
    Write-Host ""
    Write-Host "=== Performance Test ===" -ForegroundColor Yellow
    
    # Test with larger inputs
    $n = 1000
    $prerequisites = @()
    
    # Create a chain of dependencies: 0->1->2->...->999
    for ($i = 1; $i -lt $n; $i++) {
        $prerequisites += @($i, $i - 1)
    }
    
    Write-Host "Testing performance with $n courses in a chain..."
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $result = Find-CourseOrder -n $n -prerequisites $prerequisites
    $stopwatch.Stop()
    
    Write-Host "Performance test completed in $($stopwatch.ElapsedMilliseconds) ms"
    Write-Host "Result: $(if ($result.Count -eq $n) { 'SUCCESS' } else { 'FAILED' }) - Found order for $($result.Count) courses"
}

# Run all tests
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Test-CourseScheduleII
    Test-Performance
}

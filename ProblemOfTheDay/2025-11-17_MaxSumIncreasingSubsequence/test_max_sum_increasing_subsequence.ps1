# Comprehensive test suite for Max Sum Increasing Subsequence solution
# Tests various scenarios including edge cases, basic cases, and complex cases

# Import the solution
. "$PSScriptRoot\max_sum_increasing_subsequence.ps1"

function Test-MaxSumIncreasingSubsequence {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Max Sum Increasing Subsequence - Tests" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $totalTests = 0
    $passedTests = 0
    
    # Test 1: Example 1 from problem
    $totalTests++
    Write-Host "Test 1: Example 1 - [1, 101, 2, 3, 100]" -ForegroundColor Yellow
    $input1 = @(1, 101, 2, 3, 100)
    $expected1 = 106
    $result1 = Get-MaxSumIncreasingSubsequence -arr $input1
    if ($result1 -eq $expected1) {
        Write-Host "  PASSED: Got $result1" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected1, Got $result1" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 2: Example 2 from problem
    $totalTests++
    Write-Host "Test 2: Example 2 - [4, 1, 2, 3]" -ForegroundColor Yellow
    $input2 = @(4, 1, 2, 3)
    $expected2 = 6
    $result2 = Get-MaxSumIncreasingSubsequence -arr $input2
    if ($result2 -eq $expected2) {
        Write-Host "  PASSED: Got $result2" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected2, Got $result2" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 3: Example 3 from problem
    $totalTests++
    Write-Host "Test 3: Example 3 - [4, 1, 2, 4]" -ForegroundColor Yellow
    $input3 = @(4, 1, 2, 4)
    $expected3 = 7
    $result3 = Get-MaxSumIncreasingSubsequence -arr $input3
    if ($result3 -eq $expected3) {
        Write-Host "  PASSED: Got $result3" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected3, Got $result3" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 4: Single element
    $totalTests++
    Write-Host "Test 4: Single element - [42]" -ForegroundColor Yellow
    $input4 = @(42)
    $expected4 = 42
    $result4 = Get-MaxSumIncreasingSubsequence -arr $input4
    if ($result4 -eq $expected4) {
        Write-Host "  PASSED: Got $result4" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected4, Got $result4" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 5: Already sorted increasing array
    $totalTests++
    Write-Host "Test 5: Already sorted - [1, 2, 3, 4, 5]" -ForegroundColor Yellow
    $input5 = @(1, 2, 3, 4, 5)
    $expected5 = 15
    $result5 = Get-MaxSumIncreasingSubsequence -arr $input5
    if ($result5 -eq $expected5) {
        Write-Host "  PASSED: Got $result5" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected5, Got $result5" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 6: Decreasing array
    $totalTests++
    Write-Host "Test 6: Decreasing array - [5, 4, 3, 2, 1]" -ForegroundColor Yellow
    $input6 = @(5, 4, 3, 2, 1)
    $expected6 = 5
    $result6 = Get-MaxSumIncreasingSubsequence -arr $input6
    if ($result6 -eq $expected6) {
        Write-Host "  PASSED: Got $result6" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected6, Got $result6" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 7: Array with duplicates
    $totalTests++
    Write-Host "Test 7: Array with duplicates - [1, 2, 2, 3]" -ForegroundColor Yellow
    $input7 = @(1, 2, 2, 3)
    $expected7 = 6
    $result7 = Get-MaxSumIncreasingSubsequence -arr $input7
    if ($result7 -eq $expected7) {
        Write-Host "  PASSED: Got $result7" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected7, Got $result7" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 8: Large values
    $totalTests++
    Write-Host "Test 8: Large values - [10000, 1, 2, 50000]" -ForegroundColor Yellow
    $input8 = @(10000, 1, 2, 50000)
    $expected8 = 60000
    $result8 = Get-MaxSumIncreasingSubsequence -arr $input8
    if ($result8 -eq $expected8) {
        Write-Host "  PASSED: Got $result8" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected8, Got $result8" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 9: Two elements ascending
    $totalTests++
    Write-Host "Test 9: Two elements ascending - [5, 10]" -ForegroundColor Yellow
    $input9 = @(5, 10)
    $expected9 = 15
    $result9 = Get-MaxSumIncreasingSubsequence -arr $input9
    if ($result9 -eq $expected9) {
        Write-Host "  PASSED: Got $result9" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected9, Got $result9" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 10: Two elements descending
    $totalTests++
    Write-Host "Test 10: Two elements descending - [10, 5]" -ForegroundColor Yellow
    $input10 = @(10, 5)
    $expected10 = 10
    $result10 = Get-MaxSumIncreasingSubsequence -arr $input10
    if ($result10 -eq $expected10) {
        Write-Host "  PASSED: Got $result10" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected10, Got $result10" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 11: Complex case
    $totalTests++
    Write-Host "Test 11: Complex case - [3, 4, 5, 10]" -ForegroundColor Yellow
    $input11 = @(3, 4, 5, 10)
    $expected11 = 22
    $result11 = Get-MaxSumIncreasingSubsequence -arr $input11
    if ($result11 -eq $expected11) {
        Write-Host "  PASSED: Got $result11" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected $expected11, Got $result11" -ForegroundColor Red
    }
    Write-Host ""
    
    # Test 12: Path tracking
    $totalTests++
    Write-Host "Test 12: Path tracking - [1, 101, 2, 3, 100]" -ForegroundColor Yellow
    $input12 = @(1, 101, 2, 3, 100)
    $result12 = Get-MaxSumIncreasingSubsequenceWithPath -arr $input12
    $expectedSum = 106
    $expectedPath = @(1, 2, 3, 100)
    
    $pathMatches = $true
    if ($result12.Subsequence.Length -eq $expectedPath.Length) {
        for ($i = 0; $i -lt $expectedPath.Length; $i++) {
            if ($result12.Subsequence[$i] -ne $expectedPath[$i]) {
                $pathMatches = $false
                break
            }
        }
    } else {
        $pathMatches = $false
    }
    
    if ($result12.Sum -eq $expectedSum -and $pathMatches) {
        Write-Host "  PASSED: Sum=$($result12.Sum), Path=[$($result12.Subsequence -join ', ')]" -ForegroundColor Green
        $passedTests++
    } else {
        Write-Host "  FAILED: Expected Sum=$expectedSum, Path=[$($expectedPath -join ', ')]" -ForegroundColor Red
        Write-Host "           Got Sum=$($result12.Sum), Path=[$($result12.Subsequence -join ', ')]" -ForegroundColor Red
    }
    Write-Host ""
    
    # Summary
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Test Summary" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Total Tests: $totalTests" -ForegroundColor White
    Write-Host "Passed: $passedTests" -ForegroundColor Green
    Write-Host "Failed: $($totalTests - $passedTests)" -ForegroundColor $(if ($passedTests -eq $totalTests) { "Green" } else { "Red" })
    Write-Host ""
    
    if ($passedTests -eq $totalTests) {
        Write-Host "All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed. Please review." -ForegroundColor Red
    }
    Write-Host ""
}

# Run tests
Test-MaxSumIncreasingSubsequence

<#
.SYNOPSIS
    Comprehensive test suite for XOR Pairs less than K solution

.DESCRIPTION
    Tests the solution with various test cases including edge cases,
    validates against brute force implementation, and measures performance
#>

# Import the solution
. "$PSScriptRoot\xor_pairs_less_than_k.ps1"

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-Case {
    param (
        [string]$TestName,
        [int[]]$arr,
        [int]$k,
        [int]$Expected
    )
    
    Write-Host "Running: $TestName" -ForegroundColor Cyan
    
    try {
        $result = Get-XORPairsLessThanK -arr $arr -k $k
        
        # Also verify with brute force
        $bruteResult = Get-XORPairsLessThanK-BruteForce -arr $arr -k $k
        
        if ($result -eq $Expected -and $result -eq $bruteResult) {
            Write-Host "  PASSED" -ForegroundColor Green
            Write-Host "    Input: arr = [$($arr -join ', ')], k = $k" -ForegroundColor Gray
            Write-Host "    Output: $result, Expected: $Expected" -ForegroundColor Gray
            $script:TestsPassed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "PASSED"
                Expected = $Expected
                Got = $result
            }
        }
        else {
            Write-Host "  FAILED" -ForegroundColor Red
            Write-Host "    Input: arr = [$($arr -join ', ')], k = $k" -ForegroundColor Gray
            Write-Host "    Expected: $Expected" -ForegroundColor Gray
            Write-Host "    Got (Trie): $result" -ForegroundColor Gray
            Write-Host "    Got (BruteForce): $bruteResult" -ForegroundColor Gray
            $script:TestsFailed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "FAILED"
                Expected = $Expected
                Got = $result
            }
        }
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
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

# Run all tests
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  XOR Pairs less than K - Test Suite" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Basic test cases from problem
Test-Case -TestName "Example 1: Basic case" -arr @(1, 2, 3, 5) -k 5 -Expected 4
Test-Case -TestName "Example 2: Basic case" -arr @(3, 5, 6, 8) -k 7 -Expected 3

# Edge cases
Test-Case -TestName "Edge: Single element" -arr @(5) -k 10 -Expected 0
Test-Case -TestName "Edge: Two elements XOR valid" -arr @(1, 2) -k 5 -Expected 1
Test-Case -TestName "Edge: Two elements XOR invalid" -arr @(1, 10) -k 5 -Expected 0
Test-Case -TestName "Edge: k equals 1" -arr @(1, 2, 3) -k 1 -Expected 0
Test-Case -TestName "Edge: All same numbers" -arr @(5, 5, 5, 5) -k 5 -Expected 6
Test-Case -TestName "Edge: Large k all pairs valid" -arr @(1, 2, 3, 4) -k 100 -Expected 6
Test-Case -TestName "Edge: k equals 0" -arr @(1, 2, 3, 4) -k 0 -Expected 0

# Sequential numbers
Test-Case -TestName "Sequential: 1 to 5" -arr @(1, 2, 3, 4, 5) -k 4 -Expected 4

# Powers of 2
Test-Case -TestName "Powers of 2: Small" -arr @(1, 2, 4, 8) -k 10 -Expected 4
Test-Case -TestName "Powers of 2: Large" -arr @(1, 2, 4, 8, 16) -k 20 -Expected 8

# Random cases
Test-Case -TestName "Random: Mixed values" -arr @(10, 20, 30, 40, 50) -k 25 -Expected 2
Test-Case -TestName "Random: Large numbers" -arr @(100, 200, 300, 400) -k 250 -Expected 2

# Stress test with larger array
Test-Case -TestName "Stress: 10 elements" -arr @(1, 3, 5, 7, 9, 11, 13, 15, 17, 19) -k 10 -Expected 17

# XOR properties tests
Test-Case -TestName "XOR Props: Consecutive numbers" -arr @(7, 8, 9, 10) -k 5 -Expected 3
Test-Case -TestName "XOR Props: Even numbers" -arr @(2, 4, 6, 8, 10) -k 8 -Expected 4
Test-Case -TestName "XOR Props: Odd numbers" -arr @(1, 3, 5, 7, 9) -k 8 -Expected 6

# Performance test
Write-Host "Performance Test: Large array 100 elements" -ForegroundColor Yellow
$largeArr = 1..100
$perfK = 50

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$trieResult = Get-XORPairsLessThanK -arr $largeArr -k $perfK
$sw.Stop()
$trieTime = $sw.ElapsedMilliseconds

Write-Host "  Trie solution: $trieTime ms" -ForegroundColor Gray

$sw.Restart()
$bruteResult = Get-XORPairsLessThanK-BruteForce -arr $largeArr -k $perfK
$sw.Stop()
$bruteTime = $sw.ElapsedMilliseconds

Write-Host "  Brute force: $bruteTime ms" -ForegroundColor Gray

if ($trieResult -eq $bruteResult) {
    Write-Host "  Results match: $trieResult pairs" -ForegroundColor Green
    $speedup = [math]::Round($bruteTime / ($trieTime + 1), 2)
    Write-Host "  Speedup: ${speedup}x faster" -ForegroundColor Cyan
}
else {
    Write-Host "  Results do not match!" -ForegroundColor Red
}
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  Test Summary" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "Total Tests: $($script:TestsPassed + $script:TestsFailed)" -ForegroundColor White
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })
Write-Host ""

if ($script:TestsFailed -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Some tests failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Failed Tests:" -ForegroundColor Yellow
    $script:TestResults | Where-Object { $_.Status -ne "PASSED" } | Format-Table -AutoSize
    exit 1
}

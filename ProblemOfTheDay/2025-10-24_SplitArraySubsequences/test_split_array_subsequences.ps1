<#
.SYNOPSIS
    Test script for Split Array Subsequences problem

.DESCRIPTION
    Comprehensive tests for the Split Array Subsequences implementation
    including edge cases, example cases, and performance tests.
#>

# Import the main solution
. "$PSScriptRoot\split_array_subsequences.ps1"

# Test framework functions
function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Array,
        [int]$K,
        [bool]$Expected,
        [string]$Description = ""
    )
    
    Write-Host "Testing: $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "  Description: $Description" -ForegroundColor Gray
    }
    $arrayStr = $Array -join ', '
    Write-Host "  Input: arr = @($arrayStr), k = $K" -ForegroundColor Gray
    Write-Host "  Expected: $Expected" -ForegroundColor Gray
    
    # Test both implementations
    $result1 = Split-ArraySubsequences -arr $Array -k $K
    $result2 = Split-ArraySubsequences-Optimized -arr $Array -k $K
    
    Write-Host "  Result (Standard): $result1" -ForegroundColor Gray
    Write-Host "  Result (Optimized): $result2" -ForegroundColor Gray
    
    if ($result1 -eq $Expected -and $result2 -eq $Expected) {
        Write-Host "  ✓ PASSED" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ✗ FAILED" -ForegroundColor Red
        if ($result1 -ne $result2) {
            Write-Host "    ERROR: Different results between implementations!" -ForegroundColor Red
        }
        return $false
    }
}

function Run-AllTests {
    Write-Host "=== Split Array Subsequences Test Suite ===" -ForegroundColor Yellow
    Write-Host ""
    
    $passed = 0
    $total = 0
    
    # Example test cases from the problem
    $total++; if (Test-Case "Example 1" @(2, 2, 3, 3, 4, 5) 2 $true "Basic case - can split into [2,3], [2,3], [4,5]") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Example 2" @(1, 1, 1, 1, 1) 4 $false "Impossible case - all same numbers") { $passed++ }
    Write-Host ""
    
    # Edge cases
    $total++; if (Test-Case "Empty array" @() 1 $false "Empty input array") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Single element - valid" @(1) 1 $true "Single element with k=1") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Single element - invalid" @(1) 2 $false "Single element with k=2") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Two consecutive" @(1, 2) 2 $true "Exactly one subsequence of length k") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Two non-consecutive" @(1, 3) 1 $true "Two separate subsequences") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Two non-consecutive k=2" @(1, 3) 2 $false "Two separate subsequences, need length 2") { $passed++ }
    Write-Host ""
    
    # More complex test cases
    $total++; if (Test-Case "Perfect sequence" @(1, 2, 3, 4, 5, 6) 3 $true "One long consecutive sequence") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Multiple duplicates" @(1, 1, 2, 2, 3, 3) 2 $true "Multiple pairs forming subsequences") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Gap in sequence" @(1, 2, 4, 5) 2 $true "Two separate consecutive pairs") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Insufficient length" @(1, 2, 4, 5) 3 $false "Pairs too short for k=3") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Mixed lengths possible" @(1, 2, 3, 4, 4, 5) 2 $true "Can form [1,2,3,4] and [4,5]") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Many duplicates corrected" @(1, 1, 1, 2, 2, 3) 2 $false "Three 1s but only two 2s and one 3") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Large k requirement" @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) 5 $true "Long sequence with k=5") { $passed++ }
    Write-Host ""
    
    $total++; if (Test-Case "Large k impossible" @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) 11 $false "Sequence too short for k=11") { $passed++ }
    Write-Host ""
    
    # Test with larger numbers
    $total++; if (Test-Case "Large numbers" @(100, 101, 102, 200, 201, 202) 3 $true "Two separate 3-length sequences") { $passed++ }
    Write-Host ""
    
    # Performance test case
    Write-Host "Performance Test:" -ForegroundColor Cyan
    $largeArray = @()
    for ($i = 1; $i -le 100; $i++) {
        $largeArray += $i, $i  # Each number appears twice
    }
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $result = Split-ArraySubsequences-Optimized -arr $largeArray -k 2
    $stopwatch.Stop()
    
    $elapsed = $stopwatch.ElapsedMilliseconds
    Write-Host "  Large array (200 elements): ${elapsed}ms" -ForegroundColor Gray
    Write-Host "  Result: $result (should be True)" -ForegroundColor Gray
    
    # Summary
    Write-Host ""
    Write-Host "=== Test Results ===" -ForegroundColor Yellow
    Write-Host "Passed: $passed/$total" -ForegroundColor $(if ($passed -eq $total) { "Green" } else { "Red" })
    $successRate = [math]::Round(($passed/$total)*100, 2)
    Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($passed -eq $total) { "Green" } else { "Red" })
    
    if ($passed -eq $total) {
        Write-Host "All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed. Please review the implementation." -ForegroundColor Red
    }
    
    return ($passed -eq $total)
}

# Helper function to demonstrate the algorithm step by step
function Show-Algorithm-Steps {
    param(
        [int[]]$arr,
        [int]$k
    )
    
    Write-Host "=== Algorithm Step-by-Step Demonstration ===" -ForegroundColor Yellow
    $arrStr = $arr -join ', '
    Write-Host "Input: arr = @($arrStr), k = $k" -ForegroundColor Cyan
    Write-Host ""
    
    if ($arr.Length -eq 0 -or $k -le 0 -or $k -gt $arr.Length) {
        Write-Host "Invalid input - returning false" -ForegroundColor Red
        return
    }
    
    # Count frequencies
    Write-Host "Step 1: Count frequencies" -ForegroundColor Green
    $freq = @{}
    foreach ($num in $arr) {
        if ($freq.ContainsKey($num)) {
            $freq[$num]++
        } else {
            $freq[$num] = 1
        }
    }
    
    foreach ($num in ($freq.Keys | Sort-Object)) {
        $count = $freq[$num]
        Write-Host "  $num appears $count times" -ForegroundColor Gray
    }
    Write-Host ""
    
    # Process each number
    Write-Host "Step 2: Process numbers in order" -ForegroundColor Green
    $endingAt = @{}
    $uniqueNumbers = $freq.Keys | Sort-Object
    
    foreach ($num in $uniqueNumbers) {
        $numCount = $freq[$num]
        Write-Host "  Processing number $num (count: $numCount)" -ForegroundColor Cyan
        $available = $freq[$num]
        
        if ($endingAt.ContainsKey($num - 1)) {
            $prevLengths = $endingAt[$num - 1] | Sort-Object
            $canExtend = [Math]::Min($available, $prevLengths.Count)
            $prevNum = $num - 1
            Write-Host "    Can extend $canExtend subsequences from $prevNum" -ForegroundColor Gray
            
            if (-not $endingAt.ContainsKey($num)) {
                $endingAt[$num] = @()
            }
            
            for ($i = 0; $i -lt $canExtend; $i++) {
                $endingAt[$num] += ($prevLengths[$i] + 1)
            }
            
            if ($canExtend -eq $prevLengths.Count) {
                $endingAt.Remove($num - 1)
            } else {
                $endingAt[$num - 1] = $prevLengths[$canExtend..($prevLengths.Count - 1)]
            }
            
            $available -= $canExtend
        }
        
        if ($available -gt 0) {
            Write-Host "    Starting $available new subsequences" -ForegroundColor Gray
            if (-not $endingAt.ContainsKey($num)) {
                $endingAt[$num] = @()
            }
            
            for ($i = 0; $i -lt $available; $i++) {
                $endingAt[$num] += 1
            }
        }
        
        # Show current state
        Write-Host "    Current subsequences:" -ForegroundColor Gray
        foreach ($endNum in ($endingAt.Keys | Sort-Object)) {
            $lengths = $endingAt[$endNum] | Sort-Object
            $lengthStr = $lengths -join ', '
            Write-Host "      Ending at $endNum : $lengthStr" -ForegroundColor Gray
        }
        Write-Host ""
    }
    
    # Final validation
    Write-Host "Step 3: Validate minimum length requirement" -ForegroundColor Green
    $valid = $true
    foreach ($endNum in $endingAt.Keys) {
        foreach ($length in $endingAt[$endNum]) {
            if ($length -lt $k) {
                Write-Host "  Found subsequence of length $length is less than $k" -ForegroundColor Red
                $valid = $false
            }
        }
    }
    
    if ($valid) {
        Write-Host "  All subsequences meet minimum length requirement" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "Final Result: $valid" -ForegroundColor $(if ($valid) { "Green" } else { "Red" })
}

# Run tests when script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Run-AllTests
    
    Write-Host ""
    Write-Host "=== Example Algorithm Demonstration ===" -ForegroundColor Yellow
    Show-Algorithm-Steps -arr @(2, 2, 3, 3, 4, 5) -k 2
}

# Simple test script for Split Array Subsequences

# Import the main solution
. "$PSScriptRoot\split_array_subsequences.ps1"

Write-Host "=== Split Array Subsequences Test Suite ===" -ForegroundColor Yellow
Write-Host ""

$passed = 0
$total = 0

# Test Example 1
$total++
$result1 = Split-ArraySubsequences -arr @(2, 2, 3, 3, 4, 5) -k 2
Write-Host "Test 1: Example 1 - arr=[2,2,3,3,4,5], k=2"
Write-Host "Expected: True, Got: $result1" -ForegroundColor $(if ($result1) { "Green" } else { "Red" })
if ($result1) { $passed++ }
Write-Host ""

# Test Example 2  
$total++
$result2 = Split-ArraySubsequences -arr @(1, 1, 1, 1, 1) -k 4
Write-Host "Test 2: Example 2 - arr=[1,1,1,1,1], k=4"
Write-Host "Expected: False, Got: $result2" -ForegroundColor $(if (-not $result2) { "Green" } else { "Red" })
if (-not $result2) { $passed++ }
Write-Host ""

# Test empty array
$total++
$result3 = Split-ArraySubsequences -arr @() -k 1
Write-Host "Test 3: Empty array - arr=[], k=1"
Write-Host "Expected: False, Got: $result3" -ForegroundColor $(if (-not $result3) { "Green" } else { "Red" })
if (-not $result3) { $passed++ }
Write-Host ""

# Test single element valid
$total++
$result4 = Split-ArraySubsequences -arr @(1) -k 1
Write-Host "Test 4: Single element valid - arr=[1], k=1"
Write-Host "Expected: True, Got: $result4" -ForegroundColor $(if ($result4) { "Green" } else { "Red" })
if ($result4) { $passed++ }
Write-Host ""

# Test two consecutive
$total++
$result5 = Split-ArraySubsequences -arr @(1, 2) -k 2
Write-Host "Test 5: Two consecutive - arr=[1,2], k=2"
Write-Host "Expected: True, Got: $result5" -ForegroundColor $(if ($result5) { "Green" } else { "Red" })
if ($result5) { $passed++ }
Write-Host ""

# Test multiple duplicates
$total++
$result6 = Split-ArraySubsequences -arr @(1, 1, 2, 2, 3, 3) -k 2
Write-Host "Test 6: Multiple duplicates - arr=[1,1,2,2,3,3], k=2"
Write-Host "Expected: True, Got: $result6" -ForegroundColor $(if ($result6) { "Green" } else { "Red" })
if ($result6) { $passed++ }
Write-Host ""

# Test gap in sequence
$total++
$result7 = Split-ArraySubsequences -arr @(1, 2, 4, 5) -k 2
Write-Host "Test 7: Gap in sequence - arr=[1,2,4,5], k=2"
Write-Host "Expected: True, Got: $result7" -ForegroundColor $(if ($result7) { "Green" } else { "Red" })
if ($result7) { $passed++ }
Write-Host ""

# Test insufficient length
$total++
$result8 = Split-ArraySubsequences -arr @(1, 2, 4, 5) -k 3
Write-Host "Test 8: Insufficient length - arr=[1,2,4,5], k=3"
Write-Host "Expected: False, Got: $result8" -ForegroundColor $(if (-not $result8) { "Green" } else { "Red" })
if (-not $result8) { $passed++ }
Write-Host ""

# Summary
Write-Host "=== Test Results ===" -ForegroundColor Yellow
Write-Host "Passed: $passed out of $total tests" -ForegroundColor $(if ($passed -eq $total) { "Green" } else { "Red" })
$successRate = [math]::Round(($passed/$total)*100, 2)
Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($passed -eq $total) { "Green" } else { "Red" })

if ($passed -eq $total) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "Some tests failed." -ForegroundColor Red
}

# Test optimized version as well
Write-Host ""
Write-Host "Testing optimized version..." -ForegroundColor Cyan
$opt1 = Split-ArraySubsequences-Optimized -arr @(2, 2, 3, 3, 4, 5) -k 2
$opt2 = Split-ArraySubsequences-Optimized -arr @(1, 1, 1, 1, 1) -k 4
Write-Host "Optimized Example 1: $opt1 (should be True)" -ForegroundColor $(if ($opt1) { "Green" } else { "Red" })
Write-Host "Optimized Example 2: $opt2 (should be False)" -ForegroundColor $(if (-not $opt2) { "Green" } else { "Red" })

# Performance test
Write-Host ""
Write-Host "Performance test with large array..." -ForegroundColor Cyan
$largeArray = @()
for ($i = 1; $i -le 50; $i++) {
    $largeArray += $i, $i
}

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$perfResult = Split-ArraySubsequences-Optimized -arr $largeArray -k 2
$stopwatch.Stop()

Write-Host "Large array test result: $perfResult (should be True)" -ForegroundColor $(if ($perfResult) { "Green" } else { "Red" })
Write-Host "Execution time: $($stopwatch.ElapsedMilliseconds) milliseconds" -ForegroundColor Gray

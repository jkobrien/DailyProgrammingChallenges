<#
.SYNOPSIS
    Test suite for AND In Range solution

.DESCRIPTION
    Comprehensive tests for the AND In Range problem including:
    - Basic examples from problem statement
    - Edge cases (single number, powers of 2)
    - Large numbers
    - Verification against brute force for small ranges
    - Performance testing
#>

# Import the solution
. "$PSScriptRoot\and_in_range.ps1"

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-Case {
    param(
        [string]$Name,
        [long]$l,
        [long]$r,
        [long]$Expected,
        [string]$Description = ""
    )
    
    try {
        $result = Get-ANDInRange -l $l -r $r
        
        if ($result -eq $Expected) {
            $script:TestsPassed++
            $script:TestResults += [PSCustomObject]@{
                Name = $Name
                Status = "PASS"
                Input = "l=$l, r=$r"
                Expected = $Expected
                Actual = $result
                Description = $Description
            }
            Write-Host "[PASS] $Name" -ForegroundColor Green
            if ($Description) {
                Write-Host "  $Description" -ForegroundColor Gray
            }
        }
        else {
            $script:TestsFailed++
            $script:TestResults += [PSCustomObject]@{
                Name = $Name
                Status = "FAIL"
                Input = "l=$l, r=$r"
                Expected = $Expected
                Actual = $result
                Description = $Description
            }
            Write-Host "[FAIL] $Name" -ForegroundColor Red
            Write-Host "  Expected: $Expected, Got: $result" -ForegroundColor Red
        }
    }
    catch {
        $script:TestsFailed++
        $script:TestResults += [PSCustomObject]@{
            Name = $Name
            Status = "ERROR"
            Input = "l=$l, r=$r"
            Expected = $Expected
            Actual = "Exception: $($_.Exception.Message)"
            Description = $Description
        }
        Write-Host "[ERROR] $Name - $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Test-BruteForceComparison {
    param(
        [long]$l,
        [long]$r
    )
    
    # Calculate using brute force (only for small ranges)
    [long]$bruteResult = $l
    for ($i = $l + 1; $i -le $r; $i++) {
        $bruteResult = $bruteResult -band $i
    }
    
    return $bruteResult
}

Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host "         AND In Range - Test Suite                         " -ForegroundColor Cyan
Write-Host "         GeeksforGeeks POTD - November 26, 2025            " -ForegroundColor Cyan
Write-Host "============================================================`n" -ForegroundColor Cyan

# Test 1: Example cases from problem statement
Write-Host "`n[Test Group 1: Problem Examples]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

Test-Case -Name "Example 1" -l 8 -r 13 -Expected 8 `
    -Description "8 AND 9 AND 10 AND 11 AND 12 AND 13 = 8"

Test-Case -Name "Example 2" -l 2 -r 3 -Expected 2 `
    -Description "2 AND 3 = 2"

# Test 2: Edge cases
Write-Host "`n[Test Group 2: Edge Cases]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

Test-Case -Name "Single Number" -l 1 -r 1 -Expected 1 `
    -Description "Range with single number returns that number"

Test-Case -Name "Sequential Numbers" -l 5 -r 6 -Expected 4 `
    -Description "Adjacent numbers: 5 (101) AND 6 (110) = 4 (100)"

Test-Case -Name "Power of 2 Range" -l 8 -r 15 -Expected 8 `
    -Description "Range spanning power of 2 boundary"

Test-Case -Name "Adjacent Powers of 2" -l 4 -r 7 -Expected 4 `
    -Description "Range between powers of 2"

# Test 3: Small range validation with brute force
Write-Host "`n[Test Group 3: Brute Force Validation]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

$smallTestCases = @(
    @{l = 1; r = 5},
    @{l = 10; r = 15},
    @{l = 20; r = 25},
    @{l = 100; r = 110},
    @{l = 7; r = 10}
)

foreach ($test in $smallTestCases) {
    $bruteResult = Test-BruteForceComparison -l $test.l -r $test.r
    Test-Case -Name "Brute Force [$($test.l),$($test.r)]" `
        -l $test.l -r $test.r -Expected $bruteResult `
        -Description "Verified against brute force calculation"
}

# Test 4: Larger numbers
Write-Host "`n[Test Group 4: Large Numbers]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

Test-Case -Name "Thousand Range" -l 1000 -r 1010 -Expected 992 `
    -Description "Range in thousands"

Test-Case -Name "Million Range" -l 1000000 -r 1000100 -Expected 999936 `
    -Description "Range in millions"

Test-Case -Name "Large Range" -l 100 -r 200 -Expected 0 `
    -Description "Large range spanning multiple bit positions"

Test-Case -Name "Very Large Numbers" -l 999999990 -r 1000000000 -Expected 999999488 `
    -Description "Near upper constraint limit"

# Test 5: Specific bit pattern tests
Write-Host "`n[Test Group 5: Bit Pattern Tests]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

Test-Case -Name "All Bits Set" -l 15 -r 15 -Expected 15 `
    -Description "Single number with all bits set (0b1111)"

Test-Case -Name "Same MSB Different LSB" -l 12 -r 15 -Expected 12 `
    -Description "12-15 have same 2 MSBs (1100, 1101, 1110, 1111)"

Test-Case -Name "Binary 11xx Pattern" -l 24 -r 31 -Expected 24 `
    -Description "Range 24-31 (11000 to 11111)"

# Test 6: Alternative implementation comparison
Write-Host "`n[Test Group 6: Alternative Implementation]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

$altTestCases = @(
    @{l = 8; r = 13},
    @{l = 2; r = 3},
    @{l = 100; r = 200},
    @{l = 1; r = 1}
)

foreach ($test in $altTestCases) {
    $mainResult = Get-ANDInRange -l $test.l -r $test.r
    $altResult = Get-ANDInRangeAlternative -l $test.l -r $test.r
    
    if ($mainResult -eq $altResult) {
        $script:TestsPassed++
        Write-Host "[PASS] Alternative impl [$($test.l),$($test.r)] matches main" -ForegroundColor Green
    }
    else {
        $script:TestsFailed++
        Write-Host "[FAIL] Alternative impl [$($test.l),$($test.r)] - Main: $mainResult, Alt: $altResult" -ForegroundColor Red
    }
}

# Test 7: Performance test
Write-Host "`n[Test Group 7: Performance Test]" -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Gray

$perfTestCases = @(
    @{l = 1; r = 1000000000; desc = "Maximum range"},
    @{l = 500000000; r = 1000000000; desc = "Large midpoint range"},
    @{l = 1; r = 100000; desc = "Medium range"}
)

foreach ($test in $perfTestCases) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $result = Get-ANDInRange -l $test.l -r $test.r
    $sw.Stop()
    
    $timeMs = $sw.Elapsed.TotalMilliseconds
    $status = if ($timeMs -lt 10) { "[+] Excellent" } elseif ($timeMs -lt 50) { "[+] Good" } else { "[!] Slow" }
    $color = if ($timeMs -lt 10) { "Green" } elseif ($timeMs -lt 50) { "Yellow" } else { "Red" }
    
    Write-Host "$status - $($test.desc): $($timeMs.ToString('F4')) ms (Result: $result)" -ForegroundColor $color
}

# Summary
Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host "                    TEST SUMMARY                            " -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$totalTests = $script:TestsPassed + $script:TestsFailed
$passRate = if ($totalTests -gt 0) { [math]::Round(($script:TestsPassed / $totalTests) * 100, 2) } else { 0 }

Write-Host "`nTotal Tests Run:  $totalTests" -ForegroundColor White
Write-Host "Tests Passed:     $script:TestsPassed" -ForegroundColor Green
Write-Host "Tests Failed:     $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })
Write-Host "Pass Rate:        $passRate%" -ForegroundColor $(if ($passRate -eq 100) { "Green" } elseif ($passRate -ge 80) { "Yellow" } else { "Red" })

if ($script:TestsFailed -eq 0) {
    Write-Host "`n*** All tests passed! Solution is working correctly. ***" -ForegroundColor Green
}
else {
    Write-Host "`n*** Some tests failed. Please review the failures above. ***" -ForegroundColor Red
}

Write-Host ""

# Return exit code based on test results
exit $script:TestsFailed

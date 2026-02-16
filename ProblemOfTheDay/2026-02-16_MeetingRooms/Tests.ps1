<#
.SYNOPSIS
    Comprehensive test suite for Meeting Rooms problem

.DESCRIPTION
    Tests all edge cases and scenarios for the Can-Attend-All-Meetings function
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestNumber = 0

function Test-Case {
    param(
        [string]$TestName,
        [array]$Input,
        [bool]$Expected,
        [string]$Description = ""
    )
    
    $script:TestNumber++
    
    Write-Host "`n═══════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "Test $script:TestNumber : $TestName" -ForegroundColor Cyan
    if ($Description) {
        Write-Host "Description: $Description" -ForegroundColor Gray
    }
    
    Write-Host "Input: " -NoNewline
    $inputParts = @()
    foreach ($meeting in $Input) {
        $inputParts += "[$($meeting[0]),$($meeting[1])]"
    }
    $inputStr = $inputParts -join ', '
    Write-Host "$inputStr" -ForegroundColor Yellow
    
    Write-Host "Expected: " -NoNewline -ForegroundColor Gray
    $expectedColor = if ($Expected) { "Green" } else { "Red" }
    Write-Host "$Expected" -ForegroundColor $expectedColor
    
    try {
        $result = Can-Attend-All-Meetings -meetings $Input
        Write-Host "Got:      " -NoNewline -ForegroundColor Gray
        $resultColor = if ($result) { "Green" } else { "Red" }
        Write-Host "$result" -ForegroundColor $resultColor
        
        if ($result -eq $Expected) {
            Write-Host "✓ PASS" -ForegroundColor Green
            $script:TestsPassed++
        } else {
            Write-Host "✗ FAIL" -ForegroundColor Red
            $script:TestsFailed++
        }
    }
    catch {
        Write-Host "✗ ERROR: $_" -ForegroundColor Red
        $script:TestsFailed++
    }
}

function Write-TestSummary {
    $total = $script:TestsPassed + $script:TestsFailed
    
    Write-Host "`n═══════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "TEST SUMMARY" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host "Total Tests:  $total" -ForegroundColor White
    Write-Host "Passed:       $script:TestsPassed" -ForegroundColor Green
    $failedColor = if ($script:TestsFailed -eq 0) { "Green" } else { "Red" }
    Write-Host "Failed:       $script:TestsFailed" -ForegroundColor $failedColor
    
    $percentage = if ($total -gt 0) { [math]::Round(($script:TestsPassed / $total) * 100, 2) } else { 0 }
    $percentColor = if ($percentage -eq 100) { "Green" } else { "Yellow" }
    Write-Host "Pass Rate:    $percentage%" -ForegroundColor $percentColor
    Write-Host "═══════════════════════════════════════════════════════`n" -ForegroundColor DarkGray
    
    if ($script:TestsFailed -eq 0) {
        Write-Host "All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "Some tests failed. Please review." -ForegroundColor Yellow
    }
}

# Run all tests
Write-Host "`n╔═══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║         MEETING ROOMS - TEST SUITE                    ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Example Test Cases from problem
Test-Case -TestName "Example 1: Non-overlapping meetings" -Input @(@(1,4), @(10,15), @(7,10)) -Expected $true -Description "Three meetings at different times"
Test-Case -TestName "Example 2: Overlapping meetings" -Input @(@(2,4), @(9,12), @(6,10)) -Expected $false -Description "Second and third meetings overlap"

# Edge Cases
Test-Case -TestName "Single meeting" -Input @(@(1,5)) -Expected $true -Description "Only one meeting - always possible"
Test-Case -TestName "Empty array" -Input @() -Expected $true -Description "No meetings - trivially true"
Test-Case -TestName "Two non-overlapping meetings" -Input @(@(1,3), @(3,5)) -Expected $true -Description "Meeting ends exactly when next starts"
Test-Case -TestName "Two overlapping meetings" -Input @(@(1,4), @(3,5)) -Expected $false -Description "Second meeting starts before first ends"

# Additional Test Cases
Test-Case -TestName "Multiple meetings - all non-overlapping (sorted)" -Input @(@(1,2), @(3,4), @(5,6), @(7,8)) -Expected $true -Description "Sequential meetings with gaps"
Test-Case -TestName "Multiple meetings - all non-overlapping (unsorted)" -Input @(@(7,8), @(1,2), @(5,6), @(3,4)) -Expected $true -Description "Unsorted but non-overlapping meetings"
Test-Case -TestName "Multiple overlapping meetings" -Input @(@(1,5), @(2,6), @(3,7)) -Expected $false -Description "All meetings overlap with each other"
Test-Case -TestName "Back-to-back meetings" -Input @(@(1,2), @(2,3), @(3,4), @(4,5)) -Expected $true -Description "Meetings start exactly when previous ends"
Test-Case -TestName "One long meeting covering others" -Input @(@(1,10), @(2,3), @(5,6)) -Expected $false -Description "First meeting spans time of others"
Test-Case -TestName "Same start time, different end times" -Input @(@(1,3), @(1,5)) -Expected $false -Description "Two meetings start at same time"
Test-Case -TestName "Same end time, different start times" -Input @(@(1,5), @(3,5)) -Expected $false -Description "Two meetings end at same time but overlap"
Test-Case -TestName "Identical meetings" -Input @(@(1,5), @(1,5)) -Expected $false -Description "Two identical meeting times"
Test-Case -TestName "Large time values" -Input @(@(1000000, 1500000), @(1500000, 2000000)) -Expected $true -Description "Testing with large time values"
Test-Case -TestName "Zero duration meetings (point meetings)" -Input @(@(1,1), @(2,2), @(3,3)) -Expected $true -Description "Meetings with zero duration"
Test-Case -TestName "Complex unsorted scenario - no overlap" -Input @(@(15,20), @(5,10), @(0,3), @(21,25), @(11,14)) -Expected $true -Description "Five unsorted non-overlapping meetings"
Test-Case -TestName "Complex unsorted scenario - with overlap" -Input @(@(15,20), @(5,10), @(0,6), @(21,25), @(11,14)) -Expected $false -Description "Meeting at [0,6] overlaps with [5,10]"
Test-Case -TestName "All meetings at same time" -Input @(@(5,10), @(5,10), @(5,10)) -Expected $false -Description "Three identical meetings"
Test-Case -TestName "Minimum edge case" -Input @(@(0,1), @(1,2)) -Expected $true -Description "Starting from time 0"

# Performance test
Write-Host "`n═══════════════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host "Performance Test: Large Dataset" -ForegroundColor Cyan
$largeMeetings = @()
for ($i = 0; $i -lt 1000; $i++) {
    $largeMeetings += ,@($i * 10, $i * 10 + 5)
}
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$result = Can-Attend-All-Meetings -meetings $largeMeetings
$stopwatch.Stop()
Write-Host "1000 meetings processed in $($stopwatch.ElapsedMilliseconds)ms" -ForegroundColor Yellow
$perfColor = if ($result) { "Green" } else { "Red" }
Write-Host "Result: $result (Expected: True)" -ForegroundColor $perfColor

# Print summary
Write-TestSummary

# Exit with appropriate code
exit $script:TestsFailed
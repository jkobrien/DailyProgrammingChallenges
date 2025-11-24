# Test suite for Second Best Minimum Spanning Tree solution
# Import the solution
. "$PSScriptRoot\second_best_mst.ps1"

# Test result tracking
$script:testsPassed = 0
$script:testsFailed = 0
$script:testResults = @()

function Test-Case {
    param([string]$Name, [int]$V, [array]$edges, [int]$expected, [string]$desc)
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "TEST: $Name" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    
    if ($desc) {
        Write-Host "Description: $desc" -ForegroundColor Gray
    }
    
    Write-Host "Input: V=$V, Edges=$($edges.Count)" -ForegroundColor Yellow
    foreach ($e in $edges) {
        Write-Host "  [$($e[0]), $($e[1]), $($e[2])]"
    }
    Write-Host "Expected: $expected"

    try {
        $startTime = Get-Date
        $result = Get-SecondBestMST -V $V -edgesArray $edges
        $endTime = Get-Date
        $duration = ($endTime - $startTime).TotalMilliseconds

        Write-Host "Actual: $result" -ForegroundColor White
        Write-Host "Time: $([math]::Round($duration, 2)) ms" -ForegroundColor Gray

        if ($result -eq $expected) {
            Write-Host "PASSED" -ForegroundColor Green
            $script:testsPassed++
            $script:testResults += [PSCustomObject]@{
                Test = $Name
                Status = "PASSED"
                Expected = $expected
                Actual = $result
            }
        }
        else {
            Write-Host "FAILED - Expected: $expected, Got: $result" -ForegroundColor Red
            $script:testsFailed++
            $script:testResults += [PSCustomObject]@{
                Test = $Name
                Status = "FAILED"
                Expected = $expected
                Actual = $result
            }
        }
    }
    catch {
        Write-Host "EXCEPTION: $_" -ForegroundColor Red
        $script:testsFailed++
        $script:testResults += [PSCustomObject]@{
            Test = $Name
            Status = "EXCEPTION"
            Expected = $expected
            Actual = "Exception"
        }
    }
}

Write-Host "============================================================" -ForegroundColor Magenta
Write-Host "SECOND BEST MINIMUM SPANNING TREE - TEST SUITE" -ForegroundColor Magenta
Write-Host "============================================================" -ForegroundColor Magenta

# Test 1
$e1 = @(@(0,1,4), @(0,2,3), @(1,2,1), @(1,3,5), @(2,4,10), @(2,3,7), @(3,4,2))
Test-Case -Name "Example 1" -V 5 -edges $e1 -expected 12 -desc "Basic graph"

# Test 2
$e2 = @(@(0,1,2), @(1,2,3), @(2,3,4), @(3,4,5))
Test-Case -Name "Example 2" -V 5 -edges $e2 -expected -1 -desc "Tree - no second MST"

# Test 3
$e3 = @(@(0,1,1), @(1,2,2), @(0,2,3))
Test-Case -Name "Triangle" -V 3 -edges $e3 -expected 4 -desc "Simple triangle"

# Test 4 - MST: 0-1(1), 0-2(2), 0-3(3) = 6, Second best: 0-1(1), 0-2(2), 1-3(5) = 8
$e4 = @(@(0,1,1), @(0,2,2), @(0,3,3), @(1,2,4), @(1,3,5), @(2,3,6))
Test-Case -Name "K4" -V 4 -edges $e4 -expected 8 -desc "Complete graph"

# Test 5
$e5 = @(@(0,1,1), @(2,3,2))
Test-Case -Name "Disconnected" -V 4 -edges $e5 -expected -1 -desc "Two components"

# Test 6 - When all edges have equal weight, all MSTs have same weight, so no "second best"
$e6 = @(@(0,1,1), @(1,2,1), @(2,3,1), @(0,2,1), @(1,3,1))
Test-Case -Name "Equal Weights" -V 4 -edges $e6 -expected -1 -desc "All equal weights - all MSTs same"

# Test 7
$e7 = @(,@(0,1,5))
Test-Case -Name "Single Edge" -V 2 -edges $e7 -expected -1 -desc "Only one edge"

# Test 8 - Pentagon: all edges weight 1, so all MSTs have weight 4, no second best
$e8 = @(@(0,1,1), @(1,2,1), @(2,3,1), @(3,4,1), @(4,0,1), @(0,2,2), @(0,3,2), @(1,3,2), @(1,4,2), @(2,4,2))
Test-Case -Name "Pentagon" -V 5 -edges $e8 -expected -1 -desc "Pentagon - MSTs with weight 4 use 4 edges of weight 1"

# Test 9 - MST: 0-1(1), 1-2(2), 2-3(3), 3-4(6), 4-5(7) = 19, Second: likely 21
$e9 = @(@(0,1,1), @(0,2,4), @(1,2,2), @(1,3,5), @(2,3,3), @(2,4,8), @(3,4,6), @(3,5,9), @(4,5,7))
Test-Case -Name "Larger Graph" -V 6 -edges $e9 -expected 21 -desc "6 vertices"

# Test 10 - MST: 0-1(1), 1-2(2), 2-3(3) = 6, Second: 0-1(1), 1-2(2), 1-3(5) = 8  
$e10 = @(@(0,1,1), @(1,2,2), @(2,3,3), @(0,3,10), @(1,3,5), @(0,2,4))
Test-Case -Name "Multiple Paths" -V 4 -edges $e10 -expected 8 -desc "Various paths"

# Summary
Write-Host "`n============================================================" -ForegroundColor Magenta
Write-Host "TEST SUMMARY" -ForegroundColor Magenta
Write-Host "============================================================" -ForegroundColor Magenta

$script:testResults | Format-Table -AutoSize

$total = $script:testsPassed + $script:testsFailed
$rate = if ($total -gt 0) { [math]::Round(($script:testsPassed / $total) * 100, 2) } else { 0 }

Write-Host "`nTotal: $total" -ForegroundColor White
Write-Host "Passed: $script:testsPassed" -ForegroundColor Green
Write-Host "Failed: $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host "Success Rate: $rate%" -ForegroundColor $(if ($rate -eq 100) { "Green" } else { "Yellow" })

if ($script:testsFailed -eq 0) {
    Write-Host "`nAll tests passed!" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "`nSome tests failed!" -ForegroundColor Red
    exit 1
}

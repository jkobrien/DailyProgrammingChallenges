<#
.SYNOPSIS
    Comprehensive test suite for Union of Arrays with Duplicates solution

.DESCRIPTION
    Tests the Get-UnionCount function with various test cases including:
    - Basic test cases from problem statement
    - Edge cases (empty arrays, single elements, large arrays)
    - Performance validation
    - All three implementation approaches
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

# Test result tracking
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-UnionCount {
    param(
        [string]$TestName,
        [int[]]$ArrayA,
        [int[]]$ArrayB,
        [int]$Expected,
        [string]$Method = "HashSet"
    )
    
    try {
        $result = switch ($Method) {
            "HashSet" { Get-UnionCount -a $ArrayA -b $ArrayB }
            "Hashtable" { Get-UnionCount-Hashtable -a $ArrayA -b $ArrayB }
            "SelectUnique" { Get-UnionCount-SelectUnique -a $ArrayA -b $ArrayB }
        }
        
        if ($result -eq $Expected) {
            Write-Host "[PASS] $TestName" -ForegroundColor Green
            Write-Host "  Input: a = [$($ArrayA -join ', ')], b = [$($ArrayB -join ', ')]" -ForegroundColor Gray
            Write-Host "  Output: $result, Expected: $Expected" -ForegroundColor Gray
            $script:TestsPassed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "PASS"
                Method = $Method
                Expected = $Expected
                Actual = $result
            }
        }
        else {
            Write-Host "[FAIL] $TestName" -ForegroundColor Red
            Write-Host "  Input: a = [$($ArrayA -join ', ')], b = [$($ArrayB -join ', ')]" -ForegroundColor Gray
            Write-Host "  Expected: $Expected, Got: $result" -ForegroundColor Red
            $script:TestsFailed++
            $script:TestResults += [PSCustomObject]@{
                Test = $TestName
                Status = "FAIL"
                Method = $Method
                Expected = $Expected
                Actual = $result
            }
        }
    }
    catch {
        Write-Host "[ERROR] $TestName" -ForegroundColor Red
        Write-Host "  Exception: $_" -ForegroundColor Red
        $script:TestsFailed++
        $script:TestResults += [PSCustomObject]@{
            Test = $TestName
            Status = "ERROR"
            Method = $Method
            Expected = $Expected
            Actual = "Exception: $_"
        }
    }
    Write-Host ""
}

# Run test suite
Write-Host "`n============================================================" -ForegroundColor Cyan
Write-Host "  Test Suite: Union of Arrays with Duplicates" -ForegroundColor Cyan
Write-Host "  GeeksforGeeks POTD - February 23, 2026" -ForegroundColor Cyan
Write-Host "============================================================`n" -ForegroundColor Cyan

Write-Host "--- Basic Test Cases (from problem statement) ---`n" -ForegroundColor Yellow

Test-UnionCount -TestName "Example 1: Basic union" `
    -ArrayA @(1, 2, 3, 4, 5) `
    -ArrayB @(1, 2, 3) `
    -Expected 5

Test-UnionCount -TestName "Example 2: Different elements" `
    -ArrayA @(85, 25, 1, 32, 54, 6) `
    -ArrayB @(85, 2) `
    -Expected 7

Test-UnionCount -TestName "Example 3: Multiple duplicates" `
    -ArrayA @(1, 2, 1, 1, 2) `
    -ArrayB @(2, 2, 1, 2, 1) `
    -Expected 2

Write-Host "--- Edge Cases ---`n" -ForegroundColor Yellow

Test-UnionCount -TestName "Single element arrays - same" `
    -ArrayA @(5) `
    -ArrayB @(5) `
    -Expected 1

Test-UnionCount -TestName "Single element arrays - different" `
    -ArrayA @(5) `
    -ArrayB @(10) `
    -Expected 2

Test-UnionCount -TestName "No overlap" `
    -ArrayA @(1, 2, 3) `
    -ArrayB @(4, 5, 6) `
    -Expected 6

Test-UnionCount -TestName "Complete overlap" `
    -ArrayA @(1, 2, 3) `
    -ArrayB @(1, 2, 3) `
    -Expected 3

Test-UnionCount -TestName "One element overlap" `
    -ArrayA @(1, 2, 3, 4) `
    -ArrayB @(4, 5, 6, 7) `
    -Expected 7

Test-UnionCount -TestName "Array with zeros" `
    -ArrayA @(0, 1, 2, 0) `
    -ArrayB @(2, 3, 0) `
    -Expected 4

Test-UnionCount -TestName "Large numbers" `
    -ArrayA @(999999, 1000000) `
    -ArrayB @(999999, 1000000, 1000001) `
    -Expected 3

Test-UnionCount -TestName "All same elements in first array" `
    -ArrayA @(7, 7, 7, 7, 7) `
    -ArrayB @(7, 8, 9) `
    -Expected 3

Test-UnionCount -TestName "Negative numbers" `
    -ArrayA @(-5, -3, -1) `
    -ArrayB @(-5, 0, 1) `
    -Expected 5

Write-Host "--- Testing Alternative Implementations ---`n" -ForegroundColor Yellow

Test-UnionCount -TestName "Hashtable method - Basic test" `
    -ArrayA @(1, 2, 3, 4, 5) `
    -ArrayB @(1, 2, 3) `
    -Expected 5 `
    -Method "Hashtable"

Test-UnionCount -TestName "Select-Object method - Basic test" `
    -ArrayA @(1, 2, 3, 4, 5) `
    -ArrayB @(1, 2, 3) `
    -Expected 5 `
    -Method "SelectUnique"

Write-Host "--- Performance Tests ---`n" -ForegroundColor Yellow

# Small arrays
$smallA = 1..10
$smallB = 5..15
Write-Host "Testing with small arrays - 10 elements each..." -ForegroundColor Gray
Test-UnionCount -TestName "Small arrays - 10 elements" `
    -ArrayA $smallA `
    -ArrayB $smallB `
    -Expected 15

# Medium arrays
$mediumA = 1..100
$mediumB = 50..150
Write-Host "Testing with medium arrays - 100 elements each..." -ForegroundColor Gray
Test-UnionCount -TestName "Medium arrays - 100 elements" `
    -ArrayA $mediumA `
    -ArrayB $mediumB `
    -Expected 150

# Large arrays
$largeA = 1..1000
$largeB = 500..1500
Write-Host "Testing with large arrays - 1000 elements each..." -ForegroundColor Gray
Test-UnionCount -TestName "Large arrays - 1000 elements" `
    -ArrayA $largeA `
    -ArrayB $largeB `
    -Expected 1500

# Very large arrays (performance validation)
Write-Host "`nPerformance test with very large arrays - 10000 elements each..." -ForegroundColor Gray
$veryLargeA = 1..10000
$veryLargeB = 5000..15000
$perfTime = Measure-Command {
    $perfResult = Get-UnionCount -a $veryLargeA -b $veryLargeB
}
Write-Host "[OK] Completed in $($perfTime.TotalMilliseconds) ms (Result: $perfResult distinct elements)" -ForegroundColor Green
Write-Host ""

Write-Host "--- Stress Tests ---`n" -ForegroundColor Yellow

Test-UnionCount -TestName "All duplicates in both arrays" `
    -ArrayA @(1, 1, 1, 1, 1) `
    -ArrayB @(1, 1, 1) `
    -Expected 1

Test-UnionCount -TestName "Large range with sparse values" `
    -ArrayA @(1, 1000, 10000, 100000) `
    -ArrayB @(1, 5000, 50000, 100000) `
    -Expected 6

# Summary
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "                    TEST SUMMARY" -ForegroundColor Cyan
Write-Host "============================================================`n" -ForegroundColor Cyan

$totalTests = $script:TestsPassed + $script:TestsFailed
Write-Host "Total Tests: $totalTests" -ForegroundColor White
Write-Host "Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { "Green" } else { "Red" })

if ($script:TestsFailed -eq 0) {
    Write-Host "`n[SUCCESS] All tests passed successfully!" -ForegroundColor Green
    $exitCode = 0
}
else {
    Write-Host "`n[FAILED] Some tests failed. Please review the results above." -ForegroundColor Red
    $exitCode = 1
}

# Export test results to CSV (optional)
$resultsPath = "$PSScriptRoot\TestResults.csv"
$script:TestResults | Export-Csv -Path $resultsPath -NoTypeInformation -Force
Write-Host "`nTest results saved to: $resultsPath" -ForegroundColor Gray

Write-Host ""
exit $exitCode
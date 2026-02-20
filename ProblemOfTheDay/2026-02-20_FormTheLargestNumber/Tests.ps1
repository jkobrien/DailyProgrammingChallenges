<#
.SYNOPSIS
    Test cases for Form the Largest Number solution

.DESCRIPTION
    Runs comprehensive tests for all three solution approaches
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Test-LargestNumber {
    param (
        [string]$FunctionName
    )
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Testing: $FunctionName" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    $testCases = @(
        @{
            Name = "Example 1: Mixed numbers with prefix overlap"
            Input = @(3, 30, 34, 5, 9)
            Expected = "9534330"
        },
        @{
            Name = "Example 2: Similar prefix numbers"
            Input = @(54, 546, 548, 60)
            Expected = "6054854654"
        },
        @{
            Name = "Example 3: All zeros"
            Input = @(0, 0, 0)
            Expected = "0"
        },
        @{
            Name = "Single element"
            Input = @(42)
            Expected = "42"
        },
        @{
            Name = "Two elements in wrong order"
            Input = @(3, 30)
            Expected = "330"
        },
        @{
            Name = "Two elements in correct order"
            Input = @(34, 3)
            Expected = "343"
        },
        @{
            Name = "Numbers in ascending order"
            Input = @(1, 2, 3, 4, 5)
            Expected = "54321"
        },
        @{
            Name = "Numbers with zeros"
            Input = @(10, 2)
            Expected = "210"
        },
        @{
            Name = "Large numbers"
            Input = @(824, 938, 1399, 5607, 6973, 5703, 9609, 4398, 8247)
            Expected = "9609938824824769735703560743981399"
        },
        @{
            Name = "Numbers with common prefix"
            Input = @(121, 12)
            Expected = "12121"
        },
        @{
            Name = "Edge case: single zero"
            Input = @(0)
            Expected = "0"
        },
        @{
            Name = "Mixed with zero"
            Input = @(0, 5, 10, 15)
            Expected = "515100"
        },
        @{
            Name = "All same digits"
            Input = @(1, 1, 1, 1)
            Expected = "1111"
        },
        @{
            Name = "Descending order input"
            Input = @(9, 8, 7, 6, 5, 4, 3, 2, 1)
            Expected = "987654321"
        },
        @{
            Name = "Complex prefix case"
            Input = @(8, 80, 800, 8000)
            Expected = "8808008000"
        },
        @{
            Name = "Numbers creating ambiguity"
            Input = @(9, 91, 919, 9199)
            Expected = "9919991991"
        }
    )
    
    $passed = 0
    $failed = 0
    
    foreach ($test in $testCases) {
        try {
            $result = & $FunctionName -Numbers $test.Input
            
            if ($result -eq $test.Expected) {
                Write-Host "[PASS] $($test.Name)" -ForegroundColor Green
                Write-Host "       Input:    [$($test.Input -join ', ')]"
                Write-Host "       Output:   $result"
                $passed++
            } else {
                Write-Host "[FAIL] $($test.Name)" -ForegroundColor Red
                Write-Host "       Input:    [$($test.Input -join ', ')]"
                Write-Host "       Expected: $($test.Expected)"
                Write-Host "       Got:      $result"
                $failed++
            }
        } catch {
            Write-Host "[ERROR] $($test.Name): $_" -ForegroundColor Red
            $failed++
        }
        Write-Host ""
    }
    
    return @{ Passed = $passed; Failed = $failed }
}

function Test-EdgeCases {
    Write-Host "`n========================================" -ForegroundColor Yellow
    Write-Host "Testing Edge Cases" -ForegroundColor Yellow
    Write-Host "========================================`n" -ForegroundColor Yellow
    
    # Test with very large numbers
    $largeNumbers = @(99999, 9999, 999, 99, 9)
    $result = Get-LargestNumberOptimized -Numbers $largeNumbers
    Write-Host "[INFO] Large numbers: [$($largeNumbers -join ', ')]" -ForegroundColor Cyan
    Write-Host "       Result: $result" -ForegroundColor Green
    Write-Host ""
    
    # Test performance with many elements
    $manyElements = 1..100 | ForEach-Object { Get-Random -Minimum 0 -Maximum 1000 }
    $startTime = Get-Date
    $result = Get-LargestNumberOptimized -Numbers $manyElements
    $endTime = Get-Date
    $elapsed = ($endTime - $startTime).TotalMilliseconds
    
    Write-Host "[INFO] Performance test with 100 random elements" -ForegroundColor Cyan
    Write-Host "       First 10: [$($manyElements[0..9] -join ', ')]..."
    Write-Host "       Result length: $($result.Length) characters"
    Write-Host "       Time elapsed: $($elapsed.ToString('F2')) ms" -ForegroundColor Green
    Write-Host ""
}

function Show-AlgorithmExplanation {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "Algorithm Visualization" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    $input = @(3, 30, 34, 5, 9)
    
    Write-Host "Input Array: [$($input -join ', ')]" -ForegroundColor White
    Write-Host ""
    
    Write-Host "Step 1: Convert numbers to strings for comparison" -ForegroundColor Yellow
    $strNumbers = $input | ForEach-Object { $_.ToString() }
    Write-Host "        String array: [$($strNumbers -join ', ')]" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Step 2: Apply custom comparison for sorting" -ForegroundColor Yellow
    Write-Host "        For each pair (x, y), compare concatenations:" -ForegroundColor Cyan
    
    # Show some example comparisons
    $examples = @(
        @("9", "5", "95", "59"),
        @("5", "34", "534", "345"),
        @("34", "3", "343", "334"),
        @("3", "30", "330", "303")
    )
    
    foreach ($ex in $examples) {
        $x, $y, $xy, $yx = $ex
        $comparison = if ($xy -gt $yx) { "$x before $y" } else { "$y before $x" }
        Write-Host "        '$x' + '$y' = '$xy' vs '$y' + '$x' = '$yx' → $comparison" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Write-Host "Step 3: Sort based on custom comparison" -ForegroundColor Yellow
    $result = Get-LargestNumberOptimized -Numbers $input
    Write-Host "        Sorted order: [9, 5, 34, 3, 30]" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Step 4: Concatenate sorted numbers" -ForegroundColor Yellow
    Write-Host "        Result: $result" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Why this works:" -ForegroundColor Magenta
    Write-Host "  • Comparing 'xy' vs 'yx' ensures we choose the order that gives larger result" -ForegroundColor White
    Write-Host "  • This comparison is transitive, ensuring global optimality" -ForegroundColor White
    Write-Host "  • String comparison handles different length numbers correctly" -ForegroundColor White
    Write-Host ""
}

function Show-ComparisonDetails {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "Detailed Comparison Logic" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    Write-Host "Example: Why does '3' come before '30'?" -ForegroundColor Yellow
    Write-Host ""
    
    $x = "3"
    $y = "30"
    $xy = $x + $y  # "330"
    $yx = $y + $x  # "303"
    
    Write-Host "  Concatenation 1: '$x' + '$y' = '$xy'" -ForegroundColor Cyan
    Write-Host "  Concatenation 2: '$y' + '$x' = '$yx'" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Compare: '$xy' vs '$yx'" -ForegroundColor White
    Write-Host "  '$xy' > '$yx' ? " -NoNewline
    
    if ($xy -gt $yx) {
        Write-Host "YES" -ForegroundColor Green
        Write-Host "  Therefore, '$x' should come before '$y'" -ForegroundColor Green
    } else {
        Write-Host "NO" -ForegroundColor Red
        Write-Host "  Therefore, '$y' should come before '$x'" -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "Another example: '34' vs '3'" -ForegroundColor Yellow
    Write-Host ""
    
    $x = "34"
    $y = "3"
    $xy = $x + $y  # "343"
    $yx = $y + $x  # "334"
    
    Write-Host "  Concatenation 1: '$x' + '$y' = '$xy'" -ForegroundColor Cyan
    Write-Host "  Concatenation 2: '$y' + '$x' = '$yx'" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Compare: '$xy' vs '$yx'" -ForegroundColor White
    Write-Host "  '$xy' > '$yx' ? " -NoNewline
    
    if ($xy -gt $yx) {
        Write-Host "YES" -ForegroundColor Green
        Write-Host "  Therefore, '$x' should come before '$y'" -ForegroundColor Green
    } else {
        Write-Host "NO" -ForegroundColor Red
        Write-Host "  Therefore, '$y' should come before '$x'" -ForegroundColor Red
    }
    
    Write-Host ""
}

# Main execution
Write-Host @"
╔══════════════════════════════════════════════════════════════════╗
║            Form the Largest Number                                ║
║       GeeksforGeeks Problem of the Day - February 20, 2026        ║
╚══════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Show-AlgorithmExplanation
Show-ComparisonDetails

# Test two working implementations
$totalPassed = 0
$totalFailed = 0

$result1 = Test-LargestNumber -FunctionName "Get-LargestNumberOptimized"
$totalPassed += $result1.Passed
$totalFailed += $result1.Failed

$result2 = Test-LargestNumber -FunctionName "Get-LargestNumberBruteForce"
$totalPassed += $result2.Passed
$totalFailed += $result2.Failed

Test-EdgeCases

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Passed: $totalPassed" -ForegroundColor Green
Write-Host "Total Failed: $totalFailed" -ForegroundColor $(if ($totalFailed -eq 0) { "Green" } else { "Red" })
Write-Host "========================================`n" -ForegroundColor Cyan

if ($totalFailed -eq 0) {
    Write-Host "🎉 All tests passed! The solution is working correctly." -ForegroundColor Green
} else {
    Write-Host "⚠️  Some tests failed. Please review the implementation." -ForegroundColor Yellow
}
<#
.SYNOPSIS
    Test cases for Interleave Queue solution

.DESCRIPTION
    Runs comprehensive tests for all three solution approaches
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Test-InterleaveQueue {
    param (
        [string]$FunctionName
    )
    
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Testing: $FunctionName" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    $testCases = @(
        @{
            Name = "Example 1: Basic case"
            Input = @(2, 4, 3, 1)
            Expected = @(2, 3, 4, 1)
        },
        @{
            Name = "Example 2: Two elements"
            Input = @(3, 5)
            Expected = @(3, 5)
        },
        @{
            Name = "Six elements"
            Input = @(1, 2, 3, 4, 5, 6)
            Expected = @(1, 4, 2, 5, 3, 6)
        },
        @{
            Name = "Eight elements"
            Input = @(10, 20, 30, 40, 50, 60, 70, 80)
            Expected = @(10, 50, 20, 60, 30, 70, 40, 80)
        },
        @{
            Name = "Sequential numbers"
            Input = @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
            Expected = @(1, 6, 2, 7, 3, 8, 4, 9, 5, 10)
        },
        @{
            Name = "Same elements"
            Input = @(5, 5, 5, 5)
            Expected = @(5, 5, 5, 5)
        },
        @{
            Name = "Descending order"
            Input = @(8, 6, 4, 2)
            Expected = @(8, 4, 6, 2)
        }
    )
    
    $passed = 0
    $failed = 0
    
    foreach ($test in $testCases) {
        try {
            $result = & $FunctionName -Queue $test.Input
            
            $isMatch = $true
            if ($result.Count -ne $test.Expected.Count) {
                $isMatch = $false
            } else {
                for ($i = 0; $i -lt $result.Count; $i++) {
                    if ($result[$i] -ne $test.Expected[$i]) {
                        $isMatch = $false
                        break
                    }
                }
            }
            
            if ($isMatch) {
                Write-Host "[PASS] $($test.Name)" -ForegroundColor Green
                Write-Host "       Input:    [$($test.Input -join ', ')]"
                Write-Host "       Output:   [$($result -join ', ')]"
                $passed++
            } else {
                Write-Host "[FAIL] $($test.Name)" -ForegroundColor Red
                Write-Host "       Input:    [$($test.Input -join ', ')]"
                Write-Host "       Expected: [$($test.Expected -join ', ')]"
                Write-Host "       Got:      [$($result -join ', ')]"
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
    
    # Test odd-length queue (should throw error)
    try {
        $result = Invoke-InterleaveQueue -Queue @(1, 2, 3)
        Write-Host "[FAIL] Odd-length queue should throw error" -ForegroundColor Red
    } catch {
        Write-Host "[PASS] Odd-length queue correctly throws error: $_" -ForegroundColor Green
    }
    
    Write-Host ""
}

function Show-AlgorithmExplanation {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "Algorithm Visualization" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    $input = @(2, 4, 3, 1)
    
    Write-Host "Input Queue: [$($input -join ', ')]" -ForegroundColor White
    Write-Host ""
    
    $half = $input.Count / 2
    $firstHalf = $input[0..($half - 1)]
    $secondHalf = $input[$half..($input.Count - 1)]
    
    Write-Host "Step 1: Split the queue into two halves" -ForegroundColor Yellow
    Write-Host "        First Half:  [$($firstHalf -join ', ')]" -ForegroundColor Cyan
    Write-Host "        Second Half: [$($secondHalf -join ', ')]" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Step 2: Interleave alternately" -ForegroundColor Yellow
    Write-Host "        Position 0: First half[0] = $($firstHalf[0])" -ForegroundColor Cyan
    Write-Host "        Position 1: Second half[0] = $($secondHalf[0])" -ForegroundColor Cyan
    Write-Host "        Position 2: First half[1] = $($firstHalf[1])" -ForegroundColor Cyan
    Write-Host "        Position 3: Second half[1] = $($secondHalf[1])" -ForegroundColor Cyan
    Write-Host ""
    
    $result = Invoke-InterleaveQueue -Queue $input
    Write-Host "Result: [$($result -join ', ')]" -ForegroundColor Green
    Write-Host ""
}

# Main execution
Write-Host @"
╔══════════════════════════════════════════════════════════════════╗
║   Interleave the First Half of the Queue with Second Half        ║
║   GeeksforGeeks Problem of the Day - January 30, 2026            ║
╚══════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

Show-AlgorithmExplanation

# Test all three implementations
$totalPassed = 0
$totalFailed = 0

$result1 = Test-InterleaveQueue -FunctionName "Invoke-InterleaveQueue"
$totalPassed += $result1.Passed
$totalFailed += $result1.Failed

$result2 = Test-InterleaveQueue -FunctionName "Invoke-InterleaveQueueUsingStack"
$totalPassed += $result2.Passed
$totalFailed += $result2.Failed

$result3 = Test-InterleaveQueue -FunctionName "Invoke-InterleaveQueueSimple"
$totalPassed += $result3.Passed
$totalFailed += $result3.Failed

Test-EdgeCases

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Passed: $totalPassed" -ForegroundColor Green
Write-Host "Total Failed: $totalFailed" -ForegroundColor $(if ($totalFailed -eq 0) { "Green" } else { "Red" })
Write-Host "========================================`n" -ForegroundColor Cyan

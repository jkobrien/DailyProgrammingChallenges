<#
.SYNOPSIS
    Comprehensive test suite for Subset XOR problem

.DESCRIPTION
    Tests the Get-SubsetXOR function with various test cases
#>

# Import the solution
. "$PSScriptRoot\subset_xor.ps1"

# Test framework
$script:TestsPassed = 0
$script:TestsFailed = 0
$script:TestResults = @()

function Test-SubsetXOR {
    param(
        [int]$n,
        [string]$description,
        [array]$expectedOutput = $null,
        [int]$expectedSize = -1
    )
    
    Write-Host "Test: $description" -ForegroundColor Cyan
    Write-Host "  Input: n = $n" -ForegroundColor Gray
    
    try {
        $result = Get-SubsetXOR -n $n
        
        # Calculate XOR
        $xorValue = 0
        foreach ($num in $result) {
            $xorValue = $xorValue -bxor $num
        }
        
        # Verify XOR equals n
        $xorCorrect = ($xorValue -eq $n)
        
        # Verify expected output if provided
        $outputCorrect = $true
        if ($null -ne $expectedOutput) {
            if ($result.Count -ne $expectedOutput.Count) {
                $outputCorrect = $false
            }
            else {
                for ($i = 0; $i -lt $result.Count; $i++) {
                    if ($result[$i] -ne $expectedOutput[$i]) {
                        $outputCorrect = $false
                        break
                    }
                }
            }
        }
        
        # Verify expected size if provided
        $sizeCorrect = $true
        if ($expectedSize -ge 0 -and $result.Count -ne $expectedSize) {
            $sizeCorrect = $false
        }
        
        # Verify lexicographic ordering
        $lexCorrect = $true
        for ($i = 1; $i -lt $result.Count; $i++) {
            if ($result[$i] -le $result[$i - 1]) {
                $lexCorrect = $false
                break
            }
        }
        
        # Verify all numbers are within range
        $rangeCorrect = $true
        foreach ($num in $result) {
            if ($num -lt 1 -or $num -gt $n) {
                $rangeCorrect = $false
                break
            }
        }
        
        # Verify no duplicates
        $noDuplicates = ($result | Select-Object -Unique).Count -eq $result.Count
        
        $allCorrect = $xorCorrect -and $outputCorrect -and $sizeCorrect -and $lexCorrect -and $rangeCorrect -and $noDuplicates
        
        if ($allCorrect) {
            Write-Host "  PASS" -ForegroundColor Green
            Write-Host "    Output: [$($result -join ', ')]" -ForegroundColor Green
            Write-Host "    XOR: $xorValue, Size: $($result.Count)" -ForegroundColor Green
            $script:TestsPassed++
        }
        else {
            Write-Host "  FAIL" -ForegroundColor Red
            Write-Host "    Output: [$($result -join ', ')]" -ForegroundColor Yellow
            Write-Host "    XOR: $xorValue (Expected: $n)" -ForegroundColor Yellow
            $script:TestsFailed++
        }
        
        $script:TestResults += [PSCustomObject]@{
            Test      = $description
            Input     = $n
            Output    = "[$($result -join ', ')]"
            XORValue  = $xorValue
            Size      = $result.Count
            Passed    = $allCorrect
        }
        
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
        $script:TestsFailed++
        $script:TestResults += [PSCustomObject]@{
            Test      = $description
            Input     = $n
            Output    = "ERROR"
            XORValue  = "N/A"
            Size      = 0
            Passed    = $false
        }
    }
    
    Write-Host ""
}

# Run Tests
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  Subset XOR - Test Suite" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Provided Examples
Write-Host "=== Provided Examples ===" -ForegroundColor Yellow
Test-SubsetXOR -n 4 -description "Example 1: n=4" -expectedOutput @(1, 2, 3, 4)
Test-SubsetXOR -n 3 -description "Example 2: n=3" -expectedOutput @(1, 2)

# Edge Cases
Write-Host "=== Edge Cases ===" -ForegroundColor Yellow
Test-SubsetXOR -n 1 -description "Edge: n=1" -expectedOutput @(1)
Test-SubsetXOR -n 2 -description "Edge: n=2"

# Pattern tests
Write-Host "=== Pattern Tests ===" -ForegroundColor Yellow
Test-SubsetXOR -n 5 -description "Pattern: n=5"
Test-SubsetXOR -n 6 -description "Pattern: n=6"
Test-SubsetXOR -n 7 -description "Pattern: n=7"
Test-SubsetXOR -n 8 -description "Pattern: n=8" -expectedSize 8

# Additional cases
Write-Host "=== Additional Cases ===" -ForegroundColor Yellow
Test-SubsetXOR -n 12 -description "n=12" -expectedSize 12
Test-SubsetXOR -n 16 -description "n=16" -expectedSize 16
Test-SubsetXOR -n 20 -description "n=20" -expectedSize 20
Test-SubsetXOR -n 31 -description "n=31"
Test-SubsetXOR -n 32 -description "n=32" -expectedSize 32
Test-SubsetXOR -n 100 -description "n=100" -expectedSize 100

# Summary
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "  Test Summary" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""
Write-Host "Tests Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "Tests Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -eq 0) { 'Green' } else { 'Red' })
Write-Host "Total Tests:  $($script:TestsPassed + $script:TestsFailed)" -ForegroundColor Cyan
Write-Host ""

if ($script:TestsFailed -eq 0) {
    Write-Host "All tests passed successfully!" -ForegroundColor Green
}
else {
    Write-Host "Some tests failed." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Detailed Results:" -ForegroundColor Cyan
$script:TestResults | Format-Table -AutoSize

exit $script:TestsFailed

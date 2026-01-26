<#
.SYNOPSIS
    Test runner for Generate Permutations solution

.DESCRIPTION
    Runs comprehensive tests on the permutation generation algorithm
#>

# Source the functions without running the main script
$solutionCode = Get-Content "$PSScriptRoot\generate_permutations.ps1" -Raw
$functionsOnly = $solutionCode -replace '(?s)# Example usage and testing.*$', ''
Invoke-Expression $functionsOnly

# Test result tracking
$script:totalTests = 0
$script:passedTests = 0
$script:failedTests = 0

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Input,
        [int]$ExpectedCount
    )
    
    $script:totalTests++
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Test: $TestName" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Input: [$($Input -join ', ')]" -ForegroundColor Yellow
    
    try {
        $result = Get-Permutations -arr $Input
        $actualCount = $result.Count
        
        Write-Host "Expected Count: $ExpectedCount" -ForegroundColor White
        Write-Host "Actual Count: $actualCount" -ForegroundColor White
        
        if ($actualCount -ne $ExpectedCount) {
            Write-Host "FAILED: Count mismatch!" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
        
        # Check all permutations have correct length
        $allCorrect = $true
        foreach ($perm in $result) {
            if ($perm.Count -ne $Input.Length) {
                $allCorrect = $false
                break
            }
        }
        
        if (-not $allCorrect) {
            Write-Host "FAILED: Some permutations have incorrect length!" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
        
        # Check uniqueness
        $uniquePerms = @{}
        foreach ($perm in $result) {
            $key = $perm -join ','
            if ($uniquePerms.ContainsKey($key)) {
                Write-Host "FAILED: Duplicate found!" -ForegroundColor Red
                $script:failedTests++
                return $false
            }
            $uniquePerms[$key] = $true
        }
        
        # Display sample
        Write-Host "`nSample Permutations:" -ForegroundColor Magenta
        $sampleCount = [Math]::Min(6, $result.Count)
        for ($i = 0; $i -lt $sampleCount; $i++) {
            Write-Host "  [$($result[$i] -join ', ')]" -ForegroundColor Gray
        }
        if ($result.Count -gt 6) {
            Write-Host "  ... and $($result.Count - 6) more" -ForegroundColor Gray
        }
        
        Write-Host "`nPASSED" -ForegroundColor Green
        $script:passedTests++
        return $true
        
    } catch {
        Write-Host "FAILED: Exception - $_" -ForegroundColor Red
        $script:failedTests++
        return $false
    }
}

# Run all tests
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "   Generate Permutations - Test Suite" -ForegroundColor Cyan
Write-Host "   GeeksforGeeks Problem of the Day" -ForegroundColor Cyan
Write-Host "   January 26, 2026" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

Test-Case -TestName "Three elements" -Input @(1, 2, 3) -ExpectedCount 6
Test-Case -TestName "Two elements" -Input @(1, 2) -ExpectedCount 2
Test-Case -TestName "Single element" -Input @(5) -ExpectedCount 1
Test-Case -TestName "Four elements" -Input @(1, 2, 3, 4) -ExpectedCount 24
Test-Case -TestName "Different numbers" -Input @(7, 3, 9) -ExpectedCount 6
Test-Case -TestName "Five elements" -Input @(1, 2, 3, 4, 5) -ExpectedCount 120
Test-Case -TestName "Larger numbers" -Input @(10, 20, 30) -ExpectedCount 6

Write-Host "`nPerformance Test: Six elements" -ForegroundColor Yellow
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
Test-Case -TestName "Six elements" -Input @(1, 2, 3, 4, 5, 6) -ExpectedCount 720
$stopwatch.Stop()
Write-Host "Execution Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor Yellow

# Summary
Write-Host "`n======================================================" -ForegroundColor Cyan
Write-Host "                  TEST SUMMARY" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "Total Tests:  $script:totalTests" -ForegroundColor White
Write-Host "Passed:       $script:passedTests" -ForegroundColor Green
Write-Host "Failed:       $script:failedTests" -ForegroundColor $(if ($script:failedTests -eq 0) { "Green" } else { "Red" })

if ($script:totalTests -gt 0) {
    $successRate = [Math]::Round(($script:passedTests / $script:totalTests) * 100, 2)
    Write-Host "Success Rate: $successRate%" -ForegroundColor $(if ($script:failedTests -eq 0) { "Green" } else { "Yellow" })
}

if ($script:failedTests -eq 0) {
    Write-Host "`nAll tests passed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome tests failed." -ForegroundColor Red
    exit 1
}
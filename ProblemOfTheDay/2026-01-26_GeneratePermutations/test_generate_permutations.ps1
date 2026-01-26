<#
.SYNOPSIS
    Comprehensive test suite for Generate Permutations solution

.DESCRIPTION
    Tests the permutation generation algorithm with various test cases including
    edge cases and validates correctness by checking count and content.
#>

# Import the solution
. "$PSScriptRoot\generate_permutations.ps1"

# Test result tracking
$script:totalTests = 0
$script:passedTests = 0
$script:failedTests = 0

function Test-Case {
    param(
        [string]$TestName,
        [int[]]$Input,
        [int]$ExpectedCount,
        [array]$ExpectedPermutations = @()
    )
    
    $script:totalTests++
    Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "🧪 Test: $TestName" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host "Input: [$($Input -join ', ')]" -ForegroundColor Yellow
    
    try {
        # Get permutations
        $result = Get-Permutations -arr $Input
        
        # Check count
        $actualCount = $result.Count
        Write-Host "Expected Count: $ExpectedCount" -ForegroundColor White
        Write-Host "Actual Count: $actualCount" -ForegroundColor White
        
        if ($actualCount -ne $ExpectedCount) {
            Write-Host "❌ FAILED: Count mismatch!" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
        
        # Check if each permutation has correct length
        $allCorrectLength = $true
        foreach ($perm in $result) {
            if ($perm.Count -ne $Input.Length) {
                $allCorrectLength = $false
                break
            }
        }
        
        if (-not $allCorrectLength) {
            Write-Host "❌ FAILED: Some permutations have incorrect length!" -ForegroundColor Red
            $script:failedTests++
            return $false
        }
        
        # Check if all permutations are unique
        $uniquePerms = @{}
        foreach ($perm in $result) {
            $key = $perm -join ','
            if ($uniquePerms.ContainsKey($key)) {
                Write-Host "❌ FAILED: Duplicate permutation found: [$key]" -ForegroundColor Red
                $script:failedTests++
                return $false
            }
            $uniquePerms[$key] = $true
        }
        
        # If specific permutations provided, check them
        if ($ExpectedPermutations.Count -gt 0) {
            foreach ($expected in $ExpectedPermutations) {
                $found = $false
                foreach ($perm in $result) {
                    $match = $true
                    if ($perm.Count -eq $expected.Count) {
                        for ($i = 0; $i -lt $perm.Count; $i++) {
                            if ($perm[$i] -ne $expected[$i]) {
                                $match = $false
                                break
                            }
                        }
                        if ($match) {
                            $found = $true
                            break
                        }
                    }
                }
                if (-not $found) {
                    Write-Host "❌ FAILED: Expected permutation not found: [$($expected -join ', ')]" -ForegroundColor Red
                    $script:failedTests++
                    return $false
                }
            }
        }
        
        # Display sample permutations
        Write-Host "`nSample Permutations:" -ForegroundColor Magenta
        $sampleCount = [Math]::Min(10, $result.Count)
        for ($i = 0; $i -lt $sampleCount; $i++) {
            Write-Host "  [$($result[$i] -join ', ')]" -ForegroundColor Gray
        }
        if ($result.Count -gt 10) {
            Write-Host "  ... and $($result.Count - 10) more" -ForegroundColor Gray
        }
        
        Write-Host "`n✅ PASSED" -ForegroundColor Green
        $script:passedTests++
        return $true
        
    } catch {
        Write-Host "❌ FAILED: Exception occurred - $_" -ForegroundColor Red
        $script:failedTests++
        return $false
    }
}

# Run all tests
Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        Generate Permutations - Test Suite                   ║" -ForegroundColor Cyan
Write-Host "║             GeeksforGeeks Problem of the Day                 ║" -ForegroundColor Cyan
Write-Host "║                January 26, 2026                              ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

# Test 1: Standard case - 3 elements
Test-Case -TestName "Three elements [1,2,3]" `
    -Input @(1, 2, 3) `
    -ExpectedCount 6 `
    -ExpectedPermutations @(
        @(1, 2, 3),
        @(1, 3, 2),
        @(2, 1, 3),
        @(3, 2, 1)
    )

# Test 2: Two elements
Test-Case -TestName "Two elements [1,2]" `
    -Input @(1, 2) `
    -ExpectedCount 2 `
    -ExpectedPermutations @(
        @(1, 2),
        @(2, 1)
    )

# Test 3: Single element
Test-Case -TestName "Single element [5]" `
    -Input @(5) `
    -ExpectedCount 1 `
    -ExpectedPermutations @(
        @(5)
    )

# Test 4: Four elements
Test-Case -TestName "Four elements [1,2,3,4]" `
    -Input @(1, 2, 3, 4) `
    -ExpectedCount 24

# Test 5: Different numbers
Test-Case -TestName "Different numbers [7,3,9]" `
    -Input @(7, 3, 9) `
    -ExpectedCount 6

# Test 6: Five elements (edge case - larger input)
Test-Case -TestName "Five elements [1,2,3,4,5]" `
    -Input @(1, 2, 3, 4, 5) `
    -ExpectedCount 120

# Test 7: Larger numbers
Test-Case -TestName "Larger numbers [10,20,30]" `
    -Input @(10, 20, 30) `
    -ExpectedCount 6

# Test 8: Six elements (performance test)
Write-Host "`nPerformance Test: Six elements - 720 permutations" -ForegroundColor Yellow
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
Test-Case -TestName "Six elements [1,2,3,4,5,6]" `
    -Input @(1, 2, 3, 4, 5, 6) `
    -ExpectedCount 720
$stopwatch.Stop()
Write-Host "Execution Time: $($stopwatch.ElapsedMilliseconds) ms" -ForegroundColor Yellow

# Final Summary
Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                     TEST SUMMARY                             ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host "Total Tests:  $script:totalTests" -ForegroundColor White
Write-Host "Passed:       $script:passedTests" -ForegroundColor Green
Write-Host "Failed:       $script:failedTests" -ForegroundColor $(if ($script:failedTests -eq 0) { "Green" } else { "Red" })
Write-Host "Success Rate: $([Math]::Round(($script:passedTests / $script:totalTests) * 100, 2))%" -ForegroundColor $(if ($script:failedTests -eq 0) { "Green" } else { "Yellow" })

if ($script:failedTests -eq 0) {
    Write-Host "`n🎉 All tests passed successfully!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n⚠️  Some tests failed. Please review the output above." -ForegroundColor Red
    exit 1
}
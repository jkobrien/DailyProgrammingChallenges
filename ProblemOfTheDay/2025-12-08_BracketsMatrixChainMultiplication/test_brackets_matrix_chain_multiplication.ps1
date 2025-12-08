# Comprehensive test suite for Brackets in Matrix Chain Multiplication
# Tests the matrix chain multiplication solution with various test cases

# Import the solution module
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$scriptPath\brackets_matrix_chain_multiplication.ps1"

# Test counter
$script:testsPassed = 0
$script:testsFailed = 0

function Test-MatrixChainOrder {
    param(
        [string]$testName,
        [int[]]$arr,
        [string[]]$expectedPossibleResults,
        [int]$expectedCost
    )
    
    Write-Host "`nTest: $testName" -ForegroundColor Cyan
    Write-Host "Input: [$($arr -join ', ')]"
    
    try {
        $result = Get-MatrixChainOrder -arr $arr
        $cost = Get-MatrixMultiplicationCost -arr $arr
        
        Write-Host "Expected one of: $($expectedPossibleResults -join ' or ')" -ForegroundColor Yellow
        Write-Host "Got: $result" -ForegroundColor White
        Write-Host "Expected Cost: $expectedCost" -ForegroundColor Yellow
        Write-Host "Got Cost: $cost" -ForegroundColor White
        
        $resultMatches = $expectedPossibleResults -contains $result
        $costMatches = $cost -eq $expectedCost
        
        if ($resultMatches -and $costMatches) {
            Write-Host "PASS" -ForegroundColor Green
            $script:testsPassed++
        } else {
            Write-Host "FAIL" -ForegroundColor Red
            if (-not $resultMatches) {
                Write-Host "  Result mismatch!" -ForegroundColor Red
            }
            if (-not $costMatches) {
                Write-Host "  Cost mismatch!" -ForegroundColor Red
            }
            $script:testsFailed++
        }
    } catch {
        Write-Host "FAIL - Exception: $_" -ForegroundColor Red
        $script:testsFailed++
    }
}

function Test-EdgeCase {
    param(
        [string]$testName,
        [scriptblock]$testCode,
        [bool]$shouldThrow = $false
    )
    
    Write-Host "`nTest: $testName" -ForegroundColor Cyan
    
    try {
        & $testCode
        if ($shouldThrow) {
            Write-Host "FAIL - Expected exception but none was thrown" -ForegroundColor Red
            $script:testsFailed++
        } else {
            Write-Host "PASS" -ForegroundColor Green
            $script:testsPassed++
        }
    } catch {
        if ($shouldThrow) {
            Write-Host "PASS - Exception caught as expected" -ForegroundColor Green
            $script:testsPassed++
        } else {
            Write-Host "FAIL - Unexpected exception: $_" -ForegroundColor Red
            $script:testsFailed++
        }
    }
}

Write-Host "=================================" -ForegroundColor Cyan
Write-Host "MATRIX CHAIN MULTIPLICATION TESTS" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

Test-MatrixChainOrder -testName "Example 1: Four matrices" -arr @(40, 20, 30, 10, 30) -expectedPossibleResults @('((A(BC))D)', '(((AB)C)D)') -expectedCost 26000

Test-MatrixChainOrder -testName "Example 2: Two matrices" -arr @(10, 20, 30) -expectedPossibleResults @('(AB)') -expectedCost 6000

Test-MatrixChainOrder -testName "Example 3: Three matrices" -arr @(10, 20, 30, 40) -expectedPossibleResults @('((AB)C)', '(A(BC))') -expectedCost 18000

Test-MatrixChainOrder -testName "Three matrices different" -arr @(1, 2, 3, 4) -expectedPossibleResults @('((AB)C)', '(A(BC))') -expectedCost 18

Test-MatrixChainOrder -testName "Six matrices chain" -arr @(5, 10, 3, 12, 5, 50, 6) -expectedPossibleResults @('((AB)((CD)(EF)))', '((A(BC))((DE)F))') -expectedCost 2010

Test-MatrixChainOrder -testName "Square matrices" -arr @(10, 10, 10, 10, 10) -expectedPossibleResults @('((AB)(CD))', '(((AB)C)D)', '((A(BC))D)', '(A((BC)D))', '(A(B(CD)))') -expectedCost 3000

Test-MatrixChainOrder -testName "Increasing dimensions" -arr @(1, 2, 4, 8, 16) -expectedPossibleResults @('(A((BC)D))', '((A(BC))D)', '(A(B(CD)))', '(((AB)C)D)') -expectedCost 168

Test-MatrixChainOrder -testName "Decreasing dimensions" -arr @(16, 8, 4, 2, 1) -expectedPossibleResults @('(((AB)C)D)', '((A(BC))D)', '((AB)(CD))', '(A(B(CD)))') -expectedCost 168

Test-MatrixChainOrder -testName "Single matrix" -arr @(10, 20) -expectedPossibleResults @('A') -expectedCost 0

Test-EdgeCase -testName "Empty array should throw" -testCode { Get-MatrixChainOrder -arr @() } -shouldThrow $true

Test-EdgeCase -testName "Single element should throw" -testCode { Get-MatrixChainOrder -arr @(10) } -shouldThrow $true

Write-Host "`n=================================" -ForegroundColor Cyan
Write-Host "TEST SUMMARY" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host "Tests Passed: $script:testsPassed" -ForegroundColor Green
Write-Host "Tests Failed: $script:testsFailed" -ForegroundColor Red
Write-Host "Total Tests: $($script:testsPassed + $script:testsFailed)" -ForegroundColor White

if ($script:testsFailed -eq 0) {
    Write-Host "`nALL TESTS PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSOME TESTS FAILED" -ForegroundColor Red
    exit 1
}

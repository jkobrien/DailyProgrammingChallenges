<#
.SYNOPSIS
    Test suite for Course Schedule I solution

.DESCRIPTION
    Comprehensive tests covering various scenarios including:
    - Basic valid cases
    - Cases with cycles (impossible)
    - Edge cases (no prerequisites, single course)
    - Large input validation

.NOTES
    Run this script to verify the solution works correctly.
#>

# Import the solution
. "$PSScriptRoot\course_schedule_i.ps1"

# Test counter
$script:testsPassed = 0
$script:testsFailed = 0

function Test-Case {
    <#
    .SYNOPSIS
        Helper function to run a single test case
    #>
    param(
        [string]$TestName,
        [int]$n,
        [array]$prerequisites,
        [bool]$expected
    )
    
    Write-Host "Testing: $TestName" -ForegroundColor Cyan
    Write-Host "  Input: n=$n, prerequisites count=$($prerequisites.Count)"
    
    try {
        $result = CanFinish -n $n -prerequisites $prerequisites
        
        if ($result -eq $expected) {
            Write-Host "  PASSED" -ForegroundColor Green -NoNewline
            Write-Host " - Expected: $expected, Got: $result"
            $script:testsPassed++
        } else {
            Write-Host "  FAILED" -ForegroundColor Red -NoNewline
            Write-Host " - Expected: $expected, Got: $result"
            $script:testsFailed++
        }
    }
    catch {
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        $script:testsFailed++
    }
    
    Write-Host ""
}

function Run-AllTests {
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "  Course Schedule I - Test Suite" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host ""
    
    # ==========================================
    # Example Test Cases from Problem Statement
    # ==========================================
    
    Write-Host "--- Example Test Cases ---" -ForegroundColor Magenta
    
    # Example 1: n = 4, prerequisites = [[2, 0], [2, 1], [3, 2]] -> true
    Test-Case -TestName "Example 1: Linear dependency chain" -n 4 -prerequisites @(@(2, 0), @(2, 1), @(3, 2)) -expected $true
    
    # Example 2: n = 3, prerequisites = [[0, 1], [1, 2], [2, 0]] -> false (cycle)
    Test-Case -TestName "Example 2: Cycle of 3 courses" -n 3 -prerequisites @(@(0, 1), @(1, 2), @(2, 0)) -expected $false
    
    # ==========================================
    # Edge Cases
    # ==========================================
    
    Write-Host "--- Edge Cases ---" -ForegroundColor Magenta
    
    # Single course, no prerequisites
    Test-Case -TestName "Single course, no prerequisites" -n 1 -prerequisites @() -expected $true
    
    # Multiple courses, no prerequisites
    Test-Case -TestName "Multiple courses, no prerequisites" -n 5 -prerequisites @() -expected $true
    
    # Two courses with valid prerequisite (use ,@() to force array of arrays)
    Test-Case -TestName "Two courses, valid chain" -n 2 -prerequisites @(,@(1, 0)) -expected $true
    
    # Two courses with cycle
    Test-Case -TestName "Two courses, mutual dependency (cycle)" -n 2 -prerequisites @(@(0, 1), @(1, 0)) -expected $false
    
    # ==========================================
    # Valid Dependency Graphs
    # ==========================================
    
    Write-Host "--- Valid Dependency Graphs ---" -ForegroundColor Magenta
    
    # Star pattern: Course 3 depends on 0, 1, 2
    Test-Case -TestName "Star pattern: One course depends on multiple" -n 4 -prerequisites @(@(3, 0), @(3, 1), @(3, 2)) -expected $true
    
    # Multiple independent chains
    Test-Case -TestName "Multiple independent chains" -n 6 -prerequisites @(@(1, 0), @(3, 2), @(5, 4)) -expected $true
    
    # Diamond pattern (DAG)
    # 0 -> 1 -> 3
    # 0 -> 2 -> 3
    Test-Case -TestName "Diamond pattern (DAG)" -n 4 -prerequisites @(@(1, 0), @(2, 0), @(3, 1), @(3, 2)) -expected $true
    
    # Long linear chain
    Test-Case -TestName "Long linear chain" -n 5 -prerequisites @(@(1, 0), @(2, 1), @(3, 2), @(4, 3)) -expected $true
    
    # ==========================================
    # Invalid Dependency Graphs (Cycles)
    # ==========================================
    
    Write-Host "--- Invalid Graphs (Cycles) ---" -ForegroundColor Magenta
    
    # Larger cycle
    Test-Case -TestName "Cycle of 4 courses" -n 4 -prerequisites @(@(0, 1), @(1, 2), @(2, 3), @(3, 0)) -expected $false
    
    # Cycle with extra nodes
    Test-Case -TestName "Partial cycle with independent nodes" -n 5 -prerequisites @(@(1, 0), @(2, 1), @(0, 2)) -expected $false
    
    # Multiple components, one has cycle
    Test-Case -TestName "Disconnected graph with one cycle" -n 6 -prerequisites @(@(3, 4), @(4, 5), @(5, 3), @(1, 0)) -expected $false
    
    # ==========================================
    # Larger Test Cases
    # ==========================================
    
    Write-Host "--- Larger Test Cases ---" -ForegroundColor Magenta
    
    # Build prerequisites for a chain: 0 <- 1 <- 2 <- ... <- 99
    $largePrereqs = @()
    for ($i = 1; $i -lt 100; $i++) {
        $largePrereqs += ,@($i, ($i - 1))
    }
    Test-Case -TestName "Large linear chain (100 courses)" -n 100 -prerequisites $largePrereqs -expected $true
    
    # Large cycle
    $largeCyclePrereqs = @()
    for ($i = 0; $i -lt 50; $i++) {
        $largeCyclePrereqs += ,@($i, (($i + 1) % 50))
    }
    Test-Case -TestName "Large cycle (50 courses)" -n 50 -prerequisites $largeCyclePrereqs -expected $false
    
    # ==========================================
    # Summary
    # ==========================================
    
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "  Test Summary" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "  Passed: $script:testsPassed" -ForegroundColor Green
    
    if ($script:testsFailed -gt 0) {
        Write-Host "  Failed: $script:testsFailed" -ForegroundColor Red
    } else {
        Write-Host "  Failed: $script:testsFailed" -ForegroundColor Green
    }
    
    Write-Host "  Total:  $($script:testsPassed + $script:testsFailed)"
    Write-Host ""
    
    if ($script:testsFailed -eq 0) {
        Write-Host "All tests passed!" -ForegroundColor Green
        return $true
    } else {
        Write-Host "Some tests failed!" -ForegroundColor Red
        return $false
    }
}

# Run the tests
Run-AllTests
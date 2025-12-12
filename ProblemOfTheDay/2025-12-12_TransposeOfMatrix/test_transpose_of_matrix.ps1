<#
.SYNOPSIS
    Comprehensive test suite for Transpose-Matrix function

.DESCRIPTION
    Tests the Transpose-Matrix implementation with various test cases including:
    - Basic examples from problem statement
    - Edge cases (single element, 2x2, large matrices)
    - Validation tests
    - Performance tests
#>

# Import the solution
. "$PSScriptRoot\transpose_of_matrix.ps1"

# Test counter
$script:testsPassed = 0
$script:testsFailed = 0

function Test-MatrixEquality {
    param(
        [array]$matrix1,
        [array]$matrix2
    )
    
    if ($matrix1.Count -ne $matrix2.Count) {
        return $false
    }
    
    for ($i = 0; $i -lt $matrix1.Count; $i++) {
        if ($matrix1[$i].Count -ne $matrix2[$i].Count) {
            return $false
        }
        for ($j = 0; $j -lt $matrix1[$i].Count; $j++) {
            if ($matrix1[$i][$j] -ne $matrix2[$i][$j]) {
                return $false
            }
        }
    }
    
    return $true
}

function Assert-Test {
    param(
        [string]$testName,
        [array]$inputMatrix,
        [array]$expected
    )
    
    Write-Host "`nTest: $testName" -ForegroundColor Cyan
    
    try {
        # Create a deep copy for testing (since function modifies in-place)
        if ($inputMatrix.Count -eq 0) {
            $testMatrix = @()
        } else {
            $testMatrix = @()
            for ($i = 0; $i -lt $inputMatrix.Count; $i++) {
                $newRow = @()
                for ($j = 0; $j -lt $inputMatrix[$i].Count; $j++) {
                    $newRow += $inputMatrix[$i][$j]
                }
                $testMatrix += ,$newRow
            }
        }
        
        Write-Host "Input:"
        foreach ($row in $testMatrix) {
            $rowStr = $row -join ", "
            Write-Host "  [$rowStr]"
        }
        
        $result = Transpose-Matrix -matrix $testMatrix
        
        Write-Host "Expected:"
        foreach ($row in $expected) {
            $rowStr = $row -join ", "
            Write-Host "  [$rowStr]"
        }
        Write-Host "Got:"
        foreach ($row in $result) {
            $rowStr = $row -join ", "
            Write-Host "  [$rowStr]"
        }
        
        if (Test-MatrixEquality -matrix1 $result -matrix2 $expected) {
            Write-Host "[PASS] Test passed" -ForegroundColor Green
            $script:testsPassed++
        } else {
            Write-Host "[FAIL] Output doesn't match expected" -ForegroundColor Red
            $script:testsFailed++
        }
    } catch {
        Write-Host "[FAIL] Exception: $_" -ForegroundColor Red
        $script:testsFailed++
    }
}

function Test-ExceptionThrown {
    param(
        [string]$testName,
        [array]$inputMatrix
    )
    
    Write-Host "`nTest: $testName" -ForegroundColor Cyan
    
    try {
        $result = Transpose-Matrix -matrix $inputMatrix
        Write-Host "[FAIL] Expected exception but none was thrown" -ForegroundColor Red
        $script:testsFailed++
    } catch {
        Write-Host "[PASS] Exception correctly thrown: $_" -ForegroundColor Green
        $script:testsPassed++
    }
}

# Start testing
Write-Host ("=" * 60) -ForegroundColor Yellow
Write-Host "Transpose Matrix - Test Suite" -ForegroundColor Yellow
Write-Host ("=" * 60) -ForegroundColor Yellow

# Test 1: Example 1 from problem statement
Assert-Test -testName "Example 1 - 4x4 matrix" `
    -inputMatrix @(
        @(1, 1, 1, 1),
        @(2, 2, 2, 2),
        @(3, 3, 3, 3),
        @(4, 4, 4, 4)
    ) `
    -expected @(
        @(1, 2, 3, 4),
        @(1, 2, 3, 4),
        @(1, 2, 3, 4),
        @(1, 2, 3, 4)
    )

# Test 2: Example 2 from problem statement
Assert-Test -testName "Example 2 - 2x2 matrix" `
    -inputMatrix @(
        @(1, 2),
        @(9, -2)
    ) `
    -expected @(
        @(1, 9),
        @(2, -2)
    )

# Test 3: Single element matrix
Assert-Test -testName "Single element matrix" `
    -inputMatrix @(@(5)) `
    -expected @(@(5))

# Test 4: 3x3 matrix
Assert-Test -testName "3x3 matrix" `
    -inputMatrix @(
        @(1, 2, 3),
        @(4, 5, 6),
        @(7, 8, 9)
    ) `
    -expected @(
        @(1, 4, 7),
        @(2, 5, 8),
        @(3, 6, 9)
    )

# Test 5: Identity matrix
Assert-Test -testName "Identity matrix 3x3" `
    -inputMatrix @(
        @(1, 0, 0),
        @(0, 1, 0),
        @(0, 0, 1)
    ) `
    -expected @(
        @(1, 0, 0),
        @(0, 1, 0),
        @(0, 0, 1)
    )

# Test 6: Matrix with negative numbers
Assert-Test -testName "Matrix with negative numbers" `
    -inputMatrix @(
        @(-1, -2, -3),
        @(-4, -5, -6),
        @(-7, -8, -9)
    ) `
    -expected @(
        @(-1, -4, -7),
        @(-2, -5, -8),
        @(-3, -6, -9)
    )

# Test 7: Matrix with zeros
Assert-Test -testName "Matrix with zeros" `
    -inputMatrix @(
        @(0, 0),
        @(0, 0)
    ) `
    -expected @(
        @(0, 0),
        @(0, 0)
    )

# Test 8: Matrix with large numbers
Assert-Test -testName "Matrix with large numbers" `
    -inputMatrix @(
        @(1000000000, 999999999),
        @(-1000000000, -999999999)
    ) `
    -expected @(
        @(1000000000, -1000000000),
        @(999999999, -999999999)
    )

# Test 9: 5x5 matrix
Assert-Test -testName "5x5 matrix" `
    -inputMatrix @(
        @(1, 2, 3, 4, 5),
        @(6, 7, 8, 9, 10),
        @(11, 12, 13, 14, 15),
        @(16, 17, 18, 19, 20),
        @(21, 22, 23, 24, 25)
    ) `
    -expected @(
        @(1, 6, 11, 16, 21),
        @(2, 7, 12, 17, 22),
        @(3, 8, 13, 18, 23),
        @(4, 9, 14, 19, 24),
        @(5, 10, 15, 20, 25)
    )

# Test 10: Double transpose should give original matrix
Write-Host "`nTest: Double transpose returns original" -ForegroundColor Cyan
$original = @(
    @(1, 2, 3),
    @(4, 5, 6),
    @(7, 8, 9)
)
Write-Host "Original matrix:"
foreach ($row in $original) {
    $rowStr = $row -join ", "
    Write-Host "  [$rowStr]"
}

# Create deep copy
$testMatrix = @()
for ($i = 0; $i -lt $original.Count; $i++) {
    $newRow = @()
    for ($j = 0; $j -lt $original[$i].Count; $j++) {
        $newRow += $original[$i][$j]
    }
    $testMatrix += ,$newRow
}

# First transpose
$transposed1 = Transpose-Matrix -matrix $testMatrix
# Second transpose
$transposed2 = Transpose-Matrix -matrix $transposed1

Write-Host "After double transpose:"
foreach ($row in $transposed2) {
    $rowStr = $row -join ", "
    Write-Host "  [$rowStr]"
}

if (Test-MatrixEquality -matrix1 $transposed2 -matrix2 $original) {
    Write-Host "[PASS] Test passed" -ForegroundColor Green
    $script:testsPassed++
} else {
    Write-Host "[FAIL] Test failed" -ForegroundColor Red
    $script:testsFailed++
}

# Test 11: Non-square matrix should throw exception
Test-ExceptionThrown -testName "Non-square matrix (2x3) should throw exception" `
    -inputMatrix @(
        @(1, 2, 3),
        @(4, 5, 6)
    )

# Test 12: Empty matrix
Assert-Test -testName "Empty matrix" `
    -inputMatrix @() `
    -expected @()

# Summary
Write-Host ("`n" + ("=" * 60)) -ForegroundColor Yellow
Write-Host "Test Results Summary" -ForegroundColor Yellow
Write-Host ("=" * 60) -ForegroundColor Yellow
Write-Host "Tests Passed: $script:testsPassed" -ForegroundColor Green
Write-Host "Tests Failed: $script:testsFailed" -ForegroundColor $(if ($script:testsFailed -eq 0) { "Green" } else { "Red" })
Write-Host "Total Tests: $($script:testsPassed + $script:testsFailed)" -ForegroundColor Cyan

if ($script:testsFailed -eq 0) {
    Write-Host "`nAll tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome tests failed!" -ForegroundColor Red
    exit 1
}

<#
Tests for Stock Span Problem
Run: pwsh -File .\test_stock_span.ps1
#>

. "$PSScriptRoot\stock_span.ps1"

function Test-ArraysEqual {
    param([int[]]$Array1, [int[]]$Array2)
    
    if ($Array1.Length -ne $Array2.Length) { return $false }
    for ($i = 0; $i -lt $Array1.Length; $i++) {
        if ($Array1[$i] -ne $Array2[$i]) { return $false }
    }
    return $true
}

$testCases = @(
    @{
        Name = "Example 1: Classic case"
        Prices = @(100, 80, 60, 70, 60, 75, 85)
        Expected = @(1, 1, 1, 2, 1, 4, 6)
    },
    @{
        Name = "Example 2: Large spike"
        Prices = @(10, 4, 5, 90, 120, 80)
        Expected = @(1, 1, 2, 4, 5, 1)
    },
    @{
        Name = "All increasing prices"
        Prices = @(10, 20, 30, 40, 50)
        Expected = @(1, 2, 3, 4, 5)
    },
    @{
        Name = "All decreasing prices"
        Prices = @(50, 40, 30, 20, 10)
        Expected = @(1, 1, 1, 1, 1)
    },
    @{
        Name = "All same prices"
        Prices = @(5, 5, 5, 5, 5)
        Expected = @(1, 2, 3, 4, 5)
    },
    @{
        Name = "Single element"
        Prices = @(100)
        Expected = @(1)
    },
    @{
        Name = "Two elements - increasing"
        Prices = @(10, 20)
        Expected = @(1, 2)
    },
    @{
        Name = "Two elements - decreasing"
        Prices = @(20, 10)
        Expected = @(1, 1)
    },
    @{
        Name = "Peak in middle"
        Prices = @(10, 20, 30, 20, 10)
        Expected = @(1, 2, 3, 1, 1)
    },
    @{
        Name = "Valley in middle"
        Prices = @(30, 20, 10, 20, 30)
        Expected = @(1, 1, 1, 3, 5)
    },
    @{
        Name = "Multiple peaks"
        Prices = @(10, 30, 20, 40, 35, 50)
        Expected = @(1, 2, 1, 4, 1, 6)
    },
    @{
        Name = "Alternating high-low"
        Prices = @(100, 50, 100, 50, 100)
        Expected = @(1, 1, 3, 1, 5)
    }
)

$failures = 0
$passed = 0

Write-Host "Running Stock Span Problem Tests..." -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host ""

foreach ($test in $testCases) {
    $result = Get-StockSpan -Prices $test.Prices
    $success = Test-ArraysEqual -Array1 $result -Array2 $test.Expected
    
    if ($success) {
        Write-Host "[PASS] $($test.Name)" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "[FAIL] $($test.Name)" -ForegroundColor Red
        Write-Host "  Input:    [$($test.Prices -join ', ')]" -ForegroundColor Yellow
        Write-Host "  Expected: [$($test.Expected -join ', ')]" -ForegroundColor Yellow
        Write-Host "  Got:      [$($result -join ', ')]" -ForegroundColor Yellow
        $failures++
    }
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan

if ($failures -eq 0) {
    Write-Host "All $passed tests passed! ✓" -ForegroundColor Green
    exit 0
} else {
    Write-Host "$failures test(s) failed, $passed test(s) passed." -ForegroundColor Red
    exit 1
}

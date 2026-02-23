<#
.SYNOPSIS
    Quick runner script for Union of Arrays with Duplicates solution

.DESCRIPTION
    Provides a convenient way to run the solution with custom inputs or predefined examples.
    Also includes options to run tests or view performance comparisons.

.PARAMETER a
    First array (comma-separated integers)

.PARAMETER b
    Second array (comma-separated integers)

.PARAMETER RunTests
    Run the complete test suite

.PARAMETER ShowPerformance
    Show performance comparison of different methods

.EXAMPLE
    .\Run.ps1
    Runs solution with default examples

.EXAMPLE
    .\Run.ps1 -a @(1,2,3) -b @(2,3,4)
    Runs solution with custom arrays

.EXAMPLE
    .\Run.ps1 -RunTests
    Runs the complete test suite

.EXAMPLE
    .\Run.ps1 -ShowPerformance
    Shows performance comparison
#>

param(
    [int[]]$a,
    [int[]]$b,
    [switch]$RunTests,
    [switch]$ShowPerformance
)

$ErrorActionPreference = "Stop"

# Import solution
. "$PSScriptRoot\Solution.ps1"

if ($RunTests) {
    Write-Host "`nRunning test suite...`n" -ForegroundColor Cyan
    & "$PSScriptRoot\Tests.ps1"
    exit $LASTEXITCODE
}

if ($ShowPerformance) {
    Write-Host "`n=== Performance Comparison ===" -ForegroundColor Cyan
    Write-Host "Testing with arrays of varying sizes...`n"
    
    $sizes = @(100, 1000, 5000, 10000)
    
    foreach ($size in $sizes) {
        Write-Host "Array size: $size elements" -ForegroundColor Yellow
        $testA = 1..$size
        $testB = ($size/2)..(3*$size/2)
        
        $time1 = Measure-Command { $null = Get-UnionCount -a $testA -b $testB }
        $time2 = Measure-Command { $null = Get-UnionCount-Hashtable -a $testA -b $testB }
        $time3 = Measure-Command { $null = Get-UnionCount-SelectUnique -a $testA -b $testB }
        
        Write-Host "  HashSet:       $([math]::Round($time1.TotalMilliseconds, 2)) ms" -ForegroundColor Green
        Write-Host "  Hashtable:     $([math]::Round($time2.TotalMilliseconds, 2)) ms" -ForegroundColor Yellow
        Write-Host "  Select-Object: $([math]::Round($time3.TotalMilliseconds, 2)) ms" -ForegroundColor Magenta
        Write-Host ""
    }
    exit 0
}

if ($a -and $b) {
    # Run with custom input
    Write-Host "`n=== Custom Input ===" -ForegroundColor Cyan
    Write-Host "Array a: [$($a -join ', ')]"
    Write-Host "Array b: [$($b -join ', ')]"
    
    $result = Get-UnionCount -a $a -b $b
    Write-Host "`nUnion count: $result" -ForegroundColor Green
    
    # Show the actual union elements
    $unionSet = New-Object 'System.Collections.Generic.HashSet[int]'
    foreach ($element in $a) { [void]$unionSet.Add($element) }
    foreach ($element in $b) { [void]$unionSet.Add($element) }
    $unionArray = @($unionSet) | Sort-Object
    Write-Host "Union elements: [$($unionArray -join ', ')]" -ForegroundColor Cyan
}
else {
    # Run with default examples
    Write-Host "`n=== GeeksforGeeks Problem of the Day ===" -ForegroundColor Cyan
    Write-Host "Union of Arrays with Duplicates" -ForegroundColor White
    Write-Host "February 23, 2026`n" -ForegroundColor Gray
    
    # Just run the solution script which has examples built in
    & "$PSScriptRoot\Solution.ps1"
}

Write-Host "`n=== Quick Usage Guide ===" -ForegroundColor Yellow
Write-Host "Run with custom arrays: .\Run.ps1 -a @(1,2,3) -b @(2,3,4)"
Write-Host "Run all tests:          .\Run.ps1 -RunTests"
Write-Host "View performance:       .\Run.ps1 -ShowPerformance"
Write-Host ""
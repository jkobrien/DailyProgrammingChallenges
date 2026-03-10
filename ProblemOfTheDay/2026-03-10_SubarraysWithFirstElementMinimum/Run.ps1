<#
.SYNOPSIS
    Interactive runner for Subarrays with First Element Minimum solution.

.DESCRIPTION
    Demonstrates the solution with examples and allows custom input.
#>

# Import the solution
. "$PSScriptRoot\subarrays_first_element_minimum.ps1"

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Subarrays with First Element Minimum" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "Problem: Count subarrays where the first element is the minimum." -ForegroundColor Yellow
Write-Host ""

# Example 1
Write-Host "Example 1:" -ForegroundColor Green
$arr1 = @(1, 2, 1)
Write-Host "  Input:  [$($arr1 -join ', ')]"
$result1 = Get-SubarraysWithFirstElementMinimum -arr $arr1
Write-Host "  Output: $result1"
Write-Host "  Explanation: Valid subarrays are [1], [1,2], [1,2,1], [2], [1]" -ForegroundColor Gray
Write-Host ""

# Example 2
Write-Host "Example 2:" -ForegroundColor Green
$arr2 = @(1, 3, 5, 2)
Write-Host "  Input:  [$($arr2 -join ', ')]"
$result2 = Get-SubarraysWithFirstElementMinimum -arr $arr2
Write-Host "  Output: $result2"
Write-Host "  Explanation: Valid subarrays are [1], [1,3], [1,3,5], [1,3,5,2], [3], [3,5], [5], [2]" -ForegroundColor Gray
Write-Host ""

# Additional examples
Write-Host "Additional Examples:" -ForegroundColor Green
Write-Host ""

$testCases = @(
    @{ arr = @(5); desc = "Single element" },
    @{ arr = @(4, 3, 2, 1); desc = "Strictly decreasing" },
    @{ arr = @(1, 2, 3, 4); desc = "Strictly increasing" },
    @{ arr = @(2, 2, 2); desc = "All same elements" }
)

foreach ($tc in $testCases) {
    $result = Get-SubarraysWithFirstElementMinimum -arr $tc.arr
    Write-Host "  $($tc.desc): [$($tc.arr -join ', ')] -> $result" -ForegroundColor White
}

Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "Algorithm: Monotonic Stack (O(n) time, O(n) space)" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "To run tests: .\test_subarrays_first_element_minimum.ps1" -ForegroundColor Yellow
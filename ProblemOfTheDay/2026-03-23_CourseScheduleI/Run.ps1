<#
.SYNOPSIS
    Run script for Course Schedule I - demonstrates the solution with examples

.DESCRIPTION
    This script demonstrates the Course Schedule I solution with the examples
    from the problem statement.
#>

# Import the solution
. "$PSScriptRoot\course_schedule_i.ps1"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Course Schedule I - GeeksforGeeks POTD" -ForegroundColor Cyan
Write-Host "  March 23, 2026" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Problem: Given n courses and prerequisites, determine if all courses" -ForegroundColor White
Write-Host "         can be completed without circular dependencies." -ForegroundColor White
Write-Host ""

# Example 1
Write-Host "Example 1:" -ForegroundColor Yellow
$result1 = Solve-CourseScheduleI -n 4 -prerequisites @(@(2, 0), @(2, 1), @(3, 2))

# Example 2
Write-Host "Example 2:" -ForegroundColor Yellow
$result2 = Solve-CourseScheduleI -n 3 -prerequisites @(@(0, 1), @(1, 2), @(2, 0))

# Additional Example - No prerequisites
Write-Host "Additional Example - No Prerequisites:" -ForegroundColor Yellow
$result3 = Solve-CourseScheduleI -n 5 -prerequisites @()

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Summary" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Example 1 (Linear chain):     $result1" -ForegroundColor $(if ($result1) { "Green" } else { "Red" })
Write-Host "Example 2 (Cyclic):           $result2" -ForegroundColor $(if ($result2) { "Green" } else { "Red" })
Write-Host "Example 3 (No prerequisites): $result3" -ForegroundColor $(if ($result3) { "Green" } else { "Red" })
Write-Host ""
Write-Host "To run tests: .\test_course_schedule_i.ps1" -ForegroundColor Gray
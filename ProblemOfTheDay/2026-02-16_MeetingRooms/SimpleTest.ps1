# Simple test to verify the solution works
. "$PSScriptRoot\Solution.ps1"

Write-Host "Testing Meeting Rooms Solution" -ForegroundColor Cyan
Write-Host "==============================`n" -ForegroundColor Cyan

# Test 1
Write-Host "Test 1: Non-overlapping meetings" -ForegroundColor Yellow
$result1 = Can-Attend-All-Meetings -meetings @(@(1,4), @(10,15), @(7,10))
Write-Host "Result: $result1 (Expected: True)" -ForegroundColor $(if ($result1) {"Green"} else {"Red"})

# Test 2
Write-Host "`nTest 2: Overlapping meetings" -ForegroundColor Yellow
$result2 = Can-Attend-All-Meetings -meetings @(@(2,4), @(9,12), @(6,10))
Write-Host "Result: $result2 (Expected: False)" -ForegroundColor $(if (-not $result2) {"Green"} else {"Red"})

# Test 3
Write-Host "`nTest 3: Single meeting" -ForegroundColor Yellow
$result3 = Can-Attend-All-Meetings -meetings @(@(1,5))
Write-Host "Result: $result3 (Expected: True)" -ForegroundColor $(if ($result3) {"Green"} else {"Red"})

# Test 4
Write-Host "`nTest 4: Back-to-back meetings" -ForegroundColor Yellow
$result4 = Can-Attend-All-Meetings -meetings @(@(1,2), @(2,3), @(3,4))
Write-Host "Result: $result4 (Expected: True)" -ForegroundColor $(if ($result4) {"Green"} else {"Red"})

Write-Host "`n==============================" -ForegroundColor Cyan
Write-Host "All basic tests completed!" -ForegroundColor Green
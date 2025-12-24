# Debug script to understand the issue
. "$PSScriptRoot\solution.ps1"

Write-Host "Testing [1, 1]" -ForegroundColor Cyan
Write-Host "After removing index 0: [1] -> even sum = 1, odd sum = 0 -> Should balance? Yes"
Write-Host "After removing index 1: [1] -> even sum = 1, odd sum = 0 -> Should balance? Yes"
Write-Host "Expected: 2"
$result = CountBalancedIndices @(1, 1)
Write-Host "Got: $result" -ForegroundColor Yellow
Write-Host ""

Write-Host "Testing [1, 2, 3]" -ForegroundColor Cyan
Write-Host "Original: [1, 2, 3] -> even (indices 0,2) = 1+3=4, odd (index 1) = 2"
Write-Host "Remove index 0: [2, 3] -> even (index 0) = 2, odd (index 1) = 3 -> NOT balanced"
Write-Host "Remove index 1: [1, 3] -> even (index 0) = 1, odd (index 1) = 3 -> NOT balanced"
Write-Host "Remove index 2: [1, 2] -> even (index 0) = 1, odd (index 1) = 2 -> NOT balanced"
Write-Host "Expected: 0 or maybe 1?"
$result = CountBalancedIndices @(1, 2, 3)
Write-Host "Got: $result" -ForegroundColor Yellow

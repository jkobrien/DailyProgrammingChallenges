# Quick verification script
. "$PSScriptRoot\and_in_range.ps1"

Write-Host "Testing [1000, 1010]:"
$result1 = Get-ANDInRange -l 1000 -r 1010
Write-Host "  Algorithm result: $result1"
$brute1 = 1000
for ($i = 1001; $i -le 1010; $i++) { $brute1 = $brute1 -band $i }
Write-Host "  Brute force result: $brute1"
Write-Host ""

Write-Host "Testing [1000000, 1000100]:"
$result2 = Get-ANDInRange -l 1000000 -r 1000100
Write-Host "  Algorithm result: $result2"
$brute2 = 1000000
for ($i = 1000001; $i -le 1000100; $i++) { $brute2 = $brute2 -band $i }
Write-Host "  Brute force result: $brute2"

# Test script for Maximum Stone Removal

. "$PSScriptRoot\maximum_stone_removal.ps1"

function Assert-Equal($actual, $expected, $testName) {
    if ($actual -eq $expected) {
        Write-Host "PASS: $testName"
    } else {
        Write-Host "FAIL: $testName - Expected $expected, got $actual"
    }
}

# Test 1: Example from problem
$stones1 = @(@(0,0), @(0,1), @(1,0), @(1,2), @(2,1), @(2,2))
$result1 = Get-MaximumStoneRemoval -stones $stones1
Assert-Equal $result1 5 "Example Test"

# Test 2: All stones in a line
$stones2 = @(@(0,0), @(0,1), @(0,2), @(0,3))
$result2 = Get-MaximumStoneRemoval -stones $stones2
Assert-Equal $result2 3 "All in Row"

# Test 3: No removable stones
$stones3 = @(@(0,0))
$result3 = Get-MaximumStoneRemoval -stones $stones3
Assert-Equal $result3 0 "Single Stone"

# Test 4: Two disconnected stones
$stones4 = @(@(0,0), @(1,1))
$result4 = Get-MaximumStoneRemoval -stones $stones4
Assert-Equal $result4 0 "Disconnected Stones"

# Test 5: All stones in a column
$stones5 = @(@(0,0), @(1,0), @(2,0), @(3,0))
$result5 = Get-MaximumStoneRemoval -stones $stones5
Assert-Equal $result5 3 "All in Column"

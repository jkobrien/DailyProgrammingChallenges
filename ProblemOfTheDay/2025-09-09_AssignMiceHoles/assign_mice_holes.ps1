# Assign Mice Holes - GeeksforGeeks Problem of the Day (2025-09-09)
#
# Problem:
# Given two arrays mices[] and holes[] of the same size, representing positions on a line.
# Each hole can accommodate one mouse. Each move (left/right) takes 1 minute.
# Assign each mouse to a hole to minimize the time taken by the last mouse to reach its hole.
#
# Approach:
# Sort both arrays and pair the ith mouse with the ith hole.
# The answer is the maximum absolute difference between paired positions.

function Get-MinimumTimeToAssignMiceHoles {
    param (
        [int[]]$mices,
        [int[]]$holes
    )
    # Sort both arrays
    $mices = $mices | Sort-Object
    $holes = $holes | Sort-Object

    $maxTime = 0
    for ($i = 0; $i -lt $mices.Length; $i++) {
        $time = [math]::Abs($mices[$i] - $holes[$i])
        if ($time -gt $maxTime) {
            $maxTime = $time
        }
    }
    return $maxTime
}

# Test cases
Write-Host "Test 1"
$mices1 = 4, -4, 2
$holes1 = 4, 0, 5
$result1 = Get-MinimumTimeToAssignMiceHoles -mices $mices1 -holes $holes1
Write-Host "Input: mices = $($mices1 -join ', '), holes = $($holes1 -join ', ')"
Write-Host "Output: $result1"  # Expected: 4

Write-Host "`nTest 2"
$mices2 = 1, 2
$holes2 = 20, 10
$result2 = Get-MinimumTimeToAssignMiceHoles -mices $mices2 -holes $holes2
Write-Host "Input: mices = $($mices2 -join ', '), holes = $($holes2 -join ', ')"
Write-Host "Output: $result2"  # Expected: 18

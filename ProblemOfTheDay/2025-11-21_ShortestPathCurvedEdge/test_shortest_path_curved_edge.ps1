# Test script for Shortest Path Using Atmost One Curved Edge

Import-Module "$PSScriptRoot\shortest_path_curved_edge.ps1" -Force

function Test-Case {
    param (
        [int]$V,
        [array]$edges,
        [int]$S,
        [int]$D,
        [int]$expected
    )
    $result = Get-ShortestPathCurvedEdge -V $V -edges $edges -S $S -D $D
    if ($result -eq $expected) {
        Write-Output "PASS: V=$V, S=$S, D=$D, Expected=$expected, Got=$result"
    } else {
        Write-Output "FAIL: V=$V, S=$S, D=$D, Expected=$expected, Got=$result"
    }
}

# Example 1
Test-Case -V 4 -edges @( @(0,1,1,10), @(1,2,1,1), @(2,3,1,1), @(0,3,10,100) ) -S 0 -D 3 -expected 3

# Example 2: No curved edge needed
Test-Case -V 3 -edges @( @(0,1,2,5), @(1,2,2,3) ) -S 0 -D 2 -expected 4

# Example 3: Curved edge required
Test-Case -V 3 -edges @( @(0,1,10,1), @(1,2,10,1) ) -S 0 -D 2 -expected 12

# Example 4: No path exists
Test-Case -V 2 -edges @( @(0,1,100,100) ) -S 0 -D 1 -expected 100

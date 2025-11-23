# Maximum Stone Removal - PowerShell Solution
# Given an array of stones, returns the maximum number of stones that can be removed.

function Get-MaximumStoneRemoval {
    param (
        [int[][]]$stones
    )
    $n = $stones.Count
    $visited = @{}
    # Build adjacency list: stones are connected if they share a row or column
    $adj = @{}
    for ($i = 0; $i -lt $n; $i++) {
        $adj[$i] = @()
        for ($j = 0; $j -lt $n; $j++) {
            if ($i -ne $j -and ($stones[$i][0] -eq $stones[$j][0] -or $stones[$i][1] -eq $stones[$j][1])) {
                $adj[$i] += $j
            }
        }
    }
    function DFS($u) {
        $visited[$u] = $true
        foreach ($v in $adj[$u]) {
            if (-not $visited.ContainsKey($v)) {
                DFS $v
            }
        }
    }
    $components = 0
    for ($i = 0; $i -lt $n; $i++) {
        if (-not $visited.ContainsKey($i)) {
            DFS $i
            $components++
        }
    }
    return $n - $components
}

# Example usage:
# $stones = @(@(0,0), @(0,1), @(1,0), @(1,2), @(2,1), @(2,2))
# $result = Get-MaximumStoneRemoval -stones $stones
# Write-Output $result

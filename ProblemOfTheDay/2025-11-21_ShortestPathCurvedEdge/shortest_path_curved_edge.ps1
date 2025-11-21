# Shortest Path Using Atmost One Curved Edge
# PowerShell Solution

<#
Problem:
Given a graph with V vertices and E double-edges (x, y, w1, w2), find the shortest path from S to D using at most one curved edge (w2). All other edges used must be normal (w1).
#>

function Get-ShortestPathCurvedEdge {
    param (
        [int]$V,
        [array]$edges,
        [int]$S,
        [int]$D
    )

    # Build adjacency list for normal edges
    $adj = @{}
    for ($i = 0; $i -lt $V; $i++) { $adj[$i] = @() }
    foreach ($e in $edges) {
        $x, $y, $w1, $w2 = $e
        $adj[$x] += ,@($y, $w1)
        $adj[$y] += ,@($x, $w1)
    }

    function Dijkstra($src) {
        $dist = @{}
        for ($i = 0; $i -lt $V; $i++) { $dist[$i] = [int]::MaxValue }
        $dist[$src] = 0
        $visited = @{}
        $pq = New-Object System.Collections.Generic.List[object]
        $pq.Add(@($src, 0))
        while ($pq.Count -gt 0) {
            $pq = $pq | Sort-Object { $_[1] }
            $curr = $pq[0]
            $pq.RemoveAt(0)
            $u = $curr[0]
            $d = $curr[1]
            if ($visited.ContainsKey($u)) { continue }
            $visited[$u] = $true
            foreach ($v in $adj[$u]) {
                $to = $v[0]
                $w = $v[1]
                if ($dist[$to] -gt $dist[$u] + $w) {
                    $dist[$to] = $dist[$u] + $w
                    $pq.Add(@($to, $dist[$to]))
                }
            }
        }
        return $dist
    }

    # Dijkstra from S and D (normal edges only)
    $distS = Dijkstra $S
    $distD = Dijkstra $D

    $ans = $distS[$D]

    # Try using each curved edge once
    foreach ($e in $edges) {
        $x, $y, $w1, $w2 = $e
        # S -> x (normal), curved x->y, y->D (normal)
        if ($distS[$x] -ne [int]::MaxValue -and $distD[$y] -ne [int]::MaxValue) {
            $ans = [Math]::Min($ans, $distS[$x] + $w2 + $distD[$y])
        }
        # S -> y (normal), curved y->x, x->D (normal)
        if ($distS[$y] -ne [int]::MaxValue -and $distD[$x] -ne [int]::MaxValue) {
            $ans = [Math]::Min($ans, $distS[$y] + $w2 + $distD[$x])
        }
    }
    return $ans -eq [int]::MaxValue ? -1 : $ans
}

# Example usage:
# $V = 4
# $edges = @( @(0,1,1,10), @(1,2,1,1), @(2,3,1,1), @(0,3,10,100) )
# $S = 0
# $D = 3
# $result = Get-ShortestPathCurvedEdge -V $V -edges $edges -S $S -D $D
# Write-Output "Shortest path: $result"

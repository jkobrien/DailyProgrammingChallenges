<#!
Safe States (GeeksforGeeks POTD 2025-11-03)

A node in a directed graph is "safe" if every path starting from it eventually reaches a terminal node (a node with out-degree 0). Nodes that can reach a cycle are unsafe.

Approach (Reverse Graph + Topological Trimming / Kahn Style):
1. Compute out-degree for every node.
2. Build reverse adjacency: for each edge u->v, store u in reverse[v].
3. Initialize queue with all terminal nodes (out-degree == 0). These are trivially safe.
4. Pop a node x from queue (safe). For every predecessor p in reverse[x], decrement out-degree[p]. If out-degree[p] becomes 0, enqueue p (p becomes safe because all its outgoing edges lead to already-safe nodes).
5. Collect all dequeued nodes and sort them (ascending) for deterministic output.

Time Complexity: O(V + E)
Space Complexity: O(V + E)

Usage Examples:
  . .\safe_states.ps1
  Get-SafeStates -Vertices 5 -Edges @(@(1,0),@(1,2),@(1,3),@(1,4),@(2,3),@(3,4))  # => 0 1 2 3 4

Optional CLI (when running the script directly):
  pwsh safe_states.ps1 -V 5 -Edges "1,0;1,2;1,3;1,4;2,3;3,4"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)][int]$V,
    [Parameter(Mandatory=$false)][string]$Edges
)

function Get-SafeStates {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)][int]$Vertices,
        [Parameter(Mandatory=$true)][int[][]]$Edges
    )
    if ($Vertices -lt 0) { throw "Vertices must be non-negative" }
    # Initialize out-degree and reverse adjacency
    $outDegree = New-Object int[] $Vertices
    $reverse = @()
    for ($i=0; $i -lt $Vertices; $i++) { $reverse += ,@() }

    foreach ($e in $Edges) {
        # Normalize edge to a 2-item array; be defensive in case of implicit casting quirks
        $u = $null; $v = $null
        try {
            $u = [int]$e[0]
            $v = [int]$e[1]
        } catch {
            throw "Invalid edge representation '$e' (expect [u,v])"
        }
        if ($u -lt 0 -or $u -ge $Vertices -or $v -lt 0 -or $v -ge $Vertices) {
            throw "Edge ($u,$v) has vertex outside range 0..$($Vertices-1)" 
        }
        $outDegree[$u]++
        # reverse edge: v <- u
        $reverse[$v] += $u
    }

    $queue = [System.Collections.Generic.Queue[int]]::new()
    for ($i=0; $i -lt $Vertices; $i++) {
        if ($outDegree[$i] -eq 0) { $queue.Enqueue($i) }
    }

    $safe = New-Object System.Collections.Generic.List[int]
    while ($queue.Count -gt 0) {
        $node = $queue.Dequeue()
        $safe.Add($node)
        foreach ($pred in $reverse[$node]) {
            $outDegree[$pred]--
            if ($outDegree[$pred] -eq 0) { $queue.Enqueue($pred) }
        }
    }

    # Sort for deterministic ascending order (nodes discovered order may vary)
    return ($safe.ToArray() | Sort-Object)
}

function Convert-EdgesStringToArray {
    param([string]$EdgeSpec)
    if ([string]::IsNullOrWhiteSpace($EdgeSpec)) { return @() }
    $pairs = $EdgeSpec.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
    $result = @()
    foreach ($p in $pairs) {
        $nums = $p.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries).Trim()
        if ($nums.Count -ne 2) { throw "Invalid edge token '$p' (expect 'u,v')." }
        $result += ,(@([int]$nums[0],[int]$nums[1]))
    }
    return ,$result
}

if ($PSBoundParameters.ContainsKey('V')) {
    if (-not $PSBoundParameters.ContainsKey('Edges')) {
        throw "When using CLI mode, supply -V and -Edges (e.g. -Edges '1,0;1,2')." 
    }
    $edgeArray = Convert-EdgesStringToArray -EdgeSpec $Edges
    $ans = Get-SafeStates -Vertices $V -Edges $edgeArray
    Write-Output $ans
}

<#
.SYNOPSIS
    Second Best Minimum Spanning Tree - GeeksforGeeks Problem of the Day (Nov 24, 2025)

.DESCRIPTION
    Finds the weight of the second best minimum spanning tree in an undirected weighted graph.
    A second best MST is defined as the minimum-weight spanning tree whose total weight is 
    strictly greater than the weight of the minimum spanning tree.

.NOTES
    Algorithm: Kruskal's MST with Union-Find
    Time Complexity: O(V * E)
    Space Complexity: O(V + E)
#>

class UnionFind {
    [int[]]$parent
    [int[]]$rank

    UnionFind([int]$n) {
        $this.parent = 0..($n - 1)
        $this.rank = @(0) * $n
    }

    [int] Find([int]$x) {
        if ($this.parent[$x] -ne $x) {
            $this.parent[$x] = $this.Find($this.parent[$x])  # Path compression
        }
        return $this.parent[$x]
    }

    [bool] Union([int]$x, [int]$y) {
        $rootX = $this.Find($x)
        $rootY = $this.Find($y)

        if ($rootX -eq $rootY) {
            return $false  # Already connected
        }

        # Union by rank
        if ($this.rank[$rootX] -lt $this.rank[$rootY]) {
            $this.parent[$rootX] = $rootY
        }
        elseif ($this.rank[$rootX] -gt $this.rank[$rootY]) {
            $this.parent[$rootY] = $rootX
        }
        else {
            $this.parent[$rootY] = $rootX
            $this.rank[$rootX]++
        }
        return $true
    }
}

class Edge {
    [int]$u
    [int]$v
    [int]$weight
    [int]$index

    Edge([int]$u, [int]$v, [int]$weight, [int]$index) {
        $this.u = $u
        $this.v = $v
        $this.weight = $weight
        $this.index = $index
    }
}

function Get-MST {
    <#
    .SYNOPSIS
        Builds a Minimum Spanning Tree using Kruskal's algorithm
    
    .PARAMETER V
        Number of vertices
    
    .PARAMETER edges
        Array of Edge objects
    
    .PARAMETER excludeEdgeIndex
        Optional index of edge to exclude from MST construction
    
    .OUTPUTS
        Hashtable with 'weight' and 'usedEdges' keys
    #>
    param(
        [int]$V,
        [Edge[]]$edges,
        [int]$excludeEdgeIndex = -1
    )

    # Sort edges by weight
    $sortedEdges = $edges | Sort-Object -Property weight

    $uf = [UnionFind]::new($V)
    $mstWeight = 0
    $edgesUsed = 0
    $usedEdgeIndices = @()

    foreach ($edge in $sortedEdges) {
        # Skip excluded edge
        if ($edge.index -eq $excludeEdgeIndex) {
            continue
        }

        # Try to add edge to MST
        if ($uf.Union($edge.u, $edge.v)) {
            $mstWeight += $edge.weight
            $edgesUsed++
            $usedEdgeIndices += $edge.index

            # MST complete when we have V-1 edges
            if ($edgesUsed -eq ($V - 1)) {
                break
            }
        }
    }

    # Return null if we couldn't form a complete spanning tree
    if ($edgesUsed -ne ($V - 1)) {
        return $null
    }

    return @{
        weight = $mstWeight
        usedEdges = $usedEdgeIndices
    }
}

function Get-SecondBestMST {
    <#
    .SYNOPSIS
        Finds the weight of the second best minimum spanning tree
    
    .PARAMETER V
        Number of vertices (0 to V-1)
    
    .PARAMETER edgesArray
        2D array where each element is [u, v, weight]
    
    .OUTPUTS
        Integer representing the weight of the second best MST, or -1 if none exists
    
    .EXAMPLE
        $edges = @(@(0,1,4), @(0,2,3), @(1,2,1), @(1,3,5), @(2,4,10), @(2,3,7), @(3,4,2))
        Get-SecondBestMST -V 5 -edgesArray $edges
        # Returns: 12
    #>
    param(
        [int]$V,
        [array]$edgesArray
    )

    # Convert input to Edge objects
    $edges = @()
    for ($i = 0; $i -lt $edgesArray.Count; $i++) {
        $e = $edgesArray[$i]
        $edges += [Edge]::new($e[0], $e[1], $e[2], $i)
    }

    # Step 1: Find the original MST
    $originalMST = Get-MST -V $V -edges $edges
    
    if ($null -eq $originalMST) {
        return -1  # No spanning tree exists
    }

    $originalWeight = $originalMST.weight
    $mstEdgeIndices = $originalMST.usedEdges

    # Step 2: Try to find second best MST by excluding each MST edge
    $secondBestWeight = [int]::MaxValue
    $foundSecondBest = $false

    foreach ($excludeIndex in $mstEdgeIndices) {
        # Build MST without this edge
        $altMST = Get-MST -V $V -edges $edges -excludeEdgeIndex $excludeIndex

        # Check if we found a valid alternative spanning tree
        if ($null -ne $altMST) {
            $altWeight = $altMST.weight

            # We want the minimum weight that is strictly greater than original
            if ($altWeight -gt $originalWeight -and $altWeight -lt $secondBestWeight) {
                $secondBestWeight = $altWeight
                $foundSecondBest = $true
            }
        }
    }

    # Return second best weight or -1 if none found
    if ($foundSecondBest) {
        return $secondBestWeight
    }
    else {
        return -1
    }
}

# Note: Export-ModuleMember removed as this is a script file, not a module

<#
.NOTES
EXPLANATION OF THE SOLUTION:

1. UNION-FIND DATA STRUCTURE:
   - Used for efficient cycle detection in Kruskal's algorithm
   - Find() operation uses path compression for O(α(n)) amortized time
   - Union() operation uses union by rank optimization
   
2. KRUSKAL'S ALGORITHM:
   - Sort all edges by weight
   - Greedily add edges that don't create cycles
   - Stop when we have V-1 edges (complete spanning tree)

3. FINDING SECOND BEST MST:
   - First, find the optimal MST and identify which edges are used
   - For each edge in the MST, try building a new MST without it
   - The minimum weight among valid alternative MSTs that is strictly 
     greater than the original MST weight is our answer
   
4. WHY THIS WORKS:
   - The second best MST must differ from the best MST by at least one edge
   - By removing each MST edge and rebuilding, we explore all possible
     "one edge different" spanning trees
   - Among these, the one with minimum weight > original is the second best

5. EDGE CASES:
   - If graph is a tree (V-1 edges), no second MST exists → return -1
   - If graph is disconnected, no spanning tree exists → return -1
   - If all alternative MSTs have same weight as original → return -1

EXAMPLE WALKTHROUGH (Example 1):
V=5, edges = [[0,1,4], [0,2,3], [1,2,1], [1,3,5], [2,4,10], [2,3,7], [3,4,2]]

Step 1: Find MST
- Sort edges by weight: [1-2:1], [3-4:2], [0-2:3], [0-1:4], [1-3:5], [2-3:7], [2-4:10]
- Add edges: [1-2:1], [3-4:2], [0-2:3], [1-3:5]
- MST weight = 11, edges = {[1,2], [3,4], [0,2], [1,3]}

Step 2: Try excluding each MST edge
- Exclude [1,2]: MST = [3-4:2], [0-2:3], [0-1:4], [1-3:5] → weight = 14
- Exclude [3,4]: MST = [1-2:1], [0-2:3], [1-3:5], [2-3:7] → weight = 16
- Exclude [0,2]: MST = [1-2:1], [3-4:2], [0-1:4], [1-3:5] → weight = 12 ✓
- Exclude [1,3]: MST = [1-2:1], [3-4:2], [0-2:3], [2-3:7] → weight = 13

Step 3: Find minimum weight > 11
- Answer = 12
#>

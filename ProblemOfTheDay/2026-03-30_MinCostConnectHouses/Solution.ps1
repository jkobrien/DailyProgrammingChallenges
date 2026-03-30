<#
.SYNOPSIS
    Minimum Cost to Connect All Houses in a City - Prim's Algorithm Solution

.DESCRIPTION
    Given n house coordinates, find the minimum cost to connect all houses.
    The cost of connecting two houses is the Manhattan Distance between them.
    This is a Minimum Spanning Tree (MST) problem solved using Prim's Algorithm.

.PARAMETER houses
    A 2D array where each element is [x, y] coordinates of a house

.EXAMPLE
    $houses = @(@(0,7), @(0,9), @(20,7), @(30,7), @(40,70))
    Get-MinCostToConnectHouses -houses $houses
    # Returns: 105
#>

function Get-ManhattanDistance {
    <#
    .SYNOPSIS
        Calculate Manhattan distance between two points
    #>
    param(
        [int[]]$point1,
        [int[]]$point2
    )
    
    return [Math]::Abs($point1[0] - $point2[0]) + [Math]::Abs($point1[1] - $point2[1])
}

function Get-MinCostToConnectHouses {
    <#
    .SYNOPSIS
        Find minimum cost to connect all houses using Prim's Algorithm
    
    .DESCRIPTION
        Uses Prim's Algorithm to build a Minimum Spanning Tree (MST).
        
        Algorithm Steps:
        1. Start with house 0 in the MST
        2. For each unvisited house, track the minimum cost to connect it to MST
        3. Greedily select the house with minimum connection cost
        4. Add it to MST and update minimum costs for remaining houses
        5. Repeat until all houses are connected
    
    .PARAMETER houses
        Array of [x, y] coordinates representing house locations
    
    .OUTPUTS
        [int] The minimum total cost to connect all houses
    #>
    param(
        [Parameter(Mandatory=$true)]
        [array]$houses
    )
    
    $n = $houses.Count
    
    # Edge case: single house needs no connections
    if ($n -le 1) {
        return 0
    }
    
    # minDist[i] = minimum cost to connect house i to the current MST
    # Initialize with infinity (using [int]::MaxValue)
    $minDist = @()
    for ($i = 0; $i -lt $n; $i++) {
        $minDist += [int]::MaxValue
    }
    
    # Track which houses are already in the MST
    $inMST = @()
    for ($i = 0; $i -lt $n; $i++) {
        $inMST += $false
    }
    
    # Start with house 0 - cost to connect first house is 0
    $minDist[0] = 0
    $totalCost = 0
    
    # We need to add n houses to the MST
    for ($count = 0; $count -lt $n; $count++) {
        # Find the unvisited house with minimum distance to MST
        $minCost = [int]::MaxValue
        $u = -1
        
        for ($i = 0; $i -lt $n; $i++) {
            if (-not $inMST[$i] -and $minDist[$i] -lt $minCost) {
                $minCost = $minDist[$i]
                $u = $i
            }
        }
        
        # Add house u to MST
        $inMST[$u] = $true
        $totalCost += $minCost
        
        # Update minimum distances for all houses not yet in MST
        for ($v = 0; $v -lt $n; $v++) {
            if (-not $inMST[$v]) {
                # Calculate distance from house u to house v
                $dist = Get-ManhattanDistance -point1 $houses[$u] -point2 $houses[$v]
                
                # If this is less than current minimum distance to MST, update it
                if ($dist -lt $minDist[$v]) {
                    $minDist[$v] = $dist
                }
            }
        }
    }
    
    return $totalCost
}

# Alternative implementation using Kruskal's Algorithm with Union-Find
# Included for educational purposes - shows a different approach

function Find-Parent {
    <#
    .SYNOPSIS
        Find the root parent of a node with path compression
    #>
    param(
        [int]$node,
        [int[]]$parent
    )
    
    if ($parent[$node] -ne $node) {
        $parent[$node] = Find-Parent -node $parent[$node] -parent $parent
    }
    return $parent[$node]
}

function Merge-Sets {
    <#
    .SYNOPSIS
        Union two sets using union by rank
    #>
    param(
        [int]$x,
        [int]$y,
        [int[]]$parent,
        [int[]]$rank
    )
    
    $rootX = Find-Parent -node $x -parent $parent
    $rootY = Find-Parent -node $y -parent $parent
    
    if ($rootX -eq $rootY) {
        return $false  # Already in same set
    }
    
    # Union by rank
    if ($rank[$rootX] -lt $rank[$rootY]) {
        $parent[$rootX] = $rootY
    }
    elseif ($rank[$rootX] -gt $rank[$rootY]) {
        $parent[$rootY] = $rootX
    }
    else {
        $parent[$rootY] = $rootX
        $rank[$rootX]++
    }
    
    return $true
}

function Get-MinCostKruskal {
    <#
    .SYNOPSIS
        Alternative solution using Kruskal's Algorithm
    
    .DESCRIPTION
        1. Generate all possible edges with their weights (Manhattan distances)
        2. Sort edges by weight
        3. Use Union-Find to add edges that don't create cycles
        4. Stop when n-1 edges are added (MST complete)
    #>
    param(
        [Parameter(Mandatory=$true)]
        [array]$houses
    )
    
    $n = $houses.Count
    
    if ($n -le 1) {
        return 0
    }
    
    # Generate all edges: [cost, house_i, house_j]
    $edges = @()
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = $i + 1; $j -lt $n; $j++) {
            $cost = Get-ManhattanDistance -point1 $houses[$i] -point2 $houses[$j]
            $edges += ,@($cost, $i, $j)
        }
    }
    
    # Sort edges by cost
    $edges = $edges | Sort-Object { $_[0] }
    
    # Initialize Union-Find
    $parent = 0..($n - 1)
    $rank = @(0) * $n
    
    $totalCost = 0
    $edgesUsed = 0
    
    foreach ($edge in $edges) {
        $cost = $edge[0]
        $u = $edge[1]
        $v = $edge[2]
        
        # Check if adding this edge creates a cycle
        $rootU = Find-Parent -node $u -parent $parent
        $rootV = Find-Parent -node $v -parent $parent
        
        if ($rootU -ne $rootV) {
            # Add edge to MST
            $totalCost += $cost
            $edgesUsed++
            
            # Union the sets
            if ($rank[$rootU] -lt $rank[$rootV]) {
                $parent[$rootU] = $rootV
            }
            elseif ($rank[$rootU] -gt $rank[$rootV]) {
                $parent[$rootV] = $rootU
            }
            else {
                $parent[$rootV] = $rootU
                $rank[$rootU]++
            }
            
            # MST complete when we have n-1 edges
            if ($edgesUsed -eq $n - 1) {
                break
            }
        }
    }
    
    return $totalCost
}

# Functions available when dot-sourcing this script:
# - Get-MinCostToConnectHouses (Prim's Algorithm - recommended)
# - Get-MinCostKruskal (Kruskal's Algorithm - alternative)
# - Get-ManhattanDistance (utility function)

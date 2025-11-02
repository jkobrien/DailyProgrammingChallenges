# Max DAG Edges - PowerShell Solution
# Problem: Find the maximum number of additional edges that can be added to a DAG without forming cycles
# Approach: Mathematical solution - Maximum edges in DAG is V*(V-1)/2, subtract current edges
# Time Complexity: O(V + E), Space Complexity: O(V)

function Find-MaxDAGEdges {
    param(
        [int]$V,                    # Number of vertices (0 to V-1)
        [array]$edges              # Array of directed edges [u, v]
    )
    
    Write-Host "Finding maximum additional edges for DAG with $V vertices and $($edges.Count) edges"
    $edgeStrings = $edges | ForEach-Object { "[$($_ -join ', ')]" }
    $edgeDisplay = if ($edgeStrings.Count -gt 0) { $edgeStrings -join ', ' } else { "none" }
    Write-Host "Current edges: $edgeDisplay"
    
    # Verify input constraints
    if ($V -lt 1 -or $V -gt 1000) {
        throw "Invalid number of vertices: $V. Must be between 1 and 1000."
    }
    
    $E = $edges.Count
    $maxPossibleEdges = $V * ($V - 1) / 2
    
    if ($E -gt $maxPossibleEdges) {
        throw "Too many edges: $E. Maximum possible for $V vertices is $maxPossibleEdges."
    }
    
    Write-Host "Maximum possible edges in a DAG with $V vertices: $maxPossibleEdges"
    Write-Host "Current edges: $E"
    
    # The key insight: In a DAG, we can add edges between any pair of vertices (u,v)
    # as long as it doesn't create a cycle. The maximum number of edges in a DAG
    # is achieved when we have a complete topological ordering.
    
    # For any DAG with V vertices, the maximum number of edges is V*(V-1)/2
    # This is because we can arrange vertices in topological order and add
    # all possible edges that respect this ordering.
    
    $additionalEdges = $maxPossibleEdges - $E
    
    Write-Host "Additional edges that can be added: $additionalEdges"
    
    return $additionalEdges
}

# Alternative approach using reachability matrix (more complex but educational)
function Find-MaxDAGEdges-Detailed {
    param(
        [int]$V,
        [array]$edges
    )
    
    Write-Host ""
    Write-Host "=== Detailed Approach Using Reachability Analysis ==="
    
    # Build adjacency list
    $adjList = @{}
    for ($i = 0; $i -lt $V; $i++) {
        $adjList[$i] = @()
    }
    
    foreach ($edge in $edges) {
        $u = $edge[0]
        $v = $edge[1]
        $adjList[$u] += $v
    }
    
    # Display adjacency list
    $adjListStr = ($adjList.GetEnumerator() | ForEach-Object { "$($_.Key): [$($_.Value -join ', ')]" }) -join "; "
    Write-Host "Adjacency List: {$adjListStr}"
    
    # Build reachability matrix using DFS from each vertex
    $reachable = @{}
    for ($i = 0; $i -lt $V; $i++) {
        $reachable[$i] = @{}
        for ($j = 0; $j -lt $V; $j++) {
            $reachable[$i][$j] = $false
        }
    }
    
    # For each vertex, find all reachable vertices using DFS
    for ($start = 0; $start -lt $V; $start++) {
        $visited = @{}
        for ($i = 0; $i -lt $V; $i++) {
            $visited[$i] = $false
        }
        
        # DFS to find all reachable vertices from $start
        $stack = [System.Collections.Stack]::new()
        $stack.Push($start)
        $visited[$start] = $true
        
        while ($stack.Count -gt 0) {
            $current = $stack.Pop()
            $reachable[$start][$current] = $true
            
            foreach ($neighbor in $adjList[$current]) {
                if (-not $visited[$neighbor]) {
                    $visited[$neighbor] = $true
                    $stack.Push($neighbor)
                }
            }
        }
    }
    
    # Count possible additional edges
    $possibleEdges = 0
    $additionalEdgesList = @()
    
    for ($u = 0; $u -lt $V; $u++) {
        for ($v = 0; $v -lt $V; $v++) {
            if ($u -ne $v) {
                # Check if edge u->v already exists
                $edgeExists = $false
                foreach ($edge in $edges) {
                    if ($edge[0] -eq $u -and $edge[1] -eq $v) {
                        $edgeExists = $true
                        break
                    }
                }
                
                # If edge doesn't exist and adding it won't create a cycle
                if (-not $edgeExists) {
                    # We can add edge u->v if it doesn't create a cycle
                    # This happens when v cannot reach u (no path from v to u)
                    # In other words, adding u->v is safe if there's no path from v back to u
                    if (-not $reachable[$v][$u]) {
                        $possibleEdges++
                        $additionalEdgesList += "($u -> $v)"
                    }
                }
            }
        }
    }
    
    Write-Host "Reachability analysis complete."
    Write-Host "Possible additional edges: $possibleEdges"
    if ($additionalEdgesList.Count -le 10) {
        Write-Host "Additional edges that can be added: $($additionalEdgesList -join ', ')"
    } else {
        Write-Host "Additional edges that can be added: $($additionalEdgesList[0..9] -join ', ')... (and $($additionalEdgesList.Count - 10) more)"
    }
    
    return $possibleEdges
}

# Validation function to verify our mathematical approach
function Validate-Solution {
    param(
        [int]$V,
        [array]$edges,
        [int]$expectedResult
    )
    
    Write-Host ""
    Write-Host "=== Validation ==="
    
    # Method 1: Simple mathematical approach
    $result1 = Find-MaxDAGEdges -V $V -edges $edges
    
    # Method 2: Detailed reachability approach
    $result2 = Find-MaxDAGEdges-Detailed -V $V -edges $edges
    
    Write-Host ""
    Write-Host "Mathematical approach result: $result1"
    Write-Host "Reachability approach result: $result2"
    Write-Host "Expected result: $expectedResult"
    
    $method1Correct = ($result1 -eq $expectedResult)
    $method2Correct = ($result2 -eq $expectedResult)
    $methodsMatch = ($result1 -eq $result2)
    
    Write-Host "Mathematical approach correct: $method1Correct"
    Write-Host "Reachability approach correct: $method2Correct"
    Write-Host "Both methods agree: $methodsMatch"
    
    return @{
        MathResult = $result1
        DetailedResult = $result2
        Expected = $expectedResult
        MathCorrect = $method1Correct
        DetailedCorrect = $method2Correct
        MethodsAgree = $methodsMatch
    }
}

# Main execution function
function Solve-MaxDAGEdges {
    param(
        [int]$V,
        [array]$edges
    )
    
    Write-Host "=== Max DAG Edges Solution ==="
    Write-Host "Vertices: $V (labeled 0 to $($V-1))"
    Write-Host "Edges: $($edges.Count)"
    Write-Host ""
    
    try {
        # Use the efficient mathematical approach
        $result = Find-MaxDAGEdges -V $V -edges $edges
        
        Write-Host ""
        Write-Host "=== Result ==="
        Write-Host "Maximum additional edges: $result" -ForegroundColor Green
        
        return $result
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        return -1
    }
}

# Example usage and testing
Write-Host "Max DAG Edges - PowerShell Implementation"
Write-Host "========================================="
Write-Host ""

# Test Example 1: V = 3, edges = [[0, 1], [1, 2]]
Write-Host "Example 1:"
$result1 = Solve-MaxDAGEdges -V 3 -edges @(@(0, 1), @(1, 2))
$validation1 = Validate-Solution -V 3 -edges @(@(0, 1), @(1, 2)) -expectedResult 1
Write-Host ""

# Test Example 2: V = 4, edges = [[0, 1], [0, 2], [1, 2], [2, 3]]
Write-Host "Example 2:"
$result2 = Solve-MaxDAGEdges -V 4 -edges @(@(0, 1), @(0, 2), @(1, 2), @(2, 3))
$validation2 = Validate-Solution -V 4 -edges @(@(0, 1), @(0, 2), @(1, 2), @(2, 3)) -expectedResult 2
Write-Host ""

# Test Example 3: Empty graph
Write-Host "Example 3 (Empty Graph):"
$result3 = Solve-MaxDAGEdges -V 3 -edges @()
Write-Host "Expected: $((3 * 2) / 2) edges can be added to empty graph"
Write-Host ""

# Test Example 4: Single vertex
Write-Host "Example 4 (Single Vertex):"
$result4 = Solve-MaxDAGEdges -V 1 -edges @()
Write-Host "Expected: 0 edges (no edges possible with single vertex)"
Write-Host ""

Write-Host "All examples completed!"

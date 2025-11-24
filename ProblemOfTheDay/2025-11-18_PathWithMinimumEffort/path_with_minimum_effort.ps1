<#
.SYNOPSIS
    Path With Minimum Effort - GeeksforGeeks Problem of the Day (November 18, 2025)

.DESCRIPTION
    Find the minimum possible path cost from top-left to bottom-right cell in a 2D matrix.
    The cost is defined as the maximum absolute difference between consecutive cells in the path.
    
    Uses Modified Dijkstra's Algorithm with a priority queue to find the optimal path.

.EXAMPLE
    $matrix = @(@(7, 2, 6, 5), @(3, 1, 10, 8))
    Get-MinimumEffortPath -matrix $matrix
    # Output: 4

.NOTES
    Time Complexity: O(n * m * log(n * m))
    Space Complexity: O(n * m)
    
    Algorithm:
    1. Use priority queue (min-heap) to process cells with minimum effort first
    2. Track minimum effort to reach each cell
    3. For each cell, explore 4 directions (up, down, left, right)
    4. Update effort = max(current_effort, abs_diff_with_neighbor)
    5. Return effort when destination is reached
#>

# Priority Queue implementation using .NET SortedSet
class PriorityQueueItem {
    [int]$Effort
    [int]$Row
    [int]$Col
    
    PriorityQueueItem([int]$effort, [int]$row, [int]$col) {
        $this.Effort = $effort
        $this.Row = $row
        $this.Col = $col
    }
}

class PriorityQueue {
    [System.Collections.Generic.List[PriorityQueueItem]]$items
    
    PriorityQueue() {
        $this.items = [System.Collections.Generic.List[PriorityQueueItem]]::new()
    }
    
    [void]Enqueue([int]$effort, [int]$row, [int]$col) {
        $item = [PriorityQueueItem]::new($effort, $row, $col)
        $this.items.Add($item)
    }
    
    [PriorityQueueItem]Dequeue() {
        if ($this.items.Count -eq 0) {
            return $null
        }
        
        # Find minimum effort item
        $minIndex = 0
        $minEffort = $this.items[0].Effort
        
        for ($i = 1; $i -lt $this.items.Count; $i++) {
            if ($this.items[$i].Effort -lt $minEffort) {
                $minEffort = $this.items[$i].Effort
                $minIndex = $i
            }
        }
        
        $item = $this.items[$minIndex]
        $this.items.RemoveAt($minIndex)
        return $item
    }
    
    [bool]IsEmpty() {
        return $this.items.Count -eq 0
    }
    
    [int]Count() {
        return $this.items.Count
    }
}

function Get-MinimumEffortPath {
    <#
    .SYNOPSIS
        Finds the minimum effort path from top-left to bottom-right in a matrix.
    
    .PARAMETER matrix
        2D array representing the grid
    
    .OUTPUTS
        Integer representing the minimum effort required
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int[][]]$matrix
    )
    
    $n = $matrix.Count
    if ($n -eq 0) { return 0 }
    $m = $matrix[0].Count
    if ($m -eq 0) { return 0 }
    
    # Special case: already at destination
    if ($n -eq 1 -and $m -eq 1) {
        return 0
    }
    
    # Initialize effort matrix with infinity
    $effort = New-Object 'int[,]' $n, $m
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = 0; $j -lt $m; $j++) {
            $effort[$i, $j] = [int]::MaxValue
        }
    }
    $effort[0, 0] = 0
    
    # Priority queue: (effort, row, col)
    $pq = [PriorityQueue]::new()
    $pq.Enqueue(0, 0, 0)
    
    # Directions: up, down, left, right
    $directions = @(
        @(-1, 0),  # up
        @(1, 0),   # down
        @(0, -1),  # left
        @(0, 1)    # right
    )
    
    while (-not $pq.IsEmpty()) {
        $current = $pq.Dequeue()
        $currentEffort = $current.Effort
        $row = $current.Row
        $col = $current.Col
        
        # If we reached the destination, return the effort
        if ($row -eq ($n - 1) -and $col -eq ($m - 1)) {
            return $currentEffort
        }
        
        # Skip if we've already found a better path to this cell
        if ($currentEffort -gt $effort[$row, $col]) {
            continue
        }
        
        # Explore all 4 directions
        foreach ($dir in $directions) {
            $newRow = $row + $dir[0]
            $newCol = $col + $dir[1]
            
            # Check bounds
            if ($newRow -ge 0 -and $newRow -lt $n -and 
                $newCol -ge 0 -and $newCol -lt $m) {
                
                # Calculate effort to reach neighbor
                $diff = [Math]::Abs($matrix[$row][$col] - $matrix[$newRow][$newCol])
                $newEffort = [Math]::Max($currentEffort, $diff)
                
                # If we found a better path, update and enqueue
                if ($newEffort -lt $effort[$newRow, $newCol]) {
                    $effort[$newRow, $newCol] = $newEffort
                    $pq.Enqueue($newEffort, $newRow, $newCol)
                }
            }
        }
    }
    
    # Should not reach here if input is valid
    return $effort[$n - 1, $m - 1]
}

# Main execution block
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=== Path With Minimum Effort ===" -ForegroundColor Cyan
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $matrix1 = @(
        @(7, 2, 6, 5),
        @(3, 1, 10, 8)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $matrix1) {
        Write-Host "  [$($row -join ', ')]"
    }
    $result1 = Get-MinimumEffortPath -matrix $matrix1
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 4"
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $matrix2 = @(
        @(2, 2, 2, 1),
        @(8, 1, 2, 7),
        @(2, 2, 2, 8),
        @(2, 1, 4, 7),
        @(2, 2, 2, 2)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $matrix2) {
        Write-Host "  [$($row -join ', ')]"
    }
    $result2 = Get-MinimumEffortPath -matrix $matrix2
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 0"
    Write-Host ""
    
    # Example 3: Single cell
    Write-Host "Example 3 (Edge Case - Single Cell):" -ForegroundColor Yellow
    $matrix3 = @(@(5))
    Write-Host "Input Matrix: [[5]]"
    $result3 = Get-MinimumEffortPath -matrix $matrix3
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: 0"
    Write-Host ""
    
    # Example 4: Uniform matrix
    Write-Host "Example 4 (All Same Values):" -ForegroundColor Yellow
    $matrix4 = @(
        @(1, 1, 1),
        @(1, 1, 1),
        @(1, 1, 1)
    )
    Write-Host "Input Matrix:"
    foreach ($row in $matrix4) {
        Write-Host "  [$($row -join ', ')]"
    }
    $result4 = Get-MinimumEffortPath -matrix $matrix4
    Write-Host "Output: $result4" -ForegroundColor Green
    Write-Host "Expected: 0"
    Write-Host ""
    
    Write-Host "=== Algorithm Explanation ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Modified Dijkstra's Algorithm:" -ForegroundColor White
    Write-Host "1. Use priority queue to process cells with minimum effort first"
    Write-Host "2. Track minimum effort to reach each cell"
    Write-Host "3. For each cell, explore 4 directions (up, down, left, right)"
    Write-Host "4. Effort to neighbor = max(current_effort, abs_diff_with_neighbor)"
    Write-Host "5. Update if we find a better path to the neighbor"
    Write-Host "6. Return effort when destination is reached"
    Write-Host ""
    Write-Host "Time Complexity: O(n * m * log(n * m))" -ForegroundColor Magenta
    Write-Host "Space Complexity: O(n * m)" -ForegroundColor Magenta
}

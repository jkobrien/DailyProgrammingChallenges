<#
.SYNOPSIS
    Course Schedule I - GeeksforGeeks Problem of the Day (March 23, 2026)

.DESCRIPTION
    Determines if it's possible to complete all n courses given prerequisite constraints.
    This is a cycle detection problem in a directed graph.
    
    Problem Link: https://www.geeksforgeeks.org/problems/course-schedule-i/1

.NOTES
    Approach: Kahn's Algorithm (BFS-based Topological Sort)
    Time Complexity: O(n + m) where m = number of prerequisites
    Space Complexity: O(n + m)
    
    Key Insight: If we can topologically sort all n nodes, there's no cycle,
    meaning all courses can be completed.
#>

function CanFinish {
    <#
    .SYNOPSIS
        Determines if all courses can be completed given prerequisites.
    
    .PARAMETER n
        Number of courses (labeled 0 to n-1)
    
    .PARAMETER prerequisites
        2D array where prerequisites[i] = [x, y] means course y must be taken before course x
    
    .OUTPUTS
        Boolean - true if all courses can be completed, false otherwise
    
    .EXAMPLE
        CanFinish -n 4 -prerequisites @(@(2,0), @(2,1), @(3,2))
        # Returns: true
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int]$n,
        
        [Parameter(Mandatory=$false)]
        [array]$prerequisites = @()
    )
    
    # Edge case: No courses or no prerequisites
    if ($n -le 0) {
        return $true
    }
    
    if ($null -eq $prerequisites -or $prerequisites.Count -eq 0) {
        return $true  # No dependencies, all courses can be completed
    }
    
    # Step 1: Build adjacency list and calculate in-degrees
    # adjList[i] contains all courses that depend on course i
    $adjList = @{}
    for ($i = 0; $i -lt $n; $i++) {
        $adjList[$i] = [System.Collections.ArrayList]::new()
    }
    
    # In-degree: number of prerequisites for each course
    $inDegree = [int[]]::new($n)
    
    # Build the graph
    foreach ($prereq in $prerequisites) {
        $course = $prereq[0]        # Course that has a prerequisite
        $prerequisite = $prereq[1]  # The required prerequisite
        
        # Edge: prerequisite -> course (prerequisite must be completed before course)
        [void]$adjList[$prerequisite].Add($course)
        $inDegree[$course]++
    }
    
    # Step 2: Initialize queue with all courses having no prerequisites (in-degree = 0)
    $queue = [System.Collections.Queue]::new()
    for ($i = 0; $i -lt $n; $i++) {
        if ($inDegree[$i] -eq 0) {
            $queue.Enqueue($i)
        }
    }
    
    # Step 3: Process courses using BFS (Kahn's Algorithm)
    $completedCourses = 0
    
    while ($queue.Count -gt 0) {
        $currentCourse = $queue.Dequeue()
        $completedCourses++
        
        # For each course that depends on currentCourse
        foreach ($dependentCourse in $adjList[$currentCourse]) {
            # One less prerequisite needed
            $inDegree[$dependentCourse]--
            
            # If all prerequisites are satisfied, add to queue
            if ($inDegree[$dependentCourse] -eq 0) {
                $queue.Enqueue($dependentCourse)
            }
        }
    }
    
    # Step 4: If we processed all courses, no cycle exists
    return $completedCourses -eq $n
}


function CanFinish-DFS {
    <#
    .SYNOPSIS
        Alternative implementation using DFS with cycle detection.
    
    .DESCRIPTION
        Uses three-state coloring:
        - 0 (White): Unvisited
        - 1 (Gray): Currently being processed (in recursion stack)
        - 2 (Black): Completely processed
        
        A cycle exists if we encounter a Gray node during DFS.
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int]$n,
        
        [Parameter(Mandatory=$false)]
        [array]$prerequisites = @()
    )
    
    if ($n -le 0) {
        return $true
    }
    
    if ($null -eq $prerequisites -or $prerequisites.Count -eq 0) {
        return $true
    }
    
    # Build adjacency list
    $adjList = @{}
    for ($i = 0; $i -lt $n; $i++) {
        $adjList[$i] = [System.Collections.ArrayList]::new()
    }
    
    foreach ($prereq in $prerequisites) {
        $course = $prereq[0]
        $prerequisite = $prereq[1]
        [void]$adjList[$prerequisite].Add($course)
    }
    
    # State array: 0 = unvisited, 1 = visiting, 2 = visited
    $state = [int[]]::new($n)
    
    # DFS function to detect cycle
    function HasCycle {
        param([int]$node)
        
        if ($state[$node] -eq 1) {
            # Found a node that's currently being processed = cycle!
            return $true
        }
        
        if ($state[$node] -eq 2) {
            # Already fully processed, no cycle through this path
            return $false
        }
        
        # Mark as currently processing
        $state[$node] = 1
        
        # Visit all neighbors
        foreach ($neighbor in $adjList[$node]) {
            if (HasCycle -node $neighbor) {
                return $true
            }
        }
        
        # Mark as fully processed
        $state[$node] = 2
        return $false
    }
    
    # Check each node for cycles
    for ($i = 0; $i -lt $n; $i++) {
        if ($state[$i] -eq 0) {
            if (HasCycle -node $i) {
                return $false  # Cycle found, cannot complete all courses
            }
        }
    }
    
    return $true  # No cycle found
}


function Solve-CourseScheduleI {
    <#
    .SYNOPSIS
        Main function to solve Course Schedule I with verbose output.
    #>
    param(
        [int]$n,
        [array]$prerequisites = @()
    )
    
    Write-Host "=== Course Schedule I ===" -ForegroundColor Cyan
    Write-Host "Number of courses: $n (labeled 0 to $($n-1))" -ForegroundColor White
    Write-Host "Number of prerequisites: $($prerequisites.Count)" -ForegroundColor White
    
    if ($prerequisites.Count -gt 0) {
        Write-Host "Prerequisites:" -ForegroundColor Yellow
        foreach ($prereq in $prerequisites) {
            Write-Host "  Course $($prereq[0]) requires Course $($prereq[1])" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    
    # Solve using Kahn's Algorithm
    $result = CanFinish -n $n -prerequisites $prerequisites
    
    Write-Host "Result: " -NoNewline
    if ($result) {
        Write-Host "TRUE - All courses can be completed!" -ForegroundColor Green
    } else {
        Write-Host "FALSE - Impossible due to cyclic dependencies!" -ForegroundColor Red
    }
    
    Write-Host ""
    return $result
}


# Note: Functions are automatically available when dot-sourced
# To use in a module, uncomment the following line:
# Export-ModuleMember -Function CanFinish, CanFinish-DFS, Solve-CourseScheduleI

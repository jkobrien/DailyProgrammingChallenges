# Course Schedule II - PowerShell Solution
# Problem: Find the ordering of courses to complete all courses given prerequisites
# Approach: Topological Sorting using Kahn's Algorithm (BFS)
# Time Complexity: O(n + m), Space Complexity: O(n + m)

function Find-CourseOrder {
    param(
        [int]$n,                    # Number of courses (0 to n-1)
        [array]$prerequisites       # Array of prerequisite pairs [course, prerequisite]
    )
    
    Write-Host "Finding course order for $n courses with prerequisites: $($prerequisites | ConvertTo-Json -Compress)"
    
    # Step 1: Initialize data structures
    # Adjacency list to represent the graph
    $adjList = @{}
    for ($i = 0; $i -lt $n; $i++) {
        $adjList[$i] = @()
    }
    
    # In-degree array to track number of prerequisites for each course
    $inDegree = @(0) * $n
    
    # Step 2: Build the graph and calculate in-degrees
    foreach ($prereq in $prerequisites) {
        $course = $prereq[0]        # Course that has a prerequisite
        $prerequisite = $prereq[1]  # Required prerequisite course
        
        # Add edge from prerequisite to course
        $adjList[$prerequisite] += $course
        # Increment in-degree of the course
        $inDegree[$course]++
    }
    
    # Display adjacency list in a readable format
    $adjListStr = ($adjList.GetEnumerator() | ForEach-Object { "$($_.Key): [$($_.Value -join ', ')]" }) -join "; "
    Write-Host "Adjacency List: {$adjListStr}"
    Write-Host "In-degrees: $($inDegree -join ', ')"
    
    # Step 3: Initialize queue with courses having 0 in-degree
    $queue = [System.Collections.Queue]::new()
    for ($i = 0; $i -lt $n; $i++) {
        if ($inDegree[$i] -eq 0) {
            $queue.Enqueue($i)
            Write-Host "Course $i has no prerequisites, adding to queue"
        }
    }
    
    # Step 4: Process courses using BFS (Kahn's Algorithm)
    $result = @()
    $processedCount = 0
    
    while ($queue.Count -gt 0) {
        # Take a course with no remaining prerequisites
        $currentCourse = $queue.Dequeue()
        $result += $currentCourse
        $processedCount++
        
        Write-Host "Processing course $currentCourse (processed: $processedCount/$n)"
        
        # Process all courses that depend on current course
        foreach ($dependentCourse in $adjList[$currentCourse]) {
            # Reduce in-degree of dependent course
            $inDegree[$dependentCourse]--
            
            # If dependent course has no more prerequisites, add to queue
            if ($inDegree[$dependentCourse] -eq 0) {
                $queue.Enqueue($dependentCourse)
                Write-Host "Course $dependentCourse now has no prerequisites, adding to queue"
            }
        }
    }
    
    # Step 5: Check if all courses were processed
    if ($processedCount -eq $n) {
        Write-Host "SUCCESS: All courses can be completed in order: $($result -join ' -> ')"
        return $result
    } else {
        Write-Host "IMPOSSIBLE: Cycle detected! Only $processedCount out of $n courses can be completed"
        return @()  # Return empty array if impossible
    }
}

# Helper function to validate the solution
function Test-CourseOrder {
    param(
        [int]$n,
        [array]$prerequisites,
        [array]$order
    )
    
    if ($order.Count -eq 0) {
        return $false
    }
    
    if ($order.Count -ne $n) {
        return $false
    }
    
    # Create position map for quick lookup
    $position = @{}
    for ($i = 0; $i -lt $order.Count; $i++) {
        $position[$order[$i]] = $i
    }
    
    # Check each prerequisite constraint
    foreach ($prereq in $prerequisites) {
        $course = $prereq[0]
        $prerequisite = $prereq[1]
        
        # Prerequisite must come before the course in the order
        if ($position[$prerequisite] -ge $position[$course]) {
            Write-Host "VALIDATION FAILED: Course $prerequisite (prerequisite) comes after course $course"
            return $false
        }
    }
    
    Write-Host "VALIDATION PASSED: Order satisfies all prerequisites"
    return $true
}

# Main execution function
function Solve-CourseScheduleII {
    param(
        [int]$n,
        [array]$prerequisites
    )
    
    Write-Host "=== Course Schedule II Solution ==="
    Write-Host "Courses: $n (labeled 0 to $($n-1))"
    Write-Host "Prerequisites: $($prerequisites.Count) pairs"
    Write-Host ""
    
    # Find the course order
    $order = Find-CourseOrder -n $n -prerequisites $prerequisites
    
    Write-Host ""
    Write-Host "=== Result ==="
    if ($order.Count -gt 0) {
        Write-Host "Course Order: [$($order -join ', ')]"
        
        # Validate the solution
        $isValid = Test-CourseOrder -n $n -prerequisites $prerequisites -order $order
        Write-Host "Valid Solution: $isValid"
        return $order
    } else {
        Write-Host "No valid course order exists (cycle detected)"
        return @()
    }
}

# Example usage and testing
Write-Host "Course Schedule II - PowerShell Implementation"
Write-Host "=============================================="
Write-Host ""

# Test Example 1: n = 3, prerequisites = [[1, 0], [2, 1]]
Write-Host "Example 1:"
$result1 = Solve-CourseScheduleII -n 3 -prerequisites @(@(1, 0), @(2, 1))
Write-Host ""

# Test Example 2: n = 4, prerequisites = [[2, 0], [2, 1], [3, 2]]
Write-Host "Example 2:"
$result2 = Solve-CourseScheduleII -n 4 -prerequisites @(@(2, 0), @(2, 1), @(3, 2))
Write-Host ""

# Test Example 3: Impossible case with cycle
Write-Host "Example 3 (Cycle):"
$result3 = Solve-CourseScheduleII -n 3 -prerequisites @(@(0, 1), @(1, 2), @(2, 0))
Write-Host ""

Write-Host "All examples completed!"

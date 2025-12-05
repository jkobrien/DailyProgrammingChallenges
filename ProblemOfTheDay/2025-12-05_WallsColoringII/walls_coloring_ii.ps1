<#
.SYNOPSIS
    Solves the Walls Coloring II problem from GeeksforGeeks.

.DESCRIPTION
    Finds the minimum cost to paint n walls with k colors such that no two adjacent walls
    have the same color. Uses dynamic programming with space optimization to achieve O(1) space.

.PARAMETER costs
    2D array where costs[i][j] represents the cost of painting wall i with color j.

.RETURNS
    The minimum total cost to paint all walls, or -1 if impossible.

.EXAMPLE
    $costs = @(
        @(1, 5, 7),
        @(5, 8, 4),
        @(3, 2, 9),
        @(1, 2, 4)
    )
    Get-MinCostToPaintWalls -costs $costs
    # Returns: 8
#>

function Get-MinCostToPaintWalls {
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyCollection()]
        [array]$costs = @()
    )

    # Get dimensions
    $n = $costs.Count
    
    # Edge case: no walls
    if ($n -eq 0) {
        return 0
    }
    
    $k = $costs[0].Count
    
    # Edge case: no colors available
    if ($k -eq 0) {
        return 0
    }
    
    # Edge case: only 1 color but multiple walls - impossible
    if ($k -lt 2 -and $n -gt 1) {
        return -1
    }
    
    # Edge case: only 1 wall - return minimum cost color for that wall
    if ($n -eq 1) {
        $minCost = [int]::MaxValue
        for ($j = 0; $j -lt $k; $j++) {
            if ($costs[0][$j] -lt $minCost) {
                $minCost = $costs[0][$j]
            }
        }
        return $minCost
    }
    
    # Initialize for the first wall
    # Find minimum and second minimum costs for first wall
    $prevMin = [int]::MaxValue
    $prevSecondMin = [int]::MaxValue
    $prevMinColor = -1
    
    for ($j = 0; $j -lt $k; $j++) {
        $cost = $costs[0][$j]
        
        if ($cost -lt $prevMin) {
            $prevSecondMin = $prevMin
            $prevMin = $cost
            $prevMinColor = $j
        }
        elseif ($cost -lt $prevSecondMin) {
            $prevSecondMin = $cost
        }
    }
    
    # Process remaining walls
    for ($i = 1; $i -lt $n; $i++) {
        $currMin = [int]::MaxValue
        $currSecondMin = [int]::MaxValue
        $currMinColor = -1
        
        # Try each color for current wall
        for ($j = 0; $j -lt $k; $j++) {
            # Calculate cost for painting current wall with color j
            if ($j -eq $prevMinColor) {
                # If using same color as prev min, use prev second min
                $cost = $prevSecondMin + $costs[$i][$j]
            }
            else {
                # Otherwise, use prev min
                $cost = $prevMin + $costs[$i][$j]
            }
            
            # Update current min and second min
            if ($cost -lt $currMin) {
                $currSecondMin = $currMin
                $currMin = $cost
                $currMinColor = $j
            }
            elseif ($cost -lt $currSecondMin) {
                $currSecondMin = $cost
            }
        }
        
        # Update for next iteration
        $prevMin = $currMin
        $prevSecondMin = $currSecondMin
        $prevMinColor = $currMinColor
    }
    
    return $prevMin
}

<#
.SYNOPSIS
    Main execution block for testing the solution.
#>

# Example 1: Expected output = 8
Write-Host "Example 1:" -ForegroundColor Cyan
$costs1 = @(
    @(1, 5, 7),
    @(5, 8, 4),
    @(3, 2, 9),
    @(1, 2, 4)
)
$result1 = Get-MinCostToPaintWalls -costs $costs1
Write-Host "Input: n = 4, k = 3"
Write-Host "costs = [[1, 5, 7], [5, 8, 4], [3, 2, 9], [1, 2, 4]]"
Write-Host "Output: $result1" -ForegroundColor Green
Write-Host "Expected: 8"
Write-Host ""

# Example 2: Expected output = -1
Write-Host "Example 2:" -ForegroundColor Cyan
$costs2 = @(
    @(5),
    @(4),
    @(9),
    @(2),
    @(1)
)
$result2 = Get-MinCostToPaintWalls -costs $costs2
Write-Host "Input: n = 5, k = 1"
Write-Host "costs = [[5], [4], [9], [2], [1]]"
Write-Host "Output: $result2" -ForegroundColor Green
Write-Host "Expected: -1"
Write-Host ""

# Additional test case: 3 walls, 3 colors
Write-Host "Example 3:" -ForegroundColor Cyan
$costs3 = @(
    @(3, 5, 3),
    @(6, 17, 6),
    @(7, 13, 18)
)
$result3 = Get-MinCostToPaintWalls -costs $costs3
Write-Host "Input: n = 3, k = 3"
Write-Host "costs = [[3, 5, 3], [6, 17, 6], [7, 13, 18]]"
Write-Host "Output: $result3" -ForegroundColor Green
Write-Host "Expected: 16 (Paint: color 0 -> color 2 -> color 0: 3 + 6 + 7 = 16)"
Write-Host ""

<#
EXPLANATION OF THE SOLUTION:

This problem is solved using Dynamic Programming with space optimization.

Key Concepts:
1. We can't paint two adjacent walls with the same color
2. We need to minimize the total cost
3. For each wall, we need to know the minimum costs from the previous wall

Space Optimization Technique:
Instead of maintaining a full DP table of size n*k, we only track:
- prevMin: The minimum cost to paint the previous wall
- prevSecondMin: The second minimum cost to paint the previous wall  
- prevMinColor: Which color gave us the minimum cost for the previous wall

Why track second minimum?
If we want to use the same color that gave minimum cost in the previous wall,
we can't (adjacent walls can't have same color). So we need the second best option.

Algorithm Flow:
1. Initialize with first wall:
   - Find minimum and second minimum costs among all colors
   - Track which color gave the minimum

2. For each subsequent wall:
   - For each color j:
     * If j equals the previous minimum color → use previous second minimum
     * Otherwise → use previous minimum
     * Add current wall's cost for color j
   - Find new minimum and second minimum for this wall

3. Return the final minimum cost

Time Complexity: O(n*k)
- n walls, for each wall we check k colors

Space Complexity: O(1)
- Only using a constant number of variables regardless of input size
#>

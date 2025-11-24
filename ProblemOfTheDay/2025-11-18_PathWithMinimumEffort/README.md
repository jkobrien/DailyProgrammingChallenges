# Path With Minimum Effort

**Difficulty:** Medium  
**Accuracy:** 53.13%  
**Company Tags:** Bloomberg, Amazon, Microsoft, Google  
**Topic Tags:** Graph, DFS, BFS

## Problem Statement

You are given a 2D array `mat[][]`, of size `n*m`. Your task is to find the **minimum** possible **path cost** from the top-left cell (0, 0) to the bottom-right cell (n-1, m-1) by moving up, down, left, or right between adjacent cells.

**Note:** The cost of a path is defined as the maximum absolute difference between the values of any two consecutive cells along that path.

## Examples

### Example 1:
```
Input: mat[][] = [[7, 2, 6, 5],  
                  [3, 1, 10, 8]]
Output: 4
Explanation: The route of [7, 3, 1, 2, 6, 5, 8] has a minimum value of 
maximum absolute difference between any two consecutive cells in the 
route, i.e., 4.
```

### Example 2:
```
Input: mat[][] = [[2, 2, 2, 1],  
                  [8, 1, 2, 7],  
                  [2, 2, 2, 8],  
                  [2, 1, 4, 7],  
                  [2, 2, 2, 2]]
Output: 0
Explanation: The route of [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2] has a 
minimum value of maximum absolute difference between any two consecutive 
cells in the route, i.e., 0.
```

## Constraints
- 1 ≤ n, m ≤ 100
- 0 ≤ mat[i][j] ≤ 10^6

## Expected Complexities
- **Time Complexity:** O(n * m log (n * m))
- **Auxiliary Space:** O(n * m)

## Approach

This problem can be solved using **Modified Dijkstra's Algorithm**:

1. **Key Insight:** Instead of finding shortest path with sum of weights, we need to find path where the maximum edge weight (absolute difference) is minimized.

2. **Algorithm:**
   - Use a priority queue (min-heap) to always process the cell with minimum effort first
   - Track the minimum effort required to reach each cell
   - For each cell, explore all 4 directions (up, down, left, right)
   - Update the effort to reach neighbor cells if we find a better path
   - The effort to reach a neighbor is the maximum of:
     - Current effort to reach current cell
     - Absolute difference between current cell and neighbor cell

3. **Why Dijkstra's?**
   - We need to minimize the maximum edge weight along a path
   - Dijkstra's greedy approach works here because once we reach the destination with minimum effort, we can't find a better path

## Solution

See `path_with_minimum_effort.ps1` for the complete implementation.

## Testing

Run the test file:
```powershell
.\test_path_with_minimum_effort.ps1

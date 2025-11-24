# Second Best Minimum Spanning Tree

**Difficulty:** Medium  
**Accuracy:** 54.18%  
**Date:** November 24, 2025

## Problem Statement

Given an undirected graph of **V** vertices numbered from (0 to V-1) and **E** edges represented by a 2D array **edges[][]**, where each edges[i] contains three integers **[u, v, w]**, representing an undirected edge from u to v, having weight w.

Your task is to find the weight of the **second** best minimum spanning tree of the given graph.

A second best MST is defined as the minimum-weight spanning tree whose total weight is strictly greater than the weight of the minimum spanning tree.

**Note:** If no such second best MST exists, return -1.

## Examples

### Example 1:
**Input:** 
- V = 5, E = 7
- edges[][] = [[0, 1, 4], [0, 2, 3], [1, 2, 1], [1, 3, 5], [2, 4, 10], [2, 3, 7], [3, 4, 2]]

**Output:** 12

**Explanation:** The MST has weight 11 (edges: 1-2, 0-2, 3-4, 1-3). The second best MST has weight 12.

### Example 2:
**Input:** 
- V = 5, E = 4
- edges[][] = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]]

**Output:** -1

**Explanation:** No second best MST exists for this graph (it's a tree, so there's only one spanning tree).

## Constraints
- 1 ≤ V ≤ 100
- V-1 ≤ E ≤ V*(V-1)/2
- 0 ≤ edges[i][2] ≤ 10³

## Approach

### Algorithm Overview
1. **Find the MST** using Kruskal's algorithm with Union-Find
2. **Mark MST edges** to identify which edges are in the optimal MST
3. **Find Second Best MST** by trying to replace each MST edge with a non-MST edge:
   - For each edge in MST, temporarily exclude it
   - Build a new MST without that edge
   - The minimum weight among all such MSTs that is strictly greater than the original MST weight is the answer

### Key Concepts
- **Kruskal's Algorithm:** Greedy algorithm that sorts edges by weight and adds them if they don't create a cycle
- **Union-Find (Disjoint Set Union):** Efficient data structure for tracking connected components
- **Second Best MST:** By replacing one edge from the MST with a non-MST edge, we can find alternative spanning trees

### Time Complexity
- O(V * E) - We potentially rebuild the MST E times
- Sorting edges: O(E log E)
- Each MST construction: O(E * α(V)) where α is inverse Ackermann function

### Space Complexity
- O(V + E) - For storing the graph and Union-Find structure

## Solution

See `second_best_mst.ps1` for the complete PowerShell implementation.

## Testing

Run the test suite:
```powershell
.\test_second_best_mst.ps1
```

## Related Topics
- Graph Theory
- Minimum Spanning Tree
- Kruskal's Algorithm
- Union-Find (Disjoint Set Union)
- Greedy Algorithms

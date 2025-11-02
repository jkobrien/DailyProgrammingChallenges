# Max DAG Edges - November 2, 2025

## Problem Statement

Given a directed acyclic graph (DAG) with **V** vertices numbered from 0 to V-1 and **E** edges, represented as a 2D array **edges[][]**, where each entry **edges[i] = [u, v]** denotes a directed edge from vertex **u** to vertex **v**, find the maximum number of additional edges that can be added to the graph without forming any cycles.

**Note:** The resulting graph must remain a DAG, meaning that adding any further edge would not create a cycle.

## Examples

**Example 1:**
- **Input:** V = 3, E = 2, edges[][] = [[0, 1], [1, 2]]
- **Output:** 1
- **Explanation:** The given DAG allows one more edge, 0 -> 2, which keeps the structure acyclic. Adding anything else would create a cycle.

**Example 2:**
- **Input:** V = 4, E = 4, edges[][] = [[0, 1], [0, 2], [1, 2], [2, 3]]
- **Output:** 2
- **Explanation:** Two additional edges (0 -> 3, 1 -> 3) can be added without forming cycles.

## Constraints

- 1 ≤ V ≤ 10³
- 0 ≤ E ≤ (V*(V-1))/2
- 0 ≤ edges[i][0], edges[i][1] < V

## Expected Complexities

- **Time Complexity:** O(V²) for topological sorting and reachability analysis
- **Auxiliary Space:** O(V²) for adjacency matrix and reachability matrix

## Algorithm Approach

This problem is about finding the **maximum number of edges that can be added to a DAG without creating cycles**. The key insight is:

1. **Maximum possible edges in a DAG:** A complete DAG with V vertices can have at most **V*(V-1)/2** edges (this would be a tournament graph where every pair of vertices has exactly one directed edge).

2. **Current edges:** Count the existing edges in the given DAG.

3. **Transitive closure:** Find all pairs of vertices (u,v) where there's already a path from u to v. Adding a direct edge from u to v wouldn't add any new reachability, but it also wouldn't create a cycle.

4. **Missing edges:** For any pair (u,v) where u can't reach v in the current DAG, we can potentially add an edge u->v without creating a cycle, as long as v can't reach u either.

### Solution Strategy:

1. **Build reachability matrix:** Use DFS/BFS from each vertex to find all vertices reachable from it
2. **Count possible edges:** For each pair (u,v), if u cannot reach v AND v cannot reach u, then we can add edge u->v
3. **Calculate result:** Total possible edges - current edges = additional edges possible

### Alternative Mathematical Approach:

For a DAG, the maximum number of edges is achieved when we have a **topological ordering** and we can add all edges (u,v) where u comes before v in the topological order. This gives us exactly **V*(V-1)/2** edges total.

So the answer is: **V*(V-1)/2 - E** where E is the current number of edges.

However, we need to verify this works for the given examples and constraints.

## Tags
- **Difficulty:** Medium
- **Topics:** Graph, DAG, Topological Sort, Mathematical
- **Company:** Not specified

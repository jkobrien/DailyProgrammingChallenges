# Minimum Cost to Connect All Houses in a City

**Date:** March 30, 2026  
**Difficulty:** Medium  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/minimum-cost-to-connect-all-houses-in-a-city/1)

## Problem Statement

Given a 2D array `houses[][]`, consisting of `n` 2D coordinates `{x, y}` where each coordinate represents the location of each house, find the **minimum cost to connect all the houses** of the city.

The **cost of connecting** two houses is the **Manhattan Distance** between the two points $(x_i, y_i)$ and $(x_j, y_j)$:

$$|x_i - x_j| + |y_i - y_j|$$

where $|p|$ denotes the absolute value of $p$.

## Examples

### Example 1
```
Input: n = 5, houses[][] = [[0, 7], [0, 9], [20, 7], [30, 7], [40, 70]]
Output: 105
Explanation:
- Connect house 1 (0, 7) and house 2 (0, 9) with cost = 2
- Connect house 1 (0, 7) and house 3 (20, 7) with cost = 20
- Connect house 3 (20, 7) with house 4 (30, 7) with cost = 10 
- Connect house 4 (30, 7) with house 5 (40, 70) with cost = 73
- Total minimum cost = 2 + 10 + 20 + 73 = 105
```

### Example 2
```
Input: n = 4, houses[][] = [[0, 0], [1, 1], [1, 3], [3, 0]]
Output: 7
Explanation:
- Connect house 1 (0, 0) with house 2 (1, 1) with cost = 2
- Connect house 2 (1, 1) with house 3 (1, 3) with cost = 2 
- Connect house 1 (0, 0) with house 4 (3, 0) with cost = 3 
- Total minimum cost = 3 + 2 + 2 = 7
```

## Constraints
- $1 \le n \le 10^3$
- $0 \le houses[i][j] \le 10^3$

## Solution Approach

This is a classic **Minimum Spanning Tree (MST)** problem where:
- Each house is a node in the graph
- The edge weight between any two houses is their Manhattan distance
- We need to find the MST that connects all houses with minimum total weight

### Algorithm: Prim's Algorithm

We use **Prim's Algorithm** which is efficient for dense graphs (where every node connects to every other node):

1. **Initialize:** Start with any house (say house 0) and mark it as visited
2. **Track minimum distances:** Maintain an array `minDist[]` where `minDist[i]` represents the minimum cost to connect house `i` to the current MST
3. **Greedy selection:** At each step, select the unvisited house with the minimum connection cost
4. **Update distances:** After adding a house to MST, update the minimum distances for all remaining unvisited houses
5. **Repeat:** Continue until all houses are connected

### Time Complexity
- $O(n^2)$ - We iterate through all houses for each house added to MST

### Space Complexity
- $O(n)$ - For the minDist and visited arrays

### Why Prim's over Kruskal's?
- In this problem, we have a **complete graph** (every house connects to every other house)
- Number of edges = $\frac{n(n-1)}{2}$ which can be up to ~500,000 for n=1000
- Prim's with $O(n^2)$ is more efficient than Kruskal's $O(E \log E)$ for dense graphs
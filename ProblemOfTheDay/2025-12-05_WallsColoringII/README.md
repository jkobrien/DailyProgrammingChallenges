# Walls Coloring II

**Difficulty:** Hard  
**Accuracy:** 50.15%  
**Points:** 8

## Problem Statement

You are given **n** walls arranged in a row, and each wall must be painted using one of the **k** available colors. The cost of painting **ith** wall with **jth** color is given by **costs[i][j]**. Your task is to determine the **minimum total cost** required to paint all the walls in such a way that **no two adjacent walls** share the same color. If it is impossible to paint the walls under this condition, you must return **-1**.

## Examples

### Example 1:
```
Input: n = 4, k = 3
costs[][] = [[1, 5, 7],
             [5, 8, 4],
             [3, 2, 9],
             [1, 2, 4]]

Output: 8

Explanation:
Paint wall 0 with color 0. Cost = 1
Paint wall 1 with color 2. Cost = 4
Paint wall 2 with color 1. Cost = 2
Paint wall 3 with color 0. Cost = 1
Total Cost = 1 + 4 + 2 + 1 = 8
```

### Example 2:
```
Input: n = 5, k = 1
costs[][] = [[5],
             [4],
             [9],
             [2],
             [1]]

Output: -1

Explanation: It is not possible to color all the walls under the given conditions.
```

## Constraints

- 0 ≤ n ≤ 10³
- 0 ≤ k ≤ 10³
- 1 ≤ costs[i][j] ≤ 10⁵

## Expected Complexity

- **Time Complexity:** O(n*k)
- **Auxiliary Space:** O(1)

## Solution Approach

This is a classic **Dynamic Programming** problem that can be solved efficiently using space optimization.

### Key Insights:

1. **Base Case:** If k < 2 and n > 1, it's impossible to paint adjacent walls with different colors, return -1.

2. **DP State:** For each wall `i` and color `j`, we need to track the minimum cost to paint wall `i` with color `j`, given that the previous wall was painted with a different color.

3. **Optimization:** Instead of storing the entire DP table, we only need:
   - The minimum cost from the previous wall
   - The second minimum cost from the previous wall
   - Which color gave the minimum cost

4. **Transition:** For each wall and each color:
   - If we use the color that gave minimum cost in previous wall → use second minimum
   - Otherwise → use the minimum cost from previous wall
   - Add the current wall's color cost

### Algorithm:

```
1. Handle edge cases (n=0, k=0, k=1 with n>1)
2. For the first wall, track min, second min, and min color index
3. For each subsequent wall:
   - For each color j:
     - If j != previous min color: cost = prev_min + costs[i][j]
     - Else: cost = prev_second_min + costs[i][j]
   - Update min, second min, and min color for current wall
4. Return the minimum cost after processing all walls
```

### Time Complexity: O(n*k)
- We iterate through n walls
- For each wall, we iterate through k colors

### Space Complexity: O(1)
- We only store a constant amount of variables (min, second_min, min_color)
- No additional data structures proportional to input size

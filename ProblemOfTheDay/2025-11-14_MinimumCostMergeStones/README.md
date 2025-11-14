# Minimum Cost to Merge Stones

**Difficulty:** Hard  
**Accuracy:** 66.47%  
**Date:** November 14, 2025  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/minimum-cost-to-merge-stones/1)

## Problem Statement

Given an array `stones[]`, where the ith element represents the number of stones in the ith pile.

In one move, you can **merge** exactly **k** consecutive piles into a single pile, and the cost of this move is equal to the total number of stones in these k piles.

Determine the **minimum total cost** required to merge all the piles into one single pile. If it is not possible to merge all piles into one according to the given rules, return **-1**.

## Examples

### Example 1
```
Input: stones[] = [1, 2, 3], k = 2
Output: 9
Explanation: 
- Initially: [1, 2, 3]
- Merge first 2 stones (1 + 2 = 3): [3, 3], cost = 3
- Merge remaining stones (3 + 3 = 6): [6], cost = 6
- Total cost = 3 + 6 = 9
```

### Example 2
```
Input: stones[] = [1, 5, 3, 2, 4], k = 2
Output: 35
Explanation:
- Initially: [1, 5, 3, 2, 4]
- Merge 1 and 5: [6, 3, 2, 4], cost = 6
- Merge 3 and 2: [6, 5, 4], cost = 5
- Merge 5 and 4: [6, 9], cost = 9
- Merge 6 and 9: [15], cost = 15
- Total cost = 6 + 5 + 9 + 15 = 35
```

### Example 3
```
Input: stones[] = [1, 5, 3, 2, 4], k = 4
Output: -1
Explanation: There is no possible way to combine the stones in piles of 4 to get 1 stone in the end.
```

## Constraints
- 1 ≤ stones.size() ≤ 30
- 2 ≤ k ≤ 30
- 1 ≤ stones[i] ≤ 100

## Expected Complexity
- **Time Complexity:** O(n³)
- **Auxiliary Space:** O(n²)

## Approach

This is a dynamic programming problem that requires careful analysis of the merging process.

### Key Observations

1. **Impossibility Check**: To merge n piles into 1 pile using k consecutive merges:
   - Each merge reduces the number of piles by (k-1)
   - Starting with n piles, we need (n-1) total reductions
   - This is only possible if (n-1) % (k-1) == 0
   - If this condition fails, return -1

2. **Dynamic Programming State**:
   - `dp[i][j][p]` = minimum cost to merge stones from index i to j into p piles
   - Base case: `dp[i][i][1]` = 0 (one pile already costs nothing)
   - Goal: `dp[0][n-1][1]` (merge all stones into 1 pile)

3. **Recurrence Relation**:
   - To get p piles from range [i, j]:
     - Split at position m: first part becomes 1 pile, second part becomes (p-1) piles
     - `dp[i][j][p] = min(dp[i][m][1] + dp[m+1][j][p-1])` for all valid m
   - To merge p piles into 1 pile (when p == k):
     - `dp[i][j][1] = dp[i][j][k] + sum(stones[i..j])`

4. **Prefix Sum Optimization**:
   - Use prefix sums to quickly calculate the sum of any subarray
   - This avoids repeatedly summing the same ranges

### Algorithm Steps

1. Check if merging is possible: if `(n-1) % (k-1) != 0`, return -1
2. Create prefix sum array for efficient range sum queries
3. Initialize 3D DP array
4. Fill base cases: single pile costs 0
5. Process all subarrays in increasing length order
6. For each subarray [i, j]:
   - Try forming p piles (2 to k)
   - Try merging k piles into 1 pile
7. Return `dp[0][n-1][1]`

### Time and Space Analysis

- **Time:** O(n³) - three nested loops with constant work inside
- **Space:** O(n² × k) for the DP array, but since k is bounded, effectively O(n²)

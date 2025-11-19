# Path With Minimum Effort (GeeksforGeeks POTD - 2025-11-19)

**Problem Statement:**  
Given a 2D array `mat[n][m]`, find the minimum possible path cost from the top-left cell (0, 0) to the bottom-right cell (n-1, m-1) by moving up, down, left, or right between adjacent cells.  
The cost of a path is defined as the maximum absolute difference between the values of any two consecutive cells along that path.

**Example 1:**  
Input:  
`mat = [[7, 2, 6, 5], [3, 1, 10, 8]]`  
Output:  
`4`  
Explanation:  
The route [7, 3, 1, 2, 6, 5, 8] has a minimum value of maximum absolute difference between any two consecutive cells in the route, i.e., 4.

**Example 2:**  
Input:  
`mat = [[2, 2, 2, 1], [8, 1, 2, 7], [2, 2, 2, 8], [2, 1, 4, 7], [2, 2, 2, 2]]`  
Output:  
`0`  
Explanation:  
The route [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2] has a minimum value of maximum absolute difference between any two consecutive cells in the route, i.e., 0.

**Constraints:**  
- $1 \leq n, m \leq 100$
- $0 \leq mat[i][j] \leq 10^6$

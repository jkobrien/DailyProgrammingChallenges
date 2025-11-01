# Course Schedule II - November 1, 2025

## Problem Statement

You are given **n** courses, labeled from **0 to n - 1** and a 2d array **prerequisites[][]** where prerequisites[i] = **[x, y]** indicates that we need to take course **y** first if we want to take course **x**.

Find the ordering of courses we should take to complete all the courses.

**Note:** There may be multiple correct orders, you just need to return any one of them. If it is impossible to finish all tasks, return an empty array. The Driver code will print **true** if you return any correct order of courses else it will print **false**.

## Examples

**Example 1:**
- **Input:** n = 3, prerequisites[][] = [[1, 0], [2, 1]]
- **Output:** true
- **Explanation:** To take course 1, you must finish course 0. To take course 2, you must finish course 1. So the only valid order is [0, 1, 2].

**Example 2:**
- **Input:** n = 4, prerequisites[][] = [[2, 0], [2, 1], [3, 2]]
- **Output:** true
- **Explanation:** Course 2 requires both 0 and 1. Course 3 requires course 2. Hence, both [0, 1, 2, 3] and [1, 0, 2, 3] are valid.

## Constraints

- 1 ≤ n ≤ 10^4
- 0 ≤ prerequisites.size() ≤ 10^5
- 0 ≤ prerequisites[i][0], prerequisites[i][1] < n
- All prerequisite pairs are unique
- prerequisites[i][0] ≠ prerequisites[i][1]

## Expected Complexities

- **Time Complexity:** O(n + m) where m is the number of prerequisites
- **Auxiliary Space:** O(n + m)

## Algorithm Approach

This is a classic **Topological Sorting** problem that can be solved using:

1. **Kahn's Algorithm (BFS approach):** Build a graph with in-degrees, start with nodes having 0 in-degree
2. **DFS approach:** Use DFS with recursion stack to detect cycles and build topological order

We'll implement the BFS approach using Kahn's algorithm:

1. Build adjacency list and calculate in-degrees for all courses
2. Add all courses with 0 in-degree to a queue
3. Process courses from queue, reducing in-degrees of dependent courses
4. If all courses are processed, return the order; otherwise, return empty array (cycle detected)

## Tags
- **Difficulty:** Medium
- **Topics:** Graph, BFS, DFS, Topological Sort
- **Company:** Google

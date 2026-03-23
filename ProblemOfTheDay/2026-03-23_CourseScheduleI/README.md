# Course Schedule I - Problem of the Day (March 23, 2026)

## Problem Link
https://www.geeksforgeeks.org/problems/course-schedule-i/1

## Problem Statement
You are given **n** courses, labeled from **0 to n - 1** and a 2D array **prerequisites[][]** where `prerequisites[i] = [x, y]` indicates that we need to take course **y** first if we want to take course **x**.

Find if it is possible to complete all tasks. Return **true** if all tasks can be completed, or **false** if it is impossible.

## Examples

### Example 1:
```
Input: n = 4, prerequisites[] = [[2, 0], [2, 1], [3, 2]]
Output: true
Explanation: 
- To take course 2, you must first finish courses 0 and 1.
- To take course 3, you must first finish course 2.
- All courses can be completed, for example in the order [0, 1, 2, 3] or [1, 0, 2, 3].
```

### Example 2:
```
Input: n = 3, prerequisites[] = [[0, 1], [1, 2], [2, 0]]
Output: false
Explanation:
- To take course 0, you must first finish course 1.
- To take course 1, you must first finish course 2.
- To take course 2, you must first finish course 0.
- Since each course depends on the other, it is impossible to complete all courses.
```

## Constraints
- 1 ≤ n ≤ 10⁴
- 0 ≤ prerequisites.size() ≤ 10⁵
- 0 ≤ prerequisites[i][0], prerequisites[i][1] < n
- All prerequisite pairs are unique
- prerequisites[i][0] ≠ prerequisites[i][1]

## Approach

This problem is essentially asking: **Can we complete all courses without encountering a cyclic dependency?**

This is a classic **Cycle Detection in a Directed Graph** problem. If there's a cycle in the prerequisite graph, it's impossible to complete all courses.

### Solution 1: Kahn's Algorithm (BFS - Topological Sort)

**Key Insight:** If we can perform a topological sort on all nodes, there's no cycle.

**Algorithm:**
1. Build an adjacency list and calculate in-degrees for each node
2. Start with all nodes that have 0 in-degree (no prerequisites)
3. Process each node and reduce in-degrees of dependent nodes
4. If we process all n nodes, return true; otherwise, a cycle exists

**Time Complexity:** O(n + m) where m is the number of prerequisites  
**Space Complexity:** O(n + m)

### Solution 2: DFS with Cycle Detection

**Algorithm:**
1. Use a visited array with 3 states: unvisited (0), visiting (1), visited (2)
2. For each unvisited node, perform DFS
3. If we revisit a node in "visiting" state, we found a cycle
4. If all nodes are visited without finding a cycle, return true

**Time Complexity:** O(n + m)  
**Space Complexity:** O(n + m)

## Related Problems
- Course Schedule II (find the actual ordering)
- Detect Cycle in Directed Graph
- Topological Sorting
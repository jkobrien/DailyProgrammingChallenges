# Binary Tree Level Order Traversal - November 4, 2025

## Problem Statement

Given the root of a binary tree, return the level order traversal of its nodes' values (i.e., from left to right, level by level).

A level-order traversal visits nodes level by level, from left to right, starting from the root node.

## Examples

**Example 1:**
```
Input: root = [3,9,20,null,null,15,7]
    3
   / \
  9  20
     /  \
    15   7
Output: [[3],[9,20],[15,7]]
```

**Example 2:**
```
Input: root = [1]
    1
Output: [[1]]
```

**Example 3:**
```
Input: root = []
Output: []
```

## Constraints

- The number of nodes in the tree is in the range [0, 2000]
- -1000 ≤ Node.val ≤ 1000

## Expected Complexities

- **Time Complexity:** O(N), where N is the number of nodes in the tree
- **Space Complexity:** O(W), where W is the maximum width of the tree

## Algorithm Approach

1. Create a queue to store nodes that need to be processed
2. Start by enqueueing the root node
3. While the queue is not empty:
   - Get the number of nodes at current level
   - Process all nodes at current level:
     * Dequeue node
     * Add its value to current level's result
     * Enqueue its left and right children if they exist
   - Add current level's result to final result
4. Return the final result containing all levels

## Tags
- **Difficulty:** Medium
- **Topics:** Tree, Binary Tree, Breadth-First Search, Queue
- **Companies:** Amazon, Microsoft, Facebook, Google

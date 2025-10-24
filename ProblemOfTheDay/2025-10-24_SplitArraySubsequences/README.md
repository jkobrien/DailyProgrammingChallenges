# Split Array Subsequences

**Difficulty:** Medium  
**Accuracy:** 51.81%  
**Date:** October 24, 2025  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/split-array-subsequences/1)

## Problem Statement

Given a sorted integer array `arr[]` and an integer `k`, determine if it is possible to split the array into one or more consecutive subsequences such that:

- Each subsequence consists of consecutive integers (each number is exactly one greater than the previous).
- Every subsequence has a **length of at least k**.

Return true if such a split is possible, otherwise return false.

## Examples

### Example 1:
**Input:** `arr[] = [2, 2, 3, 3, 4, 5]`, `k = 2`  
**Output:** `true`  
**Explanation:** arr can be split into three subsequences of length k - [2, 3], [2, 3], [4, 5].

### Example 2:
**Input:** `arr[] = [1, 1, 1, 1, 1]`, `k = 4`  
**Output:** `false`  
**Explanation:** It is impossible to split arr into consecutive increasing subsequences of length 4 or more.

## Constraints
- 1 ≤ arr.size() ≤ 10^5
- 1 ≤ arr[i] ≤ 10^5
- 1 ≤ k ≤ arr.size()

## Expected Complexity
- **Time Complexity:** O(n log n)
- **Auxiliary Space:** O(n)

## Company Tags
- Amazon
- Google

## Topic Tags
- Priority Queue
- Heap
- Data Structures

## Solution Approach

The problem can be solved using a greedy approach with priority queues (min-heaps):

1. **Count Frequencies:** First, count the frequency of each number in the array.

2. **Use Priority Queues:** For each unique number, maintain a priority queue that stores the lengths of subsequences ending at that number.

3. **Greedy Assignment:** For each number in sorted order:
   - Try to extend existing subsequences by adding the current number to the shortest subsequence ending at (current_number - 1)
   - If no such subsequence exists, start a new subsequence with the current number

4. **Validation:** After processing all numbers, check if all subsequences have length ≥ k.

The key insight is that we should always try to extend the shortest available subsequence to maximize our chances of meeting the minimum length requirement.

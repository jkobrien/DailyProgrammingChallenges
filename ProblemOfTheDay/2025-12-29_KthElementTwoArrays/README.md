# K-th element of two Arrays

**Difficulty:** Medium  
**Tags:** Arrays, Divide and Conquer, Binary Search  
**Companies:** Flipkart, Microsoft

## Problem Statement

Given two sorted arrays `a[]` and `b[]` and an element `k`, the task is to find the element that would be at the **k-th** position of the combined sorted array.

## Examples

**Example 1:**
```
Input: a[] = [2, 3, 6, 7, 9], b[] = [1, 4, 8, 10], k = 5
Output: 6
Explanation: The final combined sorted array would be [1, 2, 3, 4, 6, 7, 8, 9, 10]. 
The 5th element of this array is 6.
```

**Example 2:**
```
Input: a[] = [1, 4, 8, 10, 12], b[] = [5, 7, 11, 15, 17], k = 6
Output: 10
Explanation: Combined sorted array is [1, 4, 5, 7, 8, 10, 11, 12, 15, 17]. 
The 6th element of this array is 10.
```

## Constraints

- 1 ≤ a.size(), b.size() ≤ 10^6
- 1 ≤ k ≤ a.size() + b.size()
- 0 ≤ a[i], b[i] ≤ 10^8

## Approach

### Solution 1: Merge Two Pointers (Simple)
- **Time Complexity:** O(k)
- **Space Complexity:** O(1)
- Use two pointers to traverse both arrays simultaneously
- Count elements until we reach the k-th position

### Solution 2: Binary Search (Optimal)
- **Time Complexity:** O(log(min(n, m)))
- **Space Complexity:** O(1)
- Use binary search on the smaller array
- Find the partition point where elements on left side total to k

## Algorithm (Binary Search)

1. Ensure array `a` is the smaller array (swap if needed)
2. Perform binary search on array `a`
3. For each partition in `a`, calculate corresponding partition in `b`
4. Check if partitions are valid (left elements ≤ right elements)
5. Return the maximum of left partition elements

## Key Insights

- The problem is similar to finding the median of two sorted arrays
- Binary search reduces time complexity significantly
- We only need to find the correct partition, not merge the entire arrays
- The k-th element will be the maximum element on the left side of the partition

## Links

- [Problem Link](https://www.geeksforgeeks.org/problems/k-th-element-of-two-sorted-array1317/1)
- [Article](https://www.geeksforgeeks.org/k-th-element-two-sorted-arrays/)

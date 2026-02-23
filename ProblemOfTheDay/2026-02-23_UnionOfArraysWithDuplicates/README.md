# Union of Arrays with Duplicates

**Date:** February 23, 2026  
**Difficulty:** Easy  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/union-of-two-arrays3538/1)

## Problem Statement

You are given two arrays `a[]` and `b[]`. Return the Union of both arrays in any order.

The Union of two arrays is a collection of all distinct elements present in either of the arrays. If an element appears more than once in one or both arrays, it should be included only once in the union.

### Examples

**Example 1:**
```
Input: a[] = [1, 2, 3, 4, 5], b[] = [1, 2, 3]
Output: 5
Explanation: Union set of both arrays is {1, 2, 3, 4, 5}. Count = 5.
```

**Example 2:**
```
Input: a[] = [85, 25, 1, 32, 54, 6], b[] = [85, 2]
Output: 7
Explanation: Union set is {85, 25, 1, 32, 54, 6, 2}. Count = 7.
```

**Example 3:**
```
Input: a[] = [1, 2, 1, 1, 2], b[] = [2, 2, 1, 2, 1]
Output: 2
Explanation: Union set is {1, 2}. Count = 2.
```

### Constraints
- 1 <= a.size(), b.size() <= 10^6
- 0 <= a[i], b[i] <= 10^6

## Approach

### Solution 1: Using HashSet (Optimal)

**Algorithm:**
1. Create a HashSet to store unique elements
2. Add all elements from array `a[]` to the HashSet
3. Add all elements from array `b[]` to the HashSet
4. Return the count of elements in the HashSet

**Time Complexity:** O(n + m) where n and m are sizes of the arrays  
**Space Complexity:** O(n + m) for the HashSet

### Why HashSet?

- HashSet automatically handles duplicates - adding the same element multiple times only stores it once
- Provides O(1) average time for add operations
- Efficiently handles large arrays (up to 10^6 elements)

## PowerShell Implementation Notes

PowerShell doesn't have a built-in HashSet, but we can use:
- **Hashtable:** For efficient lookup and automatic duplicate handling
- **Select-Object -Unique:** For small arrays (less efficient for large arrays)
- **.NET HashSet:** For optimal performance with large datasets

The solution provided uses a .NET `HashSet<int>` for optimal performance.
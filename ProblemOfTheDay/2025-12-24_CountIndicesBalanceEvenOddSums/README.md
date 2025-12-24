# Count Indices to Balance Even and Odd Sums

**Source:** GeeksforGeeks Problem of the Day  
**Date:** December 24, 2025  
**Difficulty:** Medium  
**Topics:** Arrays, Mathematical, Hash

## Problem Statement

Given an array `arr[]`, count the **number of indices** such that deleting the element at that index and shifting all elements after it one position left results in an array where the **sum** of elements at **even** indices equals the sum at **odd** indices.

### Examples

**Example 1:**
```
Input: arr[] = [2, 1, 6, 4]
Output: 1
Explanation: After removing arr[1], the resulting array will be [2, 6, 4] 
the sums of elements at odd index is arr[1] = 6 and the sum of elements 
at even index is arr[0] + arr[2] = 6.
```

**Example 2:**
```
Input: arr[] = [1, 1, 1]
Output: 3
Explanation: Removing any element makes the sum of odd and even indexed elements equal.
```

### Constraints
- 1 ≤ arr.size() ≤ 10⁵
- 0 ≤ arr[i] ≤ 10⁴

## Solution Approach

### Algorithm

The key insight is that when we remove an element at index `i`, all elements after index `i` shift left by one position. This means:
- Elements at even indices after `i` become odd indices
- Elements at odd indices after `i` become even indices

We can efficiently calculate the even and odd sums after removal using prefix sums:

1. **Calculate initial sums:**
   - `evenSum`: Sum of elements at even indices (0, 2, 4, ...)
   - `oddSum`: Sum of elements at odd indices (1, 3, 5, ...)

2. **For each index i:**
   - Calculate `newEvenSum` = sum of even indices before i + sum of odd indices after i
   - Calculate `newOddSum` = sum of odd indices before i + sum of even indices after i
   - If `newEvenSum == newOddSum`, increment counter

3. **Track running sums:**
   - `evenSumBefore`: Sum of elements at even indices before current index
   - `oddSumBefore`: Sum of elements at odd indices before current index

### Time Complexity
- **O(n)** where n is the length of the array (single pass through the array)

### Space Complexity
- **O(1)** - only using a constant amount of extra space

## Files

- `solution.ps1` - Main solution implementation
- `test.ps1` - Test cases with validation
- `README.md` - Problem description and explanation

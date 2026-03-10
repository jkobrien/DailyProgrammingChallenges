# Subarrays with First Element Minimum

**Date**: March 10, 2026  
**Difficulty**: Medium  
**Tags**: Stack, Arrays, Data Structures  
**Source**: [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/subarrays-with-first-element-minimum/1)

## Problem Statement

You are given an integer array `arr[]`. Your task is to count the number of subarrays where the first element is the **minimum element** of that subarray.

**Note**: A subarray is valid if its first element is not greater than any other element in that subarray.

## Examples

### Example 1
```
Input: arr[] = [1, 2, 1]
Output: 5
Explanation:
All possible subarrays are: [1], [1,2], [1,2,1], [2], [2,1], [1]
Valid subarrays are: [1], [1,2], [1,2,1], [2], [1] → total 5
```

### Example 2
```
Input: arr[] = [1, 3, 5, 2]
Output: 8
Explanation:
Valid subarrays are: [1], [1,3], [1,3,5], [1,3,5,2], [3], [3,5], [5], [2] → total 8
```

## Constraints

- $1 \leq arr.size() \leq 5 \times 10^4$
- $1 \leq arr[i] \leq 10^5$

## Approach

### Key Insight
For each element at index `i`, we need to count how many subarrays starting at `i` have `arr[i]` as the minimum (i.e., first element ≤ all other elements in the subarray).

### Algorithm
1. For each index `i`, find the **next smaller element** index `j` where `arr[j] < arr[i]`
2. The count of valid subarrays starting at index `i` is `(j - i)`
3. If no smaller element exists to the right, then `j = n` (array length)
4. Sum up all counts for each starting index

### Optimized Solution using Monotonic Stack
- Use a **monotonic increasing stack** to efficiently find the next smaller element for each index
- Process the array from right to left
- Time Complexity: $O(n)$
- Space Complexity: $O(n)$

### Why Monotonic Stack?
- A naive approach would check all subarrays: $O(n^2)$
- Using a monotonic stack, we can find the next smaller element for all indices in $O(n)$ total time
- Each element is pushed and popped from the stack at most once
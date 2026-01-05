# Max Sum Subarray of size K

**Date:** January 5, 2026  
**Difficulty:** Easy  
**Problem URL:** https://www.geeksforgeeks.org/problems/max-sum-subarray-of-size-k5313/1

## Problem Statement

Given an array of integers `arr[]` and a number `k`. Return the maximum sum of a subarray of size `k`.

**Note:** A subarray is a contiguous part of any given array.

## Examples

### Example 1:
```
Input: arr[] = [100, 200, 300, 400], k = 2
Output: 700
Explanation: arr[1] + arr[2] = 700, which is the maximum sum of a subarray of size 2.
```

### Example 2:
```
Input: arr[] = [1, 4, 2, 10, 23, 3, 1, 0, 20], k = 4
Output: 39
Explanation: arr[1] + arr[2] + arr[3] + arr[4] = 39, which is the maximum sum of a subarray of size 4.
```

### Example 3:
```
Input: arr[] = [2, 3], k = 3
Output: -1
Explanation: Since k > size of array, output is -1.
```

## Constraints
- 1 ≤ arr.size() ≤ 10^6
- 1 ≤ k ≤ arr.size()
- 1 ≤ arr[i] ≤ 10^5

## Approach: Sliding Window Technique

This problem is a classic application of the **sliding window** technique, which is highly efficient for finding subarrays of a fixed size.

### Algorithm:
1. **Edge Case:** If k is greater than the array size, return -1
2. **Initial Window:** Calculate the sum of the first k elements
3. **Slide the Window:** 
   - Remove the leftmost element from the current window
   - Add the next element to the right
   - Track the maximum sum encountered
4. Return the maximum sum

### Time Complexity: O(n)
- We traverse the array once

### Space Complexity: O(1)
- Only using a few variables for tracking

## Solution

See `max_sum_subarray_of_size_k.ps1` for the PowerShell implementation.

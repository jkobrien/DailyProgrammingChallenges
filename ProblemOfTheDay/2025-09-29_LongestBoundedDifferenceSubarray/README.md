# Longest Bounded-Difference Subarray

**GeeksforGeeks Problem of the Day – 2025-09-29**

## Problem Statement
Given an array of positive integers `arr[]` and a non-negative integer `x`, find the longest subarray where the absolute difference between any two elements is not greater than `x`. If multiple such subarrays exist, return the one that starts at the smallest index.

## Approach
- Use a sliding window with two pointers.
- Maintain the minimum and maximum in the current window using two deques (monotonic queues).
- Expand the window to the right; if the difference between max and min exceeds `x`, move the left pointer forward and update deques.
- Track the longest window found.
- Time Complexity: O(n)
- Space Complexity: O(n)

## PowerShell Solution
- Implements the above approach in `longest_bounded_difference_subarray.ps1`.
- Includes a brute-force verifier and a test harness.

## How to Run
1. Open PowerShell in this directory.
2. Run the script:
   ```powershell
   pwsh -File .\longest_bounded_difference_subarray.ps1
   ```
3. The script will execute fixed and randomized tests, showing PASS/FAIL for each case.

## Example
```
Input: arr = [8, 4, 5, 6, 7], x = 3
Output: [4, 5, 6, 7]
Explanation: The subarray [4, 5, 6, 7] contains no two elements whose absolute difference is greater than 3.
```

## Files
- `longest_bounded_difference_subarray.ps1`: Solution, brute-force verifier, and test harness
- `README.md`: Problem statement and instructions

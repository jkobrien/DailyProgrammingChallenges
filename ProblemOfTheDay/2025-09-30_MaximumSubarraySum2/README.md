# Maximum Subarray Sum 2

**GeeksforGeeks Problem of the Day – 2025-09-30**

## Problem Statement
Given an array of integers `arr[]` and two integers `a` and `b`, find the maximum possible sum of a contiguous subarray whose length is at least `a` and at most `b`.

## Approach
- Use prefix sums for O(1) subarray sum queries.
- For each end index, maintain a window of possible start indices (using a queue) to efficiently get the minimum prefix sum for valid subarray lengths.
- For each end index, calculate the maximum sum for subarrays ending at that index with length in [a, b].
- Time Complexity: O(n)
- Space Complexity: O(n)

## PowerShell Solution
- Implements the above approach in `maximum_subarray_sum_2.ps1`.
- Includes a brute-force verifier and a test harness.

## How to Run
1. Open PowerShell in this directory.
2. Run the script:
   ```powershell
   pwsh -File .\maximum_subarray_sum_2.ps1
   ```
3. The script will execute fixed and randomized tests, showing PASS/FAIL for each case.

## Example
```
Input: arr = [4, 5, -1, -2, 6], a = 2, b = 4
Output: 9
Explanation: The subarray [4, 5] has length 2 and sum 9, which is the maximum among all subarrays of length between 2 and 4.
```

## Files
- `maximum_subarray_sum_2.ps1`: Solution, brute-force verifier, and test harness
- `README.md`: Problem statement and instructions

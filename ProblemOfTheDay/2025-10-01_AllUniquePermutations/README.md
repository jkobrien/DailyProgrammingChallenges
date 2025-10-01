# All Unique Permutations of an Array

**GeeksforGeeks Problem of the Day – 2025-10-01**

## Problem Statement
Given an array `arr[]` that may contain duplicates, find all possible distinct permutations of the array in sorted order.

## Approach
- Use backtracking to generate all permutations.
- To avoid duplicates, sort the array and skip repeated elements during recursion.
- Collect all unique permutations and sort them lexicographically.
- Time Complexity: O(n! * n)
- Space Complexity: O(n! * n)

## PowerShell Solution
- Implements the above approach in `all_unique_permutations.ps1`.
- Includes a test harness.

## How to Run
1. Open PowerShell in this directory.
2. Run the script:
   ```powershell
   pwsh -File .\all_unique_permutations.ps1
   ```
3. The script will execute fixed and randomized tests, showing PASS/FAIL for each case.

## Example
```
Input: arr = [1, 3, 3]
Output: [1,3,3], [3,1,3], [3,3,1]
Explanation: These are the only possible distinct permutations for the given array.
```

## Files
- `all_unique_permutations.ps1`: Solution and test harness
- `README.md`: Problem statement and instructions

# Count the number of subarrays having a given XOR

**GeeksforGeeks Problem of the Day – 2025-09-23**

## Problem Statement
Given an array of integers and a target value $K$, count the number of subarrays whose XOR is equal to $K$.

## Approach
- Use prefix XOR and a hash table to count subarrays efficiently.
- For each element, compute prefix XOR up to that index.
- For each prefix XOR, the number of times $(\text{prefixXOR} \oplus K)$ has occurred so far gives the number of subarrays ending at the current index with XOR $K$.
- Time Complexity: $O(n)$
- Space Complexity: $O(n)$

## PowerShell Solution
- Implements the above approach in `count_subarrays_with_xor.ps1`.
- Includes a brute-force verifier and a test harness.

## How to Run
1. Open PowerShell in this directory.
2. Run the script:
   ```powershell
   pwsh -File .\count_subarrays_with_xor.ps1
   ```
3. The script will execute fixed and randomized tests, showing PASS/FAIL for each case.

## Example
```
Input: 4 2 2 6 4, K=6
Output: 4
Explanation: Subarrays with XOR 6 are [4,2], [2,2,6], [6], [4,2,2,6]
```

## Files
- `count_subarrays_with_xor.ps1`: Solution, brute-force verifier, and test harness
- `README.md`: Problem statement and instructions

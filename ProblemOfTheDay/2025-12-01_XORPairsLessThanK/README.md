# XOR Pairs less than K

**Difficulty:** Medium  
**Date:** December 1, 2025  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/count-pairs-having-bitwise-xor-less-than-k/1)

## Problem Description

Given an array `arr[]` and an integer `k`, count the number of pairs from the array such that the Bitwise XOR of each pair is less than k.

## Examples

### Example 1:
```
Input: arr = [1, 2, 3, 5], k = 5
Output: 4
Explanation: 
- 1 ^ 2 = 3 < 5 ✓
- 1 ^ 3 = 2 < 5 ✓
- 1 ^ 5 = 4 < 5 ✓
- 2 ^ 3 = 1 < 5 ✓
Total: 4 pairs
```

### Example 2:
```
Input: arr = [3, 5, 6, 8], k = 7
Output: 3
Explanation:
- 3 ^ 5 = 6 < 7 ✓
- 3 ^ 6 = 5 < 7 ✓
- 5 ^ 6 = 3 < 7 ✓
Total: 3 pairs
```

## Constraints
- 1 ≤ arr.size(), k ≤ 5*10^4
- 1 ≤ arr[i] ≤ 5*10^4

## Expected Complexity
- **Time Complexity:** O(n)
- **Auxiliary Space:** O(n)

## Approach

### Trie-Based Solution

Since we need O(n) time complexity, we can't use a brute force approach (which would be O(n²)). Instead, we use a **Binary Trie** data structure:

1. **Binary Trie Structure:** Store numbers in binary form in a trie
2. **Count Valid Pairs:** For each number, traverse the trie and count how many existing numbers form XOR < k
3. **Bit-by-Bit Decision:** At each bit position, decide whether to go left (0) or right (1) based on:
   - Current XOR value
   - Remaining bits in k
   - Whether we can still stay below k

### Algorithm Steps:

1. Build a trie where each node represents a bit (0 or 1)
2. For each number in the array:
   - Query the trie to count valid pairs
   - Insert the number into the trie
3. The query function traverses bit-by-bit:
   - If k's current bit is 1: we can take both paths (XOR will be < k either way)
   - If k's current bit is 0: we must take the path that keeps XOR < k

### Key Insights:

- **XOR Properties:** a ^ b < k depends on the most significant differing bit
- **Trie Efficiency:** Allows us to quickly count numbers that satisfy XOR < k condition
- **Online Processing:** We can count pairs as we insert numbers, avoiding double counting

## Solution

See `xor_pairs_less_than_k.ps1` for the complete PowerShell implementation.

## Testing

Run the test script:
```powershell
.\test_xor_pairs_less_than_k.ps1
```

## Related Concepts
- Binary Trie
- XOR operations
- Bit manipulation
- Tree traversal

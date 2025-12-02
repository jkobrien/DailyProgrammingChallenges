# Maximise String Score

**Date:** December 2, 2025  
**Difficulty:** Medium  
**Source:** [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/maximise-string-score--172902/1)

## Problem Statement

You are given a string `s`, and a list of `jumps[][]` of size `n`, where each `jumps[i] = [s1, s2]` denotes that you are allowed to jump from **character s1** to **s2** in the **forward** direction.

Additionally, you are allowed to jump forward from a character to any other occurrence of the **same** character within the string.

You start at index **0** of the string. After every valid jump from index i to index j, where s[i] = s1 and s[j] = s2, you earn a score equal to the **sum** of ASCII values of **all** characters between the jump **except** for the characters equals **s2**, i.e.

> **score(i, j)** = sum(ascii(s[k]) for i ≤ k < j and s[k] != s[j])

Determine the **maximum** score that can be achieved by performing a sequence of **valid** jumps starting from index 0.

## Examples

### Example 1
```
Input: s = "forgfg", jumps[][] = [['f', 'r'], ['r', 'g']]
Output: 429
Explanation: 
- Jump from 'f' (index 0) to 'r' (index 2): score = ASCII('f') + ASCII('o') = 102 + 111 = 213
- Jump from 'r' (index 2) to 'g' (index 5): score = ASCII('r') + ASCII('f') = 114 + 102 = 216
- Total score = 213 + 216 = 429
```

### Example 2
```
Input: s = "abcda", jumps[][] = [['b', 'd']]
Output: 297
Explanation:
- Jump from 'a' (index 0) to 'a' (index 4): score = ASCII('b') + ASCII('c') + ASCII('d') = 98 + 99 + 100 = 297
- Total score = 297
```

## Constraints
- 1 ≤ |s| ≤ 2 * 10^5
- 1 ≤ jumps.size() ≤ 676
- There are at least two distinct characters in s

## Expected Complexity
- **Time Complexity:** O(26 * n)
- **Auxiliary Space:** O(26 * n)

## Topic Tags
- prefix-sum
- Strings
- Dynamic Programming

## Approach

This problem requires dynamic programming with memoization:

1. **State Definition:** `dp[i]` represents the maximum score achievable when reaching position `i` in the string.

2. **Allowed Jumps:** From any position `i` with character `c`, we can jump to:
   - Any position `j > i` where we have a valid jump rule `[c, s[j]]`
   - Any position `j > i` where `s[j] == s[i]` (same character)

3. **Score Calculation:** When jumping from position `i` to position `j`:
   - Calculate the sum of ASCII values from index `i` to `j-1`
   - Exclude any characters that equal `s[j]`
   - Add this to the current score at position `i`

4. **Optimization:** Use prefix sums to efficiently calculate the sum of ASCII values in any range, and track character-specific prefix sums for quick exclusion.

5. **Result:** The maximum value among all positions' dp values is the answer.

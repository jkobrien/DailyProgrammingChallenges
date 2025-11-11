# Shortest Common Supersequence - November 11, 2025

## Problem Statement

Given two strings `s1` and `s2`, find the length of the **smallest string** which has both `s1` and `s2` as its **sub-sequences**.

**Note:** s1 and s2 can have both uppercase and lowercase English letters.

## Examples

### Example 1
```
Input: s1 = "geek", s2 = "eke"
Output: 5
Explanation: String "geeke" has both string "geek" and "eke" as subsequences.
```

### Example 2
```
Input: s1 = "AGGTAB", s2 = "GXTXAYB"
Output: 9
Explanation: String "AGXGTXAYB" has both string "AGGTAB" and "GXTXAYB" as subsequences.
```

### Example 3
```
Input: s1 = "geek", s2 = "ek"
Output: 4
Explanation: String "geek" has both string "geek" and "ek" as subsequences.
```

## Constraints
- 1 ≤ s1.size(), s2.size() ≤ 500

## Expected Complexities
- **Time Complexity:** O(n * m)
- **Space Complexity:** O(m)

## Approach

The key insight is that the shortest common supersequence (SCS) can be calculated using the Longest Common Subsequence (LCS):

```
SCS Length = Length(s1) + Length(s2) - LCS(s1, s2)
```

### Why does this work?

1. A supersequence must contain all characters from both strings
2. If we simply concatenate s1 and s2, we get length m + n
3. However, any common subsequence characters are counted twice
4. By subtracting the LCS length, we account for the overlap
5. The LCS represents the maximum overlap we can achieve

### Algorithm Steps

1. Build a DP table to find the length of LCS
2. Use dynamic programming where `dp[i][j]` represents the LCS length of `s1[0...i-1]` and `s2[0...j-1]`
3. Fill the table using the recurrence:
   - If characters match: `dp[i][j] = dp[i-1][j-1] + 1`
   - Otherwise: `dp[i][j] = max(dp[i-1][j], dp[i][j-1])`
4. Calculate SCS length using the formula above

### Example Walkthrough

For s1 = "geek", s2 = "eke":

1. Build LCS table:
   ```
        ""  e  k  e
   ""    0  0  0  0
   g     0  0  0  0
   e     0  1  1  1
   e     0  1  1  2
   k     0  1  2  2
   ```

2. LCS length = 2 (the subsequence "ek")
3. SCS length = 4 + 3 - 2 = 5
4. One possible SCS: "geeke"

## Solution Complexity Analysis

- **Time Complexity:** O(n * m) where n and m are the lengths of the two strings
  - We fill an (n+1) × (m+1) DP table
  
- **Space Complexity:** O(n * m) for the DP table
  - Can be optimized to O(min(n, m)) by using only two rows

## Tags
- Dynamic Programming
- Strings
- Longest Common Subsequence

## Company
- Microsoft

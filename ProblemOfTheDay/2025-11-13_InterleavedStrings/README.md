# Interleaved Strings

**Difficulty:** Medium  
**Accuracy:** 24.33%  
**Points:** 4

## Problem Statement

Given strings `s1`, `s2`, and `s3`, find whether `s3` is formed by an **interleaving** of `s1` and `s2`.

**Interleaving** of two strings s1 and s2 is a way to mix their characters to form a **new string s3**, while maintaining the **relative order** of characters from s1 and s2.

### Conditions for Interleaving:
1. Characters from s1 must appear in the same order in s3 as they are in s1.
2. Characters from s2 must appear in the same order in s3 as they are in s2.
3. The length of s3 must be equal to the combined length of s1 and s2.

## Examples

### Example 1:
**Input:** s1 = "AAB", s2 = "AAC", s3 = "AAAABC"  
**Output:** true  
**Explanation:** The string "AAAABC" has all characters of the other two strings and in the same order.

### Example 2:
**Input:** s1 = "AB", s2 = "C", s3 = "ACB"  
**Output:** true  
**Explanation:** s3 has all characters of s1 and s2 and retains order of characters of s1.

### Example 3:
**Input:** s1 = "YX", s2 = "X", s3 = "XXY"  
**Output:** false  
**Explanation:** "XXY" is not interleaved of "YX" and "X". The strings that can be formed are YXX and XYX

## Constraints
- 1 ≤ s1.length, s2.length ≤ 300
- 1 ≤ s3.length ≤ 600

## Expected Complexity
- **Time Complexity:** O(n * m) where n = length of s1, m = length of s2
- **Space Complexity:** O(m)

## Approach: Dynamic Programming

This problem can be solved using dynamic programming. We use a 2D DP table where `dp[i][j]` represents whether the first `i` characters of `s1` and first `j` characters of `s2` can form the first `i+j` characters of `s3`.

### Algorithm:
1. **Base Case Check:** If `s1.length + s2.length ≠ s3.length`, return false immediately.

2. **DP State Definition:**
   - `dp[i][j]` = true if first `i` chars of s1 and first `j` chars of s2 can interleave to form first `i+j` chars of s3

3. **State Transition:**
   - If `s1[i-1] == s3[i+j-1]` and `dp[i-1][j]` is true, then `dp[i][j]` is true
   - If `s2[j-1] == s3[i+j-1]` and `dp[i][j-1]` is true, then `dp[i][j]` is true

4. **Space Optimization:** We can optimize space from O(n*m) to O(m) by using a 1D array and updating it row by row.

### Key Insights:
- At each position in s3, we check if it can be formed by taking a character from s1 or s2
- We maintain the relative order constraint by checking characters sequentially
- The DP table builds up solutions from smaller subproblems

## Company Tags
Paytm, Amazon, Microsoft, FactSet, Google, Zillious, Yahoo

## Topic Tags
Strings, Dynamic Programming, Data Structures, Algorithms

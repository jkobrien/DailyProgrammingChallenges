# Smallest Window Containing All Characters

**Date**: March 6, 2026  
**Source**: [GeeksforGeeks Problem of the Day](https://www.geeksforgeeks.org/problems/smallest-window-in-a-string-containing-all-the-characters-of-another-string-1587115621/1)

## Problem Statement

Given two strings `s` and `p`, find the smallest substring in `s` consisting of all the characters (including duplicates) of the string `p`. Return an empty string in case no such substring is present. If there are multiple such substrings of the same length, return the one which appears first.

## Examples

**Example 1:**
```
Input: s = "timetopractice", p = "toc"
Output: "toprac"
Explanation: "toprac" is the smallest substring that contains all characters of p ('t', 'o', 'c').
```

**Example 2:**
```
Input: s = "zoomlazapzo", p = "oza"
Output: "apzo"
Explanation: "apzo" is the smallest substring that contains 'o', 'z', 'a'.
```

**Example 3:**
```
Input: s = "abc", p = "xyz"
Output: ""
Explanation: No substring of s contains all characters of p.
```

## Constraints

- 1 ≤ |s|, |p| ≤ 10^5

## Approach: Sliding Window with Two Pointers

### Algorithm

1. **Create frequency maps**: Count the frequency of each character in pattern `p`.

2. **Initialize sliding window**: Use two pointers (`left` and `right`) to maintain a window in string `s`.

3. **Expand window**: Move `right` pointer to include characters until the window contains all characters of `p`.

4. **Contract window**: Once all characters are found, move `left` pointer to shrink the window while still maintaining all required characters. Track the minimum window found.

5. **Repeat**: Continue expanding and contracting until `right` reaches the end of `s`.

### Time Complexity
- **O(n)** where n is the length of string `s`
- Each character is visited at most twice (once by `right`, once by `left`)

### Space Complexity
- **O(k)** where k is the number of unique characters (at most 256 for ASCII)

## Key Insights

1. Use a hash table to track the required character frequencies
2. Maintain a count of "matched" characters to know when window is valid
3. Only contract window when all characters are matched
4. Track the minimum window length and starting position
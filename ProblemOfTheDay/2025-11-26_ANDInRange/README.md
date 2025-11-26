# AND In Range

**Difficulty:** Medium  
**Accuracy:** 50.0%  
**Date:** November 26, 2025

## Problem Statement

You are given two integers **l** and **r**. Find the result after applying the series of **Bitwise AND** ( & ) operation on every natural number between the range l to r (including both).

## Examples

**Example 1:**
```
Input: l = 8, r = 13
Output: 8
Explanation: 8 AND 9 AND 10 AND 11 AND 12 AND 13 = 8
```

**Example 2:**
```
Input: l = 2, r = 3
Output: 2
Explanation: 2 AND 3 = 2
```

## Constraints

- 1 ≤ l ≤ r ≤ 10^9

## Expected Complexity

- **Time Complexity:** O(log l)
- **Space Complexity:** O(1)

## Approach & Solution

### Key Insight

The problem asks us to find the bitwise AND of all numbers in a range [l, r]. The key observation is that when we AND consecutive numbers, bits start turning off from the least significant bit positions.

### Algorithm

The solution uses the following approach:

1. **Find Common Prefix:** We need to find the common prefix of `l` and `r` in their binary representation. All bits after the common prefix will become 0 when we AND all numbers in the range.

2. **Right Shift Until Equal:** Keep right-shifting both `l` and `r` until they become equal. This removes the differing bits from the right.

3. **Left Shift Back:** Once they're equal, left-shift back the same number of times to get the result. This gives us the common prefix with zeros in positions where bits differed.

### Why This Works

- In any range of consecutive numbers, bits toggle at different rates
- The rightmost bit toggles every number (0,1,0,1,...)
- The second bit toggles every 2 numbers (0,0,1,1,...)
- When we AND all numbers in a range, any bit position that changes within the range becomes 0
- Only the common prefix bits (that don't change) remain as 1

### Example Walkthrough

For l=8, r=13:
```
8  = 1000
9  = 1001
10 = 1010
11 = 1011
12 = 1100
13 = 1101
```

Step by step:
1. l=8 (1000), r=13 (1101), shift=0
2. l=4 (0100), r=6 (0110), shift=1
3. l=2 (0010), r=3 (0011), shift=2
4. l=1 (0001), r=1 (0001), shift=3 → They're equal!
5. Result = 1 << 3 = 8 (1000)

The common prefix is "1000" which is 8.

## Topic Tags

- Bit Magic
- Data Structures

## Related Articles

- [Bitwise And Or Of A Range](https://www.geeksforgeeks.org/bitwise-and-or-of-a-range/)

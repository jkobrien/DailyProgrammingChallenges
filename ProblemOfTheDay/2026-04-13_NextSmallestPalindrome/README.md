# Next Smallest Palindrome

**Difficulty:** Hard  
**Accuracy:** 19.63%  
**Date:** April 13, 2026

## Problem Statement

Given a number, in the form of an array `num[]` containing digits from 1 to 9 (inclusive), find the **next smallest palindrome** strictly larger than the given number.

### Examples

**Example 1:**
```
Input: num[] = [9, 4, 1, 8, 7, 9, 7, 8, 3, 2, 2]
Output: [9, 4, 1, 8, 8, 0, 8, 8, 1, 4, 9]
Explanation: The next palindrome greater than 9418797832­2 is 94188088149
```

**Example 2:**
```
Input: num[] = [1, 2, 3]
Output: [1, 3, 1]
Explanation: The next palindrome greater than 123 is 131
```

**Example 3:**
```
Input: num[] = [9, 9, 9]
Output: [1, 0, 0, 1]
Explanation: The next palindrome greater than 999 is 1001
```

**Example 4:**
```
Input: num[] = [1, 2, 1]
Output: [1, 3, 1]
Explanation: The input is already a palindrome, so we need the next one: 131
```

### Constraints
- 1 ≤ num.size() ≤ 10^5
- 1 ≤ num[i] ≤ 9

### Expected Complexity
- **Time Complexity:** O(n)
- **Space Complexity:** O(1) (auxiliary space, excluding output)

## Solution Approach

### Key Observations

1. **Mirror the left half to right**: The basic idea is to mirror the left half of the number to the right half to create a palindrome.

2. **Three cases to handle**:
   - **Case 1**: The mirrored palindrome is greater than the original number → Return it
   - **Case 2**: The mirrored palindrome is less than or equal to the original → Increment the middle part and re-mirror
   - **Case 3**: The number is all 9s → Return a number of the form 10...01

### Algorithm

1. **Find the middle** of the array
2. **Mirror left to right** to create a candidate palindrome
3. **Compare** the candidate with the original:
   - If candidate > original, return candidate
   - If candidate ≤ original, increment from the middle outward
4. **Handle carry propagation** when incrementing
5. **Handle overflow** (all 9s case) by creating a new number with one more digit

### Step-by-Step Process

For a number like `[1, 2, 3, 4, 5]`:
1. Length = 5, middle = 2 (0-indexed)
2. Mirror left half: `[1, 2, 3, 2, 1]`
3. Compare with original: `12321` < `12345`
4. Since it's smaller, increment middle and re-mirror:
   - Increment `3` → `4`
   - Result: `[1, 2, 4, 2, 1]`
5. `12421` > `12345` ✓

### Edge Cases

1. **All 9s**: `[9, 9, 9]` → `[1, 0, 0, 1]`
2. **Single digit**: `[5]` → `[6]`, `[9]` → `[1, 1]`
3. **Already palindrome**: `[1, 2, 1]` → `[1, 3, 1]`
4. **Carry propagation**: `[1, 9, 9, 1]` → `[1, 2, 2, 1]` (but this is smaller!)
   - Need to go to `[2, 0, 0, 2]`

## PowerShell Implementation Details

The solution uses:
- Array slicing and mirroring
- Carry propagation for incrementing
- Comparison of digit arrays
- Special handling for all-9s case

## Complexity Analysis

- **Time Complexity:** O(n) - Single pass to mirror, single pass to compare, single pass to increment
- **Space Complexity:** O(n) for the output array, O(1) auxiliary space

## Tags
- **Company Tags:** Flipkart, Amazon, Microsoft, OYO Rooms, Adobe, Media.net
- **Topic Tags:** Arrays, Data Structures
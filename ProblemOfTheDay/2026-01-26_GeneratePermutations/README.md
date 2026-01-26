# Generate Permutations of an Array

**Problem URL:** https://www.geeksforgeeks.org/problems/generate-permutations-of-an-array/1

**Difficulty:** Medium

**Tags:** Backtracking, Arrays, Recursion

**Date:** January 26, 2026

## Problem Statement

Given an array `arr[]` of unique elements. Generate all possible permutations of the elements in the array.

**Note:** You can return the permutations in any order, the driver code will print them in sorted order.

## Examples

### Example 1:
```
Input: arr[] = [1, 2, 3]
Output: [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
Explanation: Given array has 3 elements and 3! = 6 permutations
```

### Example 2:
```
Input: arr[] = [1, 2]
Output: [[1, 2], [2, 1]]
Explanation: Given array has 2 elements and 2! = 2 permutations
```

## Constraints
- 1 ≤ arr.size() ≤ 10
- 1 ≤ arr[i] ≤ 10

## Approach

The solution uses **backtracking** to generate all permutations:

1. **Base Case**: When the current permutation is complete (length equals array length), add it to results
2. **Recursive Case**: For each remaining element:
   - Add the element to the current permutation
   - Mark it as used
   - Recursively generate permutations with remaining elements
   - Backtrack by removing the element and marking it as unused

### Time Complexity
- **O(n! × n)** where n is the length of the array
  - There are n! permutations
  - Each permutation takes O(n) time to construct

### Space Complexity
- **O(n! × n)** for storing all permutations
- **O(n)** for the recursion stack depth

## Algorithm Steps

1. Initialize an empty result list to store all permutations
2. Create a boolean array to track which elements are used
3. Start backtracking with an empty current permutation
4. For each position:
   - Try each unused element
   - Mark it as used and add to current permutation
   - Recursively build the rest of the permutation
   - Backtrack by removing the element and marking unused
5. Return all generated permutations

## Key Insights

- **Backtracking** is the standard approach for generating permutations
- Each element appears exactly once in each permutation
- The order matters (unlike combinations)
- Using a boolean array to track used elements avoids duplicates within a permutation
- The recursion naturally handles all possibilities through the backtracking process
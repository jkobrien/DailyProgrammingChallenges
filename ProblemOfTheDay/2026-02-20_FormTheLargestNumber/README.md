# Form the Largest Number

**Date:** February 20, 2026  
**Difficulty:** Medium  
**Accuracy:** 37.82%  
**Tags:** Arrays, Data Structures, Sorting

## Problem Description

Given an array of integers `arr[]` representing non-negative integers, arrange them so that after concatenating all of them in order, it results in the largest possible number. Since the result may be very large, return it as a string.

## Examples

### Example 1:
```
Input: arr[] = [3, 30, 34, 5, 9]
Output: "9534330"
Explanation: 
When we arrange the numbers as [9, 5, 34, 3, 30], the concatenation gives us "9534330",
which is the largest possible number.
```

### Example 2:
```
Input: arr[] = [54, 546, 548, 60]
Output: "6054854654"
Explanation:
The arrangement [60, 548, 546, 54] gives "6054854654", which is the largest.
```

### Example 3:
```
Input: arr[] = [0, 0, 0]
Output: "0"
Explanation:
All zeros should return just "0", not "000".
```

## Constraints

- 1 ≤ arr.size() ≤ 10⁵
- 0 ≤ arr[i] ≤ 10⁵

## Solution Approach

### Key Insight

The problem requires a **custom comparison** to determine the order of numbers. When comparing two numbers `a` and `b`, we should place `a` before `b` if concatenating them as `ab` produces a larger number than `ba`.

### Algorithm:

1. **Convert all numbers to strings** for easy concatenation comparison
2. **Custom Sort**: Sort the array using a custom comparator:
   - For two numbers `x` and `y`, compare `xy` vs `yx`
   - If `xy > yx`, then `x` should come before `y`
   - This ensures the largest possible concatenation
3. **Handle Edge Case**: If all numbers are 0, return "0" instead of "000..."
4. **Concatenate** sorted numbers to form the result

### Example Walkthrough:

For `arr = [3, 30, 34, 5, 9]`:

1. Compare pairs:
   - `9` vs `5`: "95" > "59" → 9 comes first
   - `9` vs `34`: "934" > "349" → 9 comes first
   - `5` vs `34`: "534" > "345" → 5 comes first
   - `34` vs `3`: "343" > "334" → 34 comes first
   - `3` vs `30`: "330" > "303" → 3 comes first

2. Sorted order: [9, 5, 34, 3, 30]
3. Concatenate: "9534330"

### Why This Works:

The custom comparison is **transitive**: if `xy > yx` and `yz > zy`, then `xz > zx`. This property ensures that our sorting produces the globally optimal arrangement.

### Time Complexity: O(n log n)
- Sorting dominates the complexity
- Each comparison involves string concatenation: O(k) where k is the number of digits

### Space Complexity: O(n)
- Storing string representations of numbers
- Additional space for sorting

## Links

- [GeeksforGeeks Problem](https://www.geeksforgeeks.org/problems/largest-number-formed-from-an-array1117/1)
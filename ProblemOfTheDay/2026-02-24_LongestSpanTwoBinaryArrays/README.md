# Longest Span in Two Binary Arrays

**GeeksforGeeks Problem of the Day - February 24, 2026**

## Problem Description

Given two binary arrays, `a1[]` and `a2[]` of equal length, find the length of the longest common span `(i, j)`, where `i <= j` such that:

```
a1[i] + a1[i+1] + ... + a1[j] = a2[i] + a2[i+1] + ... + a2[j]
```

In other words, find the longest subarray where both arrays have the same sum.

## Examples

### Example 1:
```
Input:  a1[] = [0, 1, 0, 0, 0, 0], a2[] = [1, 0, 1, 0, 0, 1]
Output: 4
Explanation: The longest span with same sum is from index 1 to 4 (0-indexed).
  a1[1..4] = [1, 0, 0, 0] → sum = 1
  a2[1..4] = [0, 1, 0, 0] → sum = 1
```

### Example 2:
```
Input:  a1[] = [0, 1, 0, 1, 1, 1, 1], a2[] = [1, 1, 1, 1, 1, 0, 1]
Output: 6
Explanation: The longest span with same sum is from index 1 to 6.
```

### Example 3:
```
Input:  a1[] = [0, 0, 0], a2[] = [1, 1, 1]
Output: 0
Explanation: No span exists where sums are equal.
```

## Approach

### Key Insight: Difference Array + Prefix Sum

1. **Transform the problem**: Instead of comparing sums directly, create a difference array:
   ```
   diff[i] = a1[i] - a2[i]
   ```

2. **Observation**: If `sum(a1[i..j]) = sum(a2[i..j])`, then:
   ```
   sum(diff[i..j]) = sum(a1[i..j]) - sum(a2[i..j]) = 0
   ```

3. **Problem becomes**: Find the longest subarray with sum = 0

4. **Solution using Prefix Sum + HashMap**:
   - Calculate prefix sums of the difference array
   - If `prefixSum[j] == prefixSum[i-1]`, then `sum(diff[i..j]) = 0`
   - Use a hash map to store the first occurrence of each prefix sum
   - When we see the same prefix sum again, the subarray between them has sum = 0

### Algorithm:

1. Create difference array: `diff[i] = a1[i] - a2[i]`
2. Initialize: `prefixSum = 0`, `hashMap = {0: -1}` (handles case when subarray starts at index 0)
3. For each index `i`:
   - Add `diff[i]` to `prefixSum`
   - If `prefixSum` exists in hashMap:
     - Update `maxLength = max(maxLength, i - hashMap[prefixSum])`
   - Else:
     - Store `hashMap[prefixSum] = i`
4. Return `maxLength`

### Time Complexity: O(n)
### Space Complexity: O(n)

## Problem Link

[GeeksforGeeks - Longest Span in Two Binary Arrays](https://www.geeksforgeeks.org/problems/longest-span-with-same-sum-in-two-binary-arrays5142/1)
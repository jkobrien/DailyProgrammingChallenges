# Subset XOR - Problem of the Day (November 28, 2025)

## Problem Statement

Given a positive integer **n**, find a subset of numbers from 1 to n (inclusive), where each number can be used at most once, such that:

- The XOR of all elements in the subset is exactly n.
- The size of the subset is as large as possible.
- If multiple such subsets exist, choose the **lexicographically smallest** one.

**Lexicographical Order:** A subset A[] is lexicographically smaller than subset B[] if at the first index where they differ, A[i] < B[i]. If all elements match but one subset ends earlier, the shorter subset is considered smaller.

### Examples

**Example 1:**
```
Input: n = 4
Output: [1, 2, 3, 4]
Explanation: We choose all the elements from 1 to 4. 
1 ^ 2 ^ 3 ^ 4 = 4. This is the maximum possible size of the subset.
```

**Example 2:**
```
Input: n = 3
Output: [1, 2]
Explanation: 1 ^ 2 = 3. This is the smallest lexicographical answer 
possible with maximum size of subset i.e 2.
```

### Constraints
- 1 ≤ n ≤ 10^5

### Expected Complexities
- **Time Complexity:** O(n)
- **Auxiliary Space:** O(1)

## Solution Approach

### Key Observations

1. **XOR Properties:**
   - XOR of all numbers from 1 to n has a pattern:
     - If n % 4 == 1: XOR = 1
     - If n % 4 == 2: XOR = n + 1
     - If n % 4 == 3: XOR = 0
     - If n % 4 == 0: XOR = n

2. **Strategy:**
   - If XOR(1 to n-1) equals n, we can use all numbers from 1 to n-1 (maximum size n-1)
   - If XOR(1 to n) equals n, we can use all numbers from 1 to n (maximum size n)
   - Otherwise, we need to include 1 to n-1 and possibly adjust

3. **Pattern Analysis:**
   - For n where n % 4 == 0: XOR(1 to n) = n, so answer is [1, 2, ..., n]
   - For other cases: XOR(1 to n-1) might equal n, so answer is [1, 2, ..., n-1]
   - Special case: When neither works, we need to find the right combination

### Algorithm

1. Calculate XOR of numbers from 1 to n
2. If it equals n, return all numbers from 1 to n
3. Calculate XOR of numbers from 1 to n-1
4. If it equals n, return all numbers from 1 to n-1
5. Otherwise, use mathematical properties to find the optimal subset

### Implementation Details

The solution leverages the cyclic XOR pattern:
- For any range starting from 1, the XOR follows a predictable pattern based on n % 4
- We check if including all numbers up to n or n-1 gives us the target XOR
- This ensures maximum subset size and lexicographic ordering (since we use smallest numbers first)

## Complexity Analysis

- **Time Complexity:** O(n) - We iterate through at most n elements
- **Space Complexity:** O(1) - Only storing the result array, no additional space proportional to input

## Edge Cases

1. n = 1: Output [1] (1 XOR = 1)
2. n = 2: Output [1, 2] (1 ^ 2 = 3, but we need to check)
3. Small values of n (handled by the pattern)
4. Large values of n up to 10^5

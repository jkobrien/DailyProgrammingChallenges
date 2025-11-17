# Max Sum Increasing Subsequence

**Date:** November 17, 2025  
**Difficulty:** Medium  
**Accuracy:** 40.02%  
**Company Tags:** Morgan Stanley, Amazon, Microsoft  
**Topic Tags:** Dynamic Programming, Algorithms

## Problem Statement

Given an array of positive integers `arr[]`, find the **maximum sum** of a subsequence such that the elements of the subsequence form a **strictly increasing sequence**.

In other words, among all strictly increasing subsequences of the array, return the one with the **largest possible sum**.

## Examples

### Example 1
```
Input: arr[] = [1, 101, 2, 3, 100]
Output: 106
Explanation: The maximum sum of an increasing sequence is obtained from [1, 2, 3, 100].
```

### Example 2
```
Input: arr[] = [4, 1, 2, 3]
Output: 6
Explanation: The maximum sum of an increasing sequence is obtained from [1, 2, 3].
```

### Example 3
```
Input: arr[] = [4, 1, 2, 4]
Output: 7
Explanation: The maximum sum of an increasing sequence is obtained from [1, 2, 4].
```

## Constraints
- 1 ≤ arr.size() ≤ 10³
- 1 ≤ arr[i] ≤ 10⁵

## Expected Complexity
- **Time Complexity:** O(n log n) or O(n²)
- **Space Complexity:** O(n)

## Solution Approach

This problem is a variation of the classic **Longest Increasing Subsequence (LIS)** problem. Instead of finding the longest subsequence, we need to find the one with the maximum sum.

### Dynamic Programming Solution

#### Key Insight
We use dynamic programming where `dp[i]` represents the maximum sum of an increasing subsequence ending at index `i`.

#### Algorithm Steps

1. **Initialize DP Array**
   - Create a `dp` array of size `n` (length of input array)
   - Initialize each `dp[i]` with `arr[i]` (each element can form a subsequence by itself)

2. **Build DP Array**
   - For each position `i` from 1 to n-1:
     - For each previous position `j` from 0 to i-1:
       - If `arr[j] < arr[i]` (strictly increasing condition):
         - We can extend the subsequence ending at `j` to include `arr[i]`
         - Update: `dp[i] = max(dp[i], dp[j] + arr[i])`

3. **Find Maximum Sum**
   - The answer is the maximum value in the `dp` array

#### Recurrence Relation
```
dp[i] = max(dp[i], dp[j] + arr[i]) for all j < i where arr[j] < arr[i]
Base case: dp[i] = arr[i]
```

### Walkthrough Example

For `arr[] = [1, 101, 2, 3, 100]`:

```
Initial: dp = [1, 101, 2, 3, 100]

i=1 (arr[1]=101):
  j=0: arr[0]=1 < 101 → dp[1] = max(101, 1+101) = 102

i=2 (arr[2]=2):
  j=0: arr[0]=1 < 2 → dp[2] = max(2, 1+2) = 3
  j=1: arr[1]=101 > 2 → skip

i=3 (arr[3]=3):
  j=0: arr[0]=1 < 3 → dp[3] = max(3, 1+3) = 4
  j=1: arr[1]=101 > 3 → skip
  j=2: arr[2]=2 < 3 → dp[3] = max(4, 3+3) = 6

i=4 (arr[4]=100):
  j=0: arr[0]=1 < 100 → dp[4] = max(100, 1+100) = 101
  j=1: arr[1]=101 > 100 → skip
  j=2: arr[2]=2 < 100 → dp[4] = max(101, 3+100) = 103
  j=3: arr[3]=3 < 100 → dp[4] = max(103, 6+100) = 106

Final: dp = [1, 102, 3, 6, 106]
Maximum = 106
Subsequence: [1, 2, 3, 100]
```

## Complexity Analysis

### Time Complexity: O(n²)
- Outer loop runs `n` times (for each element)
- Inner loop runs up to `i` times for each outer iteration
- Total: O(1 + 2 + 3 + ... + n) = O(n²)

### Space Complexity: O(n)
- We use a single DP array of size `n`
- Additional space for parent tracking (if reconstructing path): O(n)

## PowerShell Implementation

The solution includes two functions:

1. **Get-MaxSumIncreasingSubsequence**
   - Returns only the maximum sum
   - Optimized for memory and performance

2. **Get-MaxSumIncreasingSubsequenceWithPath**
   - Returns both the maximum sum and the actual subsequence
   - Uses parent tracking to reconstruct the path

## Running the Solution

### Execute the main script
```powershell
.\max_sum_increasing_subsequence.ps1
```

### Run comprehensive tests
```powershell
.\test_max_sum_increasing_subsequence.ps1
```

### Use as a module
```powershell
. .\max_sum_increasing_subsequence.ps1
$result = Get-MaxSumIncreasingSubsequence -arr @(1, 101, 2, 3, 100)
Write-Host "Maximum Sum: $result"
```

## Test Results

All 12 test cases pass, including:
- Example test cases from the problem
- Edge cases (single element, two elements)
- Sorted arrays (ascending and descending)
- Arrays with duplicates
- Large values
- Complex cases with multiple possible subsequences

## Related Problems

- Longest Increasing Subsequence (LIS)
- Maximum Sum Bitonic Subsequence
- Box Stacking Problem
- Russian Doll Envelopes

## Key Takeaways

1. This is a classic DP problem that builds on the LIS concept
2. The strictly increasing condition is enforced by checking `arr[j] < arr[i]`
3. Each element's maximum sum depends on previously computed values
4. The solution can be extended to track the actual subsequence using parent pointers

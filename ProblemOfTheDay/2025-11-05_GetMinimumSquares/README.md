# Get Minimum Squares

**Difficulty:** Medium  
**Accuracy:** 45.22%  
**Company Tags:** Amazon, Microsoft, Wipro  
**Topic Tags:** Dynamic Programming, Mathematical, Recursion, Algorithms

## Problem Statement

Given a positive integer **n**, find the minimum number of perfect squares (square of an integer) that sum up to **n**.

**Note:** Every positive integer can be expressed as a sum of square numbers since 1 is a perfect square, and any number can be represented as 1*1 + 1*1 + 1*1 + ....

## Examples

### Example 1
```
Input: n = 100
Output: 1
Explanation: 10 * 10 = 100
```

### Example 2
```
Input: n = 6
Output: 3
Explanation: 1 * 1 + 1 * 1 + 2 * 2 = 6
```

## Constraints
- 1 ≤ n ≤ 10^4

## Expected Complexities
- **Time Complexity:** O(n * √n)
- **Space Complexity:** O(n)

## Solution Approach

This is a classic **Dynamic Programming** problem known as the "Perfect Squares" problem.

### Algorithm

1. **Base Case:** 
   - If n is a perfect square itself, the answer is 1
   - dp[0] = 0 (zero squares needed to sum to 0)

2. **DP Array:**
   - Create a dp array where `dp[i]` represents the minimum number of perfect squares that sum to i
   - Initialize all values to infinity (or a large number)

3. **State Transition:**
   - For each number i from 1 to n:
     - Try all perfect squares j² ≤ i
     - Update: `dp[i] = min(dp[i], dp[i - j²] + 1)`
   - This means: to get sum i, we can use a square j² and add it to the minimum squares needed for (i - j²)

4. **Optimization:**
   - First check if n itself is a perfect square
   - Use Lagrange's Four Square Theorem: every natural number can be represented as sum of at most 4 perfect squares

### Example Walkthrough (n = 6)

```
dp[0] = 0
dp[1] = dp[0] + 1 = 1  (1² = 1)
dp[2] = dp[1] + 1 = 2  (1² + 1² = 2)
dp[3] = dp[2] + 1 = 3  (1² + 1² + 1² = 3)
dp[4] = dp[0] + 1 = 1  (2² = 4)
dp[5] = dp[4] + 1 = 2  (2² + 1² = 5)
dp[6] = min(dp[5] + 1, dp[2] + 1) = min(3, 3) = 3  (2² + 1² + 1² = 6)
```

## Key Insights

- **Perfect Square Check:** If n is already a perfect square, return 1 immediately
- **Dynamic Programming:** Build up solutions for smaller numbers to solve larger ones
- **Optimization:** We only need to check squares up to √n for each position
- **Lagrange's Theorem:** The answer is always between 1 and 4

## Time and Space Analysis

- **Time Complexity:** O(n * √n)
  - Outer loop runs n times
  - Inner loop runs √n times for each position
  
- **Space Complexity:** O(n)
  - DP array of size n+1

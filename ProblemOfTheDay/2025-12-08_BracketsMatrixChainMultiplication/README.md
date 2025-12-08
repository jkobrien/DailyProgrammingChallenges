# Brackets in Matrix Chain Multiplication

**Difficulty:** Hard  
**Accuracy:** 59.66%  
**Company Tags:** Microsoft  
**Topic Tags:** Dynamic Programming, Matrix, Data Structures, Algorithms

## Problem Description

Given an array `arr[]` of length `n` used to denote the dimensions of a series of matrices such that the dimension of `i'th` matrix is `arr[i] * arr[i+1]`. There are a total of `n-1` matrices. Find the most efficient way to multiply these matrices together.

Your task is to return the **string** which is formed of **A - Z** (only Uppercase) denoting matrices & **Brackets** ( "(" ")" ) denoting multiplication symbols.

### Key Points:
1. Each multiplication is denoted by putting open & closed brackets to the matrices multiplied
2. Matrix multiplication is non-commutative: A*B != B*A
3. There can be multiple possible answers - return any string that performs minimum number of multiplications
4. Matrices are denoted as A, B, C, ... Z (n <= 26)

## Examples

### Example 1:
**Input:** `arr[] = [40, 20, 30, 10, 30]`  
**Output:** `((A(BC))D)`  
**Explanation:** 
- Matrices: A[40,20], B[20,30], C[30,10], D[10,30]
- First multiply B & C -> (BC): cost = 20*30*10 = 6,000
- Then multiply A with (BC) -> (A(BC)): cost += 40*20*10 = 8,000
- Finally multiply D with (A(BC)) -> ((A(BC))D): cost += 40*10*30 = 12,000
- Total cost: 26,000

### Example 2:
**Input:** `arr[] = [10, 20, 30]`  
**Output:** `(AB)`  
**Explanation:** Only one way to multiply two matrices. Cost = 10*20*30 = 6,000

### Example 3:
**Input:** `arr[] = [10, 20, 30, 40]`  
**Output:** `((AB)C)`  
**Explanation:** 
- Option 1: ((AB)C) costs 10*20*30 + 10*30*40 = 18,000
- Option 2: (A(BC)) costs 20*30*40 + 10*20*40 = 32,000
- Minimum is option 1: ((AB)C)

## Constraints
- 2 ≤ arr.size() ≤ 50
- 1 ≤ arr[i] ≤ 100

## Expected Complexity
- **Time Complexity:** O(n³)
- **Auxiliary Space:** O(n²)

## Solution Approach

This is a classic **Matrix Chain Multiplication** problem with an extension to return the bracket placement.

### Algorithm:

1. **Dynamic Programming Table Setup:**
   - `dp[i][j]` stores the minimum cost to multiply matrices from i to j
   - `bracket[i][j]` stores the optimal split point k for matrices i to j

2. **Bottom-Up DP:**
   - For each chain length l from 2 to n-1
   - For each starting position i
   - Try all possible split points k between i and j
   - Find the split k that minimizes: `dp[i][k] + dp[k+1][j] + arr[i]*arr[k+1]*arr[j+1]`

3. **Reconstruct Bracket String:**
   - Use the `bracket` table to recursively build the parenthesized expression
   - Assign matrix names A, B, C, etc. in order
   - Recursively add brackets based on optimal split points

### Key Insights:
- The cost of multiplying matrices from i to j with split at k is:
  - Cost of left subproblem (i to k)
  - \+ Cost of right subproblem (k+1 to j)  
  - \+ Cost of final multiplication: `arr[i] * arr[k+1] * arr[j+1]`

- Matrix A[i] has dimensions `arr[i] × arr[i+1]`

## Related Problem
This extends the standard Matrix Chain Multiplication (finding minimum cost) by also tracking the bracket placement that achieves this minimum cost.

**GeeksforGeeks Article:** [Printing Brackets Matrix Chain Multiplication Problem](https://www.geeksforgeeks.org/printing-brackets-matrix-chain-multiplication-problem/)

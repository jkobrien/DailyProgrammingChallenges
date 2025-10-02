# Unique K-Number Sum (GeeksforGeeks POTD — 2 Oct 2025)

## Problem
Given two integers n and k, find all valid combinations of k distinct numbers from 1 to 9 that sum to n. Each number can be used at most once.

## Approach
- Use backtracking to generate all k-length combinations from [1..9] whose sum is n.
- Prune branches where the sum exceeds n or the path exceeds k elements.

## Example
Input: n = 9, k = 3  
Output: [ [1,2,6], [1,3,5], [2,3,4] ]

## How to run
1. Open PowerShell and navigate to the folder `ProblemOfTheDay/2025-10-02_UniqueKNumberSum`.
2. Execute: `pwsh -File .\unique_k_number_sum.ps1`

This will run the included example tests and print pass/fail results.

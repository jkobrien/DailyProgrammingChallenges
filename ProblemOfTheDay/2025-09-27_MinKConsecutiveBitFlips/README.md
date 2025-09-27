# Minimum K Consecutive Bit Flips (GeeksforGeeks POTD — 27 Sep 2025)

## Problem
Given a binary array arr[] and integer k, in one operation you can select a contiguous subarray of length k and flip all its bits. Find the minimum number of such operations to make the entire array all 1's. If impossible, return -1.

## Approach
- Use a greedy + sliding window approach with a difference array to efficiently track flips.
- For each position, if the current bit (after flips) is 0, flip at this position (if possible). If not enough room to flip, return -1.
- This is O(n) time and O(n) space.

## Example
Input: arr = [1,1,0,0,0,1,1,0,1,1,1], k = 2  
Output: 4

## How to run
1. Open PowerShell and navigate to the folder `ProblemOfTheDay/2025-09-27_MinKConsecutiveBitFlips`.
2. Execute: `pwsh -File .\min_k_consecutive_bit_flips.ps1`

This will run the included example tests and randomized small tests validated by a brute-force checker.

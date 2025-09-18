# Next Greater Element in Circular Array - POTD 18 Sep 2025

## Problem

Given a circular integer array `nums`, for each element find the next greater
element to its right (clockwise). If such an element doesn't exist, return -1
for that index.

## Approach

Use a monotonic decreasing stack of indices. Iterate through the array twice (0 to 2*n-1),
using modulo to simulate circularity. While the current element is greater than
nums[stack.Peek()], we've found the next greater element for that popped index.

## Complexity

Time: O(n)
Space: O(n)

## Files

- `next_greater_circular.ps1` - Implementation: `Invoke-NextGreaterCircular -Nums <int[]>`
- `test_next_greater_circular.ps1` - Tests covering several cases

## Usage

pwsh -File .\test_next_greater_circular.ps1

or

. .\next_greater_circular.ps1
Invoke-NextGreaterCircular -Nums @(1,2,1)

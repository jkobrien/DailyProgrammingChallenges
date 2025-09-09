# Assign Mice Holes - Solution Explanation

## Problem Recap
Given two arrays of equal length, `mices[]` and `holes[]`, representing positions on a line, assign each mouse to a unique hole so that the maximum time taken by any mouse to reach its assigned hole is minimized. Each move (left/right) takes 1 minute.

## Approach
- **Sort** both arrays.
- Pair the ith mouse with the ith hole.
- The answer is the **maximum absolute difference** between the paired positions.

This greedy approach works because sorting ensures that the largest gaps are minimized when pairing closest available positions.

## Example
- Input: `mices = [4, -4, 2]`, `holes = [4, 0, 5]`
- Sorted: `mices = [-4, 2, 4]`, `holes = [0, 4, 5]`
- Pairings: (-4,0), (2,4), (4,5)
- Times: 4, 2, 1
- Maximum: **4**

## How to Run
1. Open PowerShell.
2. Navigate to the script directory.
3. Run: `./assign_mice_holes.ps1`

The script will print results for the provided test cases.

# Minimize the Heights II - GeeksforGeeks Problem of the Day (September 12, 2025)

## Problem Statement

Given an array of non-negative integers representing heights and an integer K, you may either increase or decrease each height by K (once). After modification, heights must remain non-negative. Find the minimum possible difference between the maximum and minimum heights.

**Difficulty:** Medium  
**Companies:** Microsoft, Adobe  
**Tags:** Arrays, Greedy

## Approach & Algorithm

This problem uses a **greedy approach** with the following key insights:

1. **Sort the array first** - This allows us to consider optimal partitioning strategies
2. **Try different split points** - For each position, consider making elements before it +K and elements after it -K
3. **Track minimum difference** - Keep the smallest range found across all partitions

### Algorithm Steps:

1. Sort the input array
2. Initialize answer as the original range (max - min)
3. For each split point i from 1 to n-1:
   - Calculate potential maximum: `max(arr[i-1] + K, arr[n-1] - K)`
   - Calculate potential minimum: `min(arr[0] + K, max(0, arr[i] - K))`
   - Update answer with minimum difference found
4. Return the minimum difference

### Time Complexity: O(n log n) - dominated by sorting
### Space Complexity: O(1) - only using a few variables

## Example Walkthrough

**Input:** `[1, 5, 8, 10]`, `K = 2`

1. **Sorted:** `[1, 5, 8, 10]`
2. **Initial range:** `10 - 1 = 9`
3. **Try split at index 1:** Elements `[1]` → +K, Elements `[5,8,10]` → -K
   - Max: `max(1+2, 10-2) = max(3, 8) = 8`
   - Min: `min(1+2, 5-2) = min(3, 3) = 3`
   - Range: `8 - 3 = 5` ✓
4. **Try other splits...**
5. **Result:** `5`

## Files

- `minimize_heights_ii.ps1` - Main PowerShell implementation
- `test_minimize_heights_ii.ps1` - Unit tests with multiple test cases
- `README.md` - This documentation

## Usage

### Run the Solution
```powershell
# Import the function
. .\minimize_heights_ii.ps1

# Test with example
$result = Minimize-HeightsII -Heights @(1,5,8,10) -K 2
Write-Host "Result: $result"
```

### Run All Tests
```powershell
pwsh -File .\test_minimize_heights_ii.ps1
```

## Test Cases

| Input Heights | K | Expected Output | Explanation |
|---------------|---|-----------------|-------------|
| `[1]` | 5 | 0 | Single element, no difference |
| `[1,2]` | 1 | 1 | Best case: [2,1] or [0,3], range = 1 |
| `[3,9,12]` | 3 | 3 | Optimal partitioning achieves range of 3 |
| `[1,5,8,10]` | 2 | 5 | Example from problem description |
| `[0,10]` | 5 | 0 | Can make both elements equal to 5 |

All tests pass successfully! ✅

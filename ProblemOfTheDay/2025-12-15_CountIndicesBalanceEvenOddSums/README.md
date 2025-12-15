# Count Indices to Balance Even and Odd Sums

**Difficulty**: Medium  
**Problem Link**: https://www.geeksforgeeks.org/problems/count-indices-to-balance-even-and-odd-sums/1

## Problem Statement

Given an array `arr[]`, count the **number of indices** such that deleting the element at that index and shifting all elements after it one position left results in an array where the **sum** of elements at **even** indices equals the sum at **odd** indices.

### Examples

**Example 1:**
```
Input: arr[] = [2, 1, 6, 4]
Output: 1
Explanation: After removing arr[1], the resulting array will be [2, 6, 4]
  - Sum at even indices: arr[0] + arr[2] = 2 + 4 = 6
  - Sum at odd indices: arr[1] = 6
  - Both sums are equal, so count = 1
```

**Example 2:**
```
Input: arr[] = [1, 1, 1]
Output: 3
Explanation: Removing any element makes the sum of odd and even indexed elements equal.
  - Remove index 0: [1, 1] → even sum = 1, odd sum = 1 ✓
  - Remove index 1: [1, 1] → even sum = 1, odd sum = 1 ✓
  - Remove index 2: [1, 1] → even sum = 1, odd sum = 1 ✓
```

### Constraints
- 1 ≤ arr.size() ≤ 10^5
- 0 ≤ arr[i] ≤ 10^4

## Algorithm Explanation

### Approach: Prefix Sum with Index Tracking

The key insight is that when we remove an element at index `i`:
1. All elements before index `i` keep their positions (and their even/odd classification)
2. All elements after index `i` shift one position left (their even/odd classification flips)

For example, if we remove index 2 from [a₀, a₁, a₂, a₃, a₄]:
- Before removal: indices are [0(even), 1(odd), 2(even), 3(odd), 4(even)]
- After removal: [a₀, a₁, a₃, a₄] with indices [0(even), 1(odd), 2(even), 3(odd)]
- Notice: a₃ was at odd index 3, now at even index 2; a₄ was at even index 4, now at odd index 3

### Key Observations:
1. **Before removal at index i**:
   - Sum of even-indexed elements from 0 to i-1
   - Sum of odd-indexed elements from 0 to i-1
   - Sum of even-indexed elements from i+1 to n-1
   - Sum of odd-indexed elements from i+1 to n-1

2. **After removal at index i**:
   - Elements [0 to i-1] maintain their even/odd classification
   - Elements [i+1 to n-1] flip their even/odd classification (due to left shift)

3. **Condition for balance**:
   - New Even Sum = Old Even Sum (0 to i-1) + Old Odd Sum (i+1 to n-1)
   - New Odd Sum = Old Odd Sum (0 to i-1) + Old Even Sum (i+1 to n-1)
   - We need: New Even Sum == New Odd Sum

### Implementation Steps:

1. **Calculate prefix sums**:
   - `prefixEven[i]` = sum of elements at even indices from 0 to i
   - `prefixOdd[i]` = sum of elements at odd indices from 0 to i

2. **Calculate total sums**:
   - `totalEven` = sum of all even-indexed elements
   - `totalOdd` = sum of all odd-indexed elements

3. **For each index i**:
   - Calculate `evenBefore` = sum of even indices before i
   - Calculate `oddBefore` = sum of odd indices before i
   - Calculate `evenAfter` = totalEven - evenBefore - (arr[i] if i is even)
   - Calculate `oddAfter` = totalOdd - oddBefore - (arr[i] if i is odd)
   
4. **After removal**:
   - New even sum = `evenBefore` + `oddAfter` (elements after flip to even)
   - New odd sum = `oddBefore` + `evenAfter` (elements after flip to odd)
   - If equal, increment count

### Time Complexity
- **O(n)**: Single pass to compute prefix sums, another pass to check each index
- Space: O(n) for prefix sum arrays (can be optimized to O(1) with variables)

### Space Complexity
- **O(n)** for storing prefix sums
- Can be optimized to **O(1)** by computing sums on-the-fly

## Solution Files
- `count_indices_balance.ps1` - Main PowerShell solution
- `test_count_indices_balance.ps1` - Test cases
- `README.md` - This file

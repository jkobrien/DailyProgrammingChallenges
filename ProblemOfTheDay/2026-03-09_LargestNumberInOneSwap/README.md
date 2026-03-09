# Largest Number in One Swap

## Problem Description

Given a string `s`, return the **lexicographically largest** string that can be obtained by swapping at most **one pair** of characters in `s`.

## Examples

### Example 1
```
Input: s = "768"
Output: "867"
Explanation: Swapping the 1st and 3rd characters (7 and 8 respectively), gives the lexicographically largest string.
```

### Example 2
```
Input: s = "333"
Output: "333"
Explanation: Performing any swaps gives the same result i.e "333".
```

## Constraints

- `1 ≤ |s| ≤ 10^5`
- `'0' ≤ s[i] ≤ '9'`

## Approach

To get the lexicographically largest string with at most one swap:

1. **Goal**: We want the largest digit as far left as possible
2. **Strategy**: 
   - Traverse the string from left to right
   - For each position `i`, check if there's a larger digit to its right
   - If found, swap with the **rightmost occurrence** of the largest digit (to maximize the result)
   - After one swap, return the result

### Algorithm

1. For each position `i` from left to right:
   - Find the maximum digit in the substring `s[i+1...n-1]`
   - If this maximum digit is greater than `s[i]`:
     - Find the rightmost occurrence of this maximum digit
     - Swap `s[i]` with this rightmost maximum digit
     - Return the result
2. If no swap improves the string, return the original string

### Why rightmost occurrence?

Consider `s = "1993"`:
- At position 0, digit is '1', max in rest is '9'
- We have '9' at positions 1 and 2
- Swapping with rightmost '9' (position 2) gives "9913"
- Swapping with leftmost '9' (position 1) gives "9193"
- "9913" > "9193", so rightmost is better

### Time Complexity
- O(n) where n is the length of the string

### Space Complexity
- O(n) for storing the character array

## Solution Files

- `largest_number_one_swap.ps1` - PowerShell solution implementation
- `test_largest_number_one_swap.ps1` - Test cases to verify the solution
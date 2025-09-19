# Min Add to Make Parentheses Valid - September 19, 2025

## Problem Statement

Given a string `s` consisting of parentheses '(' and ')'. Find the minimum number of parentheses (either '(' or ')') that must be added at any positions to make the string s a valid parentheses string.

A string is valid if every opening parenthesis has a corresponding closing parenthesis and they are properly nested.

## Examples

**Input:** s = "(()("  
**Output:** 2  
**Explanation:** Two ')' are needed to balance the two unmatched '(' parentheses.

**Input:** s = ")))"  
**Output:** 3  
**Explanation:** Three '(' need to be added at the beginning to make the string valid.

**Input:** s = "()"  
**Output:** 0  
**Explanation:** The string is already valid.

**Input:** s = "((("  
**Output:** 3  
**Explanation:** Three ')' need to be added at the end to make the string valid.

## Approach

We use a **Counter/Balance Method** with O(n) time complexity and O(1) space complexity:

1. **Track Balance**: Keep a running balance of unmatched opening parentheses
2. **Count Unmatched Closing**: When balance goes negative, we have unmatched closing parentheses
3. **Final Calculation**: Total additions needed = remaining unmatched opening + unmatched closing

### Algorithm Steps:
1. Initialize `balance = 0` and `unmatchedClosing = 0`
2. For each character in the string:
   - If '(': increment balance
   - If ')': decrement balance
   - If balance becomes negative: increment unmatchedClosing and reset balance to 0
3. Return `balance + unmatchedClosing`

### Why This Works:
- **Balance > 0**: Represents unmatched opening parentheses that need closing ones
- **Balance < 0**: Represents unmatched closing parentheses that need opening ones
- When balance goes negative, we immediately count the unmatched closing and reset

## Time & Space Complexity
- **Time Complexity:** O(n) - single pass through the string
- **Space Complexity:** O(1) - only using constant extra space

## Test Cases Covered
- Empty string
- Already valid parentheses
- Only opening parentheses
- Only closing parentheses  
- Mixed unmatched parentheses
- Complex nested cases

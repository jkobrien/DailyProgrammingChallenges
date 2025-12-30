# Add Number Linked Lists

**Problem of the Day: December 30, 2025**

**Difficulty:** Medium  
**Tags:** Linked List, Data Structures, Two-Pointer Algorithm  
**Companies:** Flipkart, Morgan Stanley, Accolite, Amazon, Microsoft, Snapdeal, MakeMyTrip, Qualcomm

## Problem Statement

You are given the head of two singly linked lists **head1** and **head2** representing two non-negative integers. You have to return the **head** of the linked list representing the **sum** of these two numbers.

**Note:** There can be leading zeros in the input lists, but there should not be any leading zeros in the output list.

## Examples

### Example 1:
```
Input:
head1: 1 -> 2 -> 3
head2: 9 -> 9 -> 9

Output: 1 -> 1 -> 2 -> 2

Explanation: 
Given numbers are 123 and 999. Their sum is 1122.
```

### Example 2:
```
Input:
head1: 6 -> 3
head2: 7

Output: 7 -> 0

Explanation: 
Given numbers are 63 and 7. Their sum is 70.
```

## Constraints

- 1 ≤ Number of nodes in head1, head2 ≤ 10^5
- 0 ≤ node->data ≤ 9

## Approach

The problem requires adding two numbers represented as linked lists. The key insights are:

1. **Reverse both lists** - This allows us to add from the least significant digit (like regular addition)
2. **Add digit by digit** - Process both lists simultaneously, tracking the carry
3. **Handle different lengths** - Continue processing even if one list ends
4. **Handle final carry** - If there's a carry after processing all digits, add it as a new node
5. **Reverse the result** - Since we built the result in reverse order
6. **Remove leading zeros** - As per the problem requirement

## Algorithm

1. Reverse both input linked lists
2. Initialize carry = 0 and create a dummy head for the result
3. Traverse both lists simultaneously:
   - Add values from both nodes (if they exist) plus carry
   - Create a new node with (sum % 10)
   - Update carry = sum / 10
4. If carry remains after processing all nodes, add it
5. Reverse the result list
6. Remove leading zeros from the result
7. Return the head of the result list

## Time Complexity

- **Time:** O(max(m, n)) where m and n are the lengths of the two lists
  - We traverse each list once for reversal
  - We traverse once for addition
  - We traverse once more for final reversal
  
- **Space:** O(max(m, n)) for the result list

## Solution

See `add_number_linked_lists.ps1` for the complete PowerShell implementation.

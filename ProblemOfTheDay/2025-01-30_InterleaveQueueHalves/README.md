# Interleave the First Half of the Queue with Second Half

**Date:** January 30, 2026  
**Difficulty:** Medium  
**Accuracy:** 62.41%  
**Tags:** Stack, Queue, Implementation, Data Structures

## Problem Description

Given a queue `q[]` of even size. Your task is to rearrange the queue by interleaving its first half with the second half.

**Interleaving** is the process of mixing two sequences by alternating their elements while preserving their relative order. In other words, place the first element from the first half, then the first element from the second half, then the second element from the first half, then the second element from the second half, and so on.

## Examples

### Example 1:
```
Input: q[] = [2, 4, 3, 1]
Output: [2, 3, 4, 1]
Explanation: 
- First half: [2, 4]
- Second half: [3, 1]
- Interleaved: [2, 3, 4, 1]
```

### Example 2:
```
Input: q[] = [3, 5]
Output: [3, 5]
Explanation:
- First half: [3]
- Second half: [5]
- Interleaved: [3, 5]
```

## Constraints

- 1 ≤ queue.size() ≤ 10³
- 1 ≤ queue[i] ≤ 10⁵

## Solution Approach

### Algorithm (Using a Stack):

1. **Dequeue the first half** of the queue and push it onto a stack
2. **Dequeue all elements from the stack** and enqueue them back to the queue (this reverses the first half)
3. **Dequeue the first half again** and enqueue it at the back (moves reversed first half to the end)
4. **Dequeue the first half again** and push it onto the stack (reverses it back to original order)
5. **Interleave**: Dequeue from queue (second half), pop from stack (first half), and enqueue them alternately

### Alternative Approach (Using Extra Queue):

1. Dequeue the first half into a temporary queue
2. Interleave elements from the temporary queue (first half) and the original queue (second half)

### Time Complexity: O(n)
### Space Complexity: O(n)

## Links

- [GeeksforGeeks Problem](https://www.geeksforgeeks.org/problems/interleave-the-first-half-of-the-queue-with-second-half/1)

# Maximum People Visible in a Line

**Difficulty:** Medium  
**Source:** GeeksforGeeks Problem of the Day (January 23, 2026)  
**Link:** https://www.geeksforgeeks.org/problems/maximum-people-visible-in-a-line/1

## Problem Description

You are given an array `arr[]`, where `arr[i]` represents the height of the ith person standing in a line.

A person **i** can see another person **j** if:
- `height[j] < height[i]`
- There is no person **k** standing between them such that `height[k] >= height[i]`

Each person can see in both directions (front and back).

Your task is to find the **maximum number of people** that any person can see (including themselves).

## Examples

### Example 1:
```
Input: arr[] = [6, 2, 5, 4, 5, 1, 6]
Output: 6

Explanation:
Person 1 (height = 6) can see five other people at positions (2, 3, 4, 5, 6) in addition to himself, i.e. total 6.
Person 2 (height: 2) can see only himself.
Person 3 (height = 5) is able to see people 2nd, 3rd, and 4th person.
Person 4 (height = 4) can see himself.
Person 5 (height = 5) can see people 4th, 5th, and 6th.
Person 6 (height =1) can only see himself.
Person 7 (height = 6) can see 2nd, 3rd, 4th, 5th, 6th, and 7th people.
A maximum of six people can be seen by Person 1 and Person 7.
```

### Example 2:
```
Input: arr[] = [1, 3, 6, 4]
Output: 4

Explanation:
Person with height 6 can see persons with heights 1, 3 on the left and 4 on the right, along with himself, giving a total of 4.
```

## Constraints
- 1 ≤ arr.size() ≤ 10^4
- 1 ≤ arr[i] ≤ 10^5

## Approach

This problem can be efficiently solved using a **monotonic stack** approach:

### Algorithm:

1. **For each person at position i:**
   - Count visible people to the **left** using a stack
   - Count visible people to the **right** using a stack
   - Total visible = left + right + 1 (including themselves)

2. **Counting visible people to the left:**
   - Use a monotonic decreasing stack
   - For each position, pop all people shorter than current person
   - The count equals the stack size before popping

3. **Counting visible people to the right:**
   - Similar approach but traverse from right to left
   - Or traverse from left to right and reverse the logic

4. **Track the maximum** count across all positions

### Time Complexity: O(n)
- Each element is pushed and popped from the stack at most once

### Space Complexity: O(n)
- For the stack storage

## Key Insights

- A person can see another person if they are taller AND there's no one between them who is equal or taller
- Monotonic stack efficiently tracks the "visible frontier" of people
- We need to check both directions (left and right) for each person
- The person can always see themselves (count starts at 1)

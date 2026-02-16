# Meeting Rooms - GeeksforGeeks Problem of the Day

**Date:** February 16, 2026  
**Difficulty:** Easy  
**Tags:** Sorting, Greedy, Arrays  
**Company Tags:** NPCI

## Problem Statement

Given a 2D array `arr[][]`, where `arr[i][0]` is the **starting time** of i<sup>th</sup> meeting and `arr[i][1]` is the **ending time** of i<sup>th</sup> meeting, the task is to check if it is possible for a person to attend all the meetings such that he can attend only one meeting at a particular time.

**Note:** A person can attend a meeting if its starting time is greater than or equal to the previous meeting's ending time.

## Examples

### Example 1:
**Input:** `arr[][] = [[1, 4], [10, 15], [7, 10]]`  
**Output:** `true`  
**Explanation:** Since all the meetings are held at different times, it is possible to attend all the meetings.

### Example 2:
**Input:** `arr[][] = [[2, 4], [9, 12], [6, 10]]`  
**Output:** `false`  
**Explanation:** Since the second and third meeting overlap, a person cannot attend all the meetings.

## Constraints

- 1 ≤ arr.size() ≤ 10<sup>5</sup>
- 0 ≤ arr[i] ≤ 2×10<sup>6</sup>

## Approach

### Algorithm:
1. **Sort the meetings** by their start time
2. **Check for overlaps** by comparing the end time of the current meeting with the start time of the next meeting
3. If any overlap is found (next start time < current end time), return `false`
4. If no overlaps are found after checking all meetings, return `true`

### Time Complexity: O(n log n)
- Sorting takes O(n log n)
- Checking overlaps takes O(n)

### Space Complexity: O(1)
- No extra space required apart from sorting

## Solution Explanation

The key insight is that if we sort all meetings by their start time, we only need to check consecutive meetings for overlaps. If meeting `i` ends after meeting `i+1` starts, there's an overlap and it's impossible to attend all meetings.

The greedy approach works because:
- If we can't attend two consecutive meetings (after sorting), we can't attend them regardless of the order
- Sorting allows us to check all potential conflicts with a single pass

## Related Articles
- [Meeting Rooms - Check if a person can attend all meetings](https://www.geeksforgeeks.org/meeting-rooms-check-if-a-person-can-attend-all-meetings/)
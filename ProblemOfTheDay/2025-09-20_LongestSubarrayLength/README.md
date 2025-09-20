# Longest Subarray Length (GeeksforGeeks Problem of the Day — 20 Sep 2025)

Problem:
Given an integer array arr[], find the length of the longest contiguous subarray such that
all elements of the subarray are <= length of the subarray.

Approach:
For any contiguous subarray, the condition "all elements <= length" depends on the maximum
value within that subarray. If the maximum value is m and the subarray length is L, the
condition is m <= L. Therefore we can look at each element arr[i] as a candidate for being
"the maximum" of some contiguous segment where no element exceeds arr[i].

For each index i, compute the maximum contiguous span (left..right) where every element is
<= arr[i]. That span can be found in O(n) for all indices using monotonic stacks (previous
greater and next greater indices). If the span length s >= arr[i], then that span supports
subarrays of length up to s where the max <= s, so s is a candidate answer. The final
answer is the maximum span length s among all indices for which s >= arr[i].

Why this works:
Any subarray's maximum must be equal to some element in the array. For that element we
compute the maximal contiguous range around it where no element is greater than it. If that
range's length is >= the element's value, then a subarray satisfying the condition exists
whose length equals that range's length.

Complexity:
- Time: O(n) to compute previous/next greater indices and evaluate spans.
- Space: O(n) for the stacks and auxiliary arrays.

Files:
- `longest_subarray_length.ps1` — PowerShell implementation with test harness.

How to run:
1. Open PowerShell and navigate to the folder `ProblemOfTheDay/2025-09-20_LongestSubarrayLength`.
2. Execute: `pwsh -File .\longest_subarray_length.ps1`

This will run the included tests (edge cases + random small tests validated against a brute-force
checker) and print pass/fail results.

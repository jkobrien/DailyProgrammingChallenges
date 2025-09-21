# Max of min for every window size (GeeksforGeeks POTD - 22 Sep 2025)

Problem:
Given an integer array arr[], for every window size k (1..n) compute the maximum among
all minimums of every contiguous subarray of size k.

Approach:
- For each element arr[i], find the index of previous smaller element and next smaller element
  (strictly smaller). The maximum span for which arr[i] is the minimum is len = nextSmaller - prevSmaller - 1.
- That means arr[i] is a candidate for window size len: ans[len] = max(ans[len], arr[i]).
- After processing all elements, propagate results to smaller window sizes by ans[k] = max(ans[k], ans[k+1]).

Complexity:
- Time: O(n)
- Space: O(n)

Files:
- `max_of_min_every_window_size.ps1` — PowerShell implementation and tests.

How to run:
1. Open PowerShell and navigate to the folder `ProblemOfTheDay/2025-09-22_MaxOfMinEveryWindowSize`.
2. Execute: `pwsh -File .\max_of_min_every_window_size.ps1`

This will run the included example tests and randomized small tests validated by a brute-force checker.

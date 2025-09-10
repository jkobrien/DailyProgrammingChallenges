# Assign Mice Holes (GeeksforGeeks POTD)

Note about fetching POTD for 2025-09-10:
I attempted to fetch the GeeksforGeeks "Problem of the Day" for 10 Sep 2025 but the POTD page for that date is not available on the site at the time of fetching. The most recent published POTD available in the listing was 9 Sep 2025: "Assign Mice Holes" (problem page: https://www.geeksforgeeks.org/problems/assign-mice-holes3053/1). Therefore this folder contains a PowerShell solution for the 9 Sep 2025 POTD "Assign Mice Holes".

Problem summary
--------------
Given two equal-sized arrays mices[] and holes[] containing integer positions (can be negative), assign each mouse to a distinct hole so that the time taken by the slowest mouse to reach its assigned hole is minimized. A move by one unit takes one minute, so time equals the absolute difference of positions.

Approach
--------
Sort both arrays and pair mice and holes element-wise. This greedy approach minimizes the maximum distance for the overall matching and runs in O(n log n) time (sorting dominates). After sorting, the answer is max_i |mices_sorted[i] - holes_sorted[i]|.

Files
-----
- assign_mice_holes.ps1 - The implementation. Accepts -Mice and -Holes parameters (comma separated lists) and prints the minimized maximum time.
- test_assign_mice_holes.ps1 - A simple test harness that runs a handful of sample tests (including the GeeksforGeeks examples) and exits with code 0 if all tests pass.

Usage
-----
From PowerShell (Windows):

# examples
pwsh.exe -NoProfile -Command "& 'path\to\assign_mice_holes.ps1' -Mice '4,-4,2' -Holes '4,0,5'"
# prints: 4

or

pwsh.exe -NoProfile -Command "& 'path\to\test_assign_mice_holes.ps1'"  # runs tests

Notes
-----
- The scripts are intentionally simple and do not depend on external modules.
- Input parsing accepts comma-separated values and optional square-bracket wrappers such as "[1, 2, 3]".

References
----------
GeeksforGeeks problem: Assign Mice Holes — https://www.geeksforgeeks.org/problems/assign-mice-holes3053/1


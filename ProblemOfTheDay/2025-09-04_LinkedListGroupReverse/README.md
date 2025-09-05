# Linked List Group Reverse (GeeksforGeeks POTD — 4 Sep 2025)

Problem: Reverse a singly linked list in groups of size k.

Original problem on GeeksforGeeks:
https://www.geeksforgeeks.org/problems/reverse-a-linked-list-in-groups-of-given-size/1

Solution (PowerShell)
- File: `reverse_linked_list_in_groups.ps1`
- Approach: Reverse the first k nodes of the list, then recursively reverse the remainder and attach it to the tail of the reversed chunk. This implementation follows the GeeksforGeeks convention that if the number of remaining nodes is less than k, that final chunk is left unchanged.
- Time complexity: O(n)
- Space complexity: O(n/k) recursion stack (an iterative approach can be used to achieve O(1) extra space).

How to run
1. Open PowerShell (pwsh).
2. Run the script (it contains tests and will exit 0 on success):

pwsh -NoProfile -ExecutionPolicy Bypass -File "./reverse_linked_list_in_groups.ps1"

What the script does
- Builds example linked lists for several test cases.
- Calls `Reverse-LinkedList-In-Groups` with various `k` values.
- Prints before/after lists and asserts expected outputs.
- Exits with code 0 when all tests pass, or 1 if any test fails.

Notes
- The code uses lightweight PSCustomObject nodes with `data` and `next` properties to model nodes.
- The script includes helper functions for building lists, printing them, and checking equality of results.
- For very large lists and production use, consider an iterative implementation to avoid recursion limits.

If you'd like, I can:
- Add an iterative, constant-space implementation.
- Add a CLI wrapper to pass an input list and k from the command-line.
- Add more test cases or property-based (randomized) testing.

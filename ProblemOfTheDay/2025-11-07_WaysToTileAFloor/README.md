# Ways To Tile A Floor (GeeksforGeeks POTD 2025-11-07)

**Problem:**
Given a 2 x n floor and 2 x 1 tiles, find the number of ways to tile the floor. Tiles can be placed vertically or horizontally. Two arrangements are different if at least one tile is placed differently.

**Approach:**
This is a dynamic programming problem. For each n:
- If you place a tile vertically, you reduce the problem to n-1.
- If you place two tiles horizontally, you reduce the problem to n-2.
So, the recurrence is:

    ways(n) = ways(n-1) + ways(n-2)

with base cases ways(1) = 1, ways(2) = 2.

**PowerShell Solution:**
See `ways_to_tile_floor.ps1` for the implementation.

**How to Run:**
```powershell
# To get the number of ways for n=4
powershell -File ways_to_tile_floor.ps1 -n 4

# To run tests
powershell -File test_ways_to_tile_floor.ps1
```

**Sample Output:**
```
PASSED: n=1 => 1
PASSED: n=2 => 2
PASSED: n=3 => 3
PASSED: n=4 => 5
PASSED: n=5 => 8
PASSED: n=10 => 89
All tests passed!
```

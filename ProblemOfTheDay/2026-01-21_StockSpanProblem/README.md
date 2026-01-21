# Stock Span Problem - POTD 21 Jan 2026

## Problem

The stock span problem is a financial problem where we have a series of daily price quotes for a stock and we need to calculate the span of the stock's price for all days.

**The span S[i]** of the stock's price on a given day `i` is defined as the **maximum number of consecutive days** just before the given day, **for which the price of the stock on the current day is less than or equal to its price on the given day**.

In other words: How many consecutive days (including today) had prices less than or equal to today's price?

## Examples

### Example 1
**Input:** `prices = [100, 80, 60, 70, 60, 75, 85]`  
**Output:** `[1, 1, 1, 2, 1, 4, 6]`

**Explanation:**
- Day 0 (100): span = 1 (just itself)
- Day 1 (80): span = 1 (80 < 100)
- Day 2 (60): span = 1 (60 < 80)
- Day 3 (70): span = 2 (70 > 60, but 70 < 80, so includes days 2-3)
- Day 4 (60): span = 1 (60 < 70)
- Day 5 (75): span = 4 (75 > 60, 70, 60, but 75 < 80, so includes days 2-5)
- Day 6 (85): span = 6 (85 > all previous except 100, so includes days 1-6)

### Example 2
**Input:** `prices = [10, 4, 5, 90, 120, 80]`  
**Output:** `[1, 1, 2, 4, 5, 1]`

**Explanation:**
- Day 0 (10): span = 1
- Day 1 (4): span = 1 (4 < 10)
- Day 2 (5): span = 2 (5 > 4, includes days 1-2)
- Day 3 (90): span = 4 (90 > all previous, includes days 0-3)
- Day 4 (120): span = 5 (120 > all previous, includes all days 0-4)
- Day 5 (80): span = 1 (80 < 120)

## Approach

### Brute Force (Not Recommended)
For each day, scan backwards until finding a price greater than current - **O(n²)** time complexity.

### Optimized Stack-Based Solution
Use a **monotonic decreasing stack** to efficiently track indices of days:

1. Maintain a stack of indices where prices are in decreasing order
2. For each day `i`:
   - **Pop** from stack while stack top's price ≤ current price
   - If stack is **empty**: span = i + 1 (all previous days had lower/equal prices)
   - If stack is **not empty**: span = i - stack.top (days between current and last higher price)
   - **Push** current index to stack

**Key Insight:** When we pop elements, we're removing days that will never be needed again because the current day's price dominates them.

## Complexity

- **Time:** O(n) - each element pushed and popped at most once
- **Space:** O(n) - stack storage (worst case: strictly increasing prices)

## Files

- `stock_span.ps1` - Implementation: `Get-StockSpan -Prices <int[]>` returns span array
- `test_stock_span.ps1` - Comprehensive test suite with 12 test cases
- `README.md` - This file

## Usage

### Run Tests
```powershell
pwsh -File .\test_stock_span.ps1
```

### Use the Function Directly
```powershell
# Import the function
. .\stock_span.ps1

# Calculate spans
$prices = @(100, 80, 60, 70, 60, 75, 85)
$spans = Get-StockSpan -Prices $prices
Write-Host "Spans: [$($spans -join ', ')]"
# Output: Spans: [1, 1, 1, 2, 1, 4, 6]
```

## Algorithm Visualization

For `prices = [100, 80, 60, 70]`:

```
Day 0 (100): Stack=[], Span=1, Push 0 → Stack=[0]
Day 1 (80):  Stack=[0], 80<100, Span=1, Push 1 → Stack=[0,1]
Day 2 (60):  Stack=[0,1], 60<80, Span=1, Push 2 → Stack=[0,1,2]
Day 3 (70):  Stack=[0,1,2], 70>60 Pop(2), 70<80, Span=3-1=2, Push 3 → Stack=[0,1,3]
```

The stack maintains indices in decreasing order of their corresponding prices!

## Problem Link

[GeeksforGeeks - Stock Span Problem](https://www.geeksforgeeks.org/problems/stock-span-problem-1587115621/1)

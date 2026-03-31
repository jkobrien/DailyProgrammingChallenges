# Buy Stock with Transaction Fee

**Difficulty:** Medium  
**Accuracy:** 57.41%  
**Date:** March 31, 2026

## Problem Statement

You are given an array `arr[]`, where `arr[i]` is the price of a given stock on the `i-th` day, and an integer `k` representing a transaction fee. Find the **maximum profit** you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

**Note:** A transaction consists of buying and then selling a stock. You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

### Examples

**Example 1:**
```
Input: arr[] = [1, 3, 2, 8, 4, 9], k = 2
Output: 8
Explanation: 
Transaction 1: Buy at price 1, sell at price 8. Profit = 8 - 1 - 2 = 5
Transaction 2: Buy at price 4, sell at price 9. Profit = 9 - 4 - 2 = 3
Total profit = 5 + 3 = 8
```

**Example 2:**
```
Input: arr[] = [1, 3, 7, 5, 10, 3], k = 3
Output: 6
Explanation:
Transaction 1: Buy at price 1, sell at price 10. Profit = 10 - 1 - 3 = 6
Total profit = 6
```

**Example 3:**
```
Input: arr[] = [5, 4, 3, 2, 1], k = 1
Output: 0
Explanation: 
Prices are continuously decreasing, no profitable transaction possible.
```

### Constraints
- 1 ≤ arr.size() ≤ 10^5
- 1 ≤ arr[i] ≤ 10^5
- 0 ≤ k ≤ 10^5

### Expected Complexity
- **Time Complexity:** O(n)
- **Space Complexity:** O(1)

## Solution Approach

This is a dynamic programming problem with state management. At any given day, we can be in one of two states:

1. **Holding a stock** - We bought a stock and haven't sold it yet
2. **Not holding a stock (cash)** - We don't have a stock and can buy today

### State Transitions

For each day `i`, we track:
- `hold`: Maximum profit if we're holding a stock at the end of day `i`
- `cash`: Maximum profit if we're not holding a stock at the end of day `i`

The transitions are:
- **hold[i]** = max(hold[i-1], cash[i-1] - prices[i])
  - Either we already held from previous day, or we buy today (pay the price)
- **cash[i]** = max(cash[i-1], hold[i-1] + prices[i] - fee)
  - Either we continue not holding, or we sell today (get the price minus the fee)

### Why we subtract fee when selling?

The transaction fee can be paid either when buying or selling - mathematically it's equivalent. We choose to pay when selling for simplicity.

### Space Optimization

Since we only need the previous day's values, we can optimize space from O(n) to O(1) by using variables instead of arrays.

### Algorithm

1. Initialize two state variables: `hold` (start at -prices[0]) and `cash` (start at 0)
2. Iterate through each price starting from day 1
3. Update states based on the transitions
4. Return `cash` (maximum profit when not holding any stock)

## Key Insight

The key difference from the "Stock Buy and Sell with Cooldown" problem is:
- **Cooldown problem:** After selling, must wait 1 day before buying again (3 states)
- **Transaction Fee problem:** No cooldown, but pay a fee per transaction (2 states)

The transaction fee discourages frequent trading - if the potential profit is less than the fee, it's better not to trade.

## PowerShell Implementation Details

The solution uses:
- Dynamic programming with state variables
- `[Math]::Max()` for maximum calculations
- Simple array iteration
- Clear variable naming for readability

## Complexity Analysis

- **Time Complexity:** O(n) - Single pass through the array
- **Space Complexity:** O(1) - Only using constant extra space for state variables
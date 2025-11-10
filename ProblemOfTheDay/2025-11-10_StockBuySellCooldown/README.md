# Stock Buy and Sell with Cooldown

**Difficulty:** Medium  
**Accuracy:** 51.65%  
**Date:** November 10, 2025

## Problem Statement

Given an array `arr[]`, where the `i-th` element of `arr[]` represents the price of a stock on the `i-th` day (all prices are non-negative integers). Find the **maximum profit** you can make by buying and selling stocks such that after selling a stock, you cannot buy again on the **next day** (i.e., there is a one-day cooldown).

### Examples

**Example 1:**
```
Input: arr[] = [0, 2, 1, 2, 3]
Output: 3
Explanation: You first buy on day 1, sell on day 2 then cool down, 
then buy on day 4, and sell on day 5. 
The total profit earned is (2-0) + (3-2) = 3, which is the maximum achievable profit.
```

**Example 2:**
```
Input: arr[] = [3, 1, 6, 1, 2, 4]
Output: 7
Explanation: You first buy on day 2 and sell on day 3 then cool down, 
then again you buy on day 5 and then sell on day 6. 
Clearly, the total profit earned is (6-1) + (4-2) = 7, which is the maximum achievable profit.
```

### Constraints
- 1 ≤ arr.size() ≤ 10^5
- 1 ≤ arr[i] ≤ 10^4

### Expected Complexity
- **Time Complexity:** O(n)
- **Space Complexity:** O(1)

## Solution Approach

This is a dynamic programming problem with state management. At any given day, we can be in one of three states:

1. **Holding a stock** - We bought a stock and haven't sold it yet
2. **Not holding a stock (can buy)** - We don't have a stock and can buy today
3. **Cooldown** - We sold a stock yesterday and must cool down today

### State Transitions

For each day `i`, we track:
- `hold`: Maximum profit if we're holding a stock at the end of day `i`
- `sell`: Maximum profit if we just sold a stock on day `i`
- `cooldown`: Maximum profit if we're in cooldown or ready to buy on day `i`

The transitions are:
- **hold[i]** = max(hold[i-1], cooldown[i-1] - prices[i])
  - Either we already held from previous day, or we buy today after cooldown
- **sell[i]** = hold[i-1] + prices[i]
  - We must have been holding, and we sell today
- **cooldown[i]** = max(cooldown[i-1], sell[i-1])
  - Either we continue not holding, or we just finished cooldown from a previous sell

### Space Optimization

Since we only need the previous day's values, we can optimize space from O(n) to O(1) by using variables instead of arrays.

### Algorithm

1. Initialize three variables for the states
2. Iterate through each price
3. Update states based on the transitions
4. Return the maximum of sell and cooldown (we can't end in hold state for max profit)

## PowerShell Implementation Details

The solution uses:
- Dynamic programming with state variables
- Math operations for maximum calculations
- Array iteration
- Clear variable naming for readability

## Complexity Analysis

- **Time Complexity:** O(n) - Single pass through the array
- **Space Complexity:** O(1) - Only using constant extra space for state variables

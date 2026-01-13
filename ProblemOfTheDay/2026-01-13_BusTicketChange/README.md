# Bus Ticket Change (Lemonade Change)

**Difficulty:** Easy  
**Tags:** Arrays, Greedy, Data Structures, Algorithms  
**Source:** [GeeksforGeeks - Problem of the Day (January 13, 2026)](https://www.geeksforgeeks.org/problems/lemonade-change/1)

## Problem Statement

You are given an array `arr[]` representing passengers in a queue. Each bus ticket costs **5 coins**, and `arr[i]` denotes the note a passenger uses to pay (which can be **5, 10, or 20**). You must serve the passengers in the given order and always provide the correct change so that each passenger effectively pays exactly **5 coins**.

Your task is to determine whether it is possible to serve **all passengers** in the queue without ever running out of change.

## Examples

### Example 1
```
Input: arr[] = [5, 5, 5, 10, 20]
Output: true
Explanation:
- From the first 3 customers, we collect three $5 bills in order.
- From the fourth customer, we collect a $10 bill and give back a $5.
- From the fifth customer, we give a $10 bill and a $5 bill.
- Since all customers got correct change, we return true.
```

### Example 2
```
Input: arr[] = [5, 5, 10, 10, 20]
Output: false
Explanation:
- From the first two customers in order, we collect two $5 bills.
- For the next two customers in order, we collect a $10 bill and give back a $5 bill.
- For the last customer, we cannot give the change of $15 back because we only have two $10 bills.
- Since not every customer received the correct change, the answer is false.
```

## Constraints

- 1 ≤ arr.size() ≤ 10⁵
- arr[i] contains only [5, 10, 20]

## Approach & Algorithm

### Key Insight
This is a **greedy problem** where we need to track the bills we have as change and make optimal decisions at each step.

### Strategy

1. **Track Available Change**: Maintain counters for $5 and $10 bills
   - We don't need to track $20 bills because we never give them as change

2. **Process Each Passenger**:
   - **$5 bill**: No change needed, just keep it
   - **$10 bill**: Give back one $5 (if available)
   - **$20 bill**: Give back $15 change
     - **Prefer**: One $10 + one $5 (preserves more $5 bills)
     - **Alternative**: Three $5 bills
     - This greedy choice is optimal because $5 bills are more versatile

3. **Return Result**: If we successfully serve all passengers, return true

### Why This Greedy Approach Works

- **$5 bills are most valuable** for making change (needed for both $10 and $20 customers)
- **$10 bills are less versatile** (only useful for $20 customers)
- When giving change for $20, preferring $10+$5 over three $5 bills is optimal because:
  - It preserves more $5 bills for future transactions
  - $10 bills have limited use anyway

### Complexity Analysis

- **Time Complexity**: O(n)
  - Single pass through the array
  - Constant time operations for each passenger

- **Space Complexity**: O(1)
  - Only using two integer variables (fives, tens)
  - No additional data structures needed

## Solution Walkthrough

Let's trace through Example 1: `[5, 5, 5, 10, 20]`

| Passenger | Bill | Action | Fives | Tens |
|-----------|------|--------|-------|------|
| Initial   | -    | -      | 0     | 0    |
| 1         | 5    | Keep $5 | 1     | 0    |
| 2         | 5    | Keep $5 | 2     | 0    |
| 3         | 5    | Keep $5 | 3     | 0    |
| 4         | 10   | Give $5, keep $10 | 2 | 1 |
| 5         | 20   | Give $10+$5 | 1 | 0 |

✅ **Result**: Successfully served all passengers!

Let's trace through Example 2: `[5, 5, 10, 10, 20]`

| Passenger | Bill | Action | Fives | Tens |
|-----------|------|--------|-------|------|
| Initial   | -    | -      | 0     | 0    |
| 1         | 5    | Keep $5 | 1     | 0    |
| 2         | 5    | Keep $5 | 2     | 0    |
| 3         | 10   | Give $5, keep $10 | 1 | 1 |
| 4         | 10   | Give $5, keep $10 | 0 | 2 |
| 5         | 20   | Need $15 change... | ? | ? |

At passenger 5:
- Need to give $15 change
- Have: 0 x $5 bills, 2 x $10 bills
- Cannot make $15 with two $10 bills

❌ **Result**: Cannot serve last passenger!

## Edge Cases

1. **All exact change**: `[5, 5, 5]` → `true`
2. **First customer needs change**: `[10]` → `false`
3. **Empty array**: `[]` → `true`
4. **Single large bill**: `[20]` → `false`
5. **Multiple $20 bills with strategy test**: Tests whether we prefer $10+$5 over three $5 bills

## PowerShell Implementation

The solution includes:
- ✅ Complete function with parameter validation
- ✅ Comprehensive inline documentation
- ✅ Built-in test cases
- ✅ Color-coded output for easy verification
- ✅ O(n) time complexity, O(1) space complexity

## Usage

### Running the Script
```powershell
# Run with built-in test cases
.\bus_ticket_change.ps1

# Import and use the function
. .\bus_ticket_change.ps1
Get-BusTicketChange -arr @(5, 5, 5, 10, 20)  # Returns: True
```

### Running Tests
```powershell
.\test_bus_ticket_change.ps1
```

## Related Problems

- Change Making Problem
- Coin Change (Dynamic Programming variant)
- Greedy Algorithm applications

## Tags

`#Greedy` `#Arrays` `#Simulation` `#ProblemSolving` `#GeeksforGeeks` `#POTD`

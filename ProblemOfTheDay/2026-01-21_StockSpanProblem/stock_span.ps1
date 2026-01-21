<#
Stock Span Problem - PowerShell Implementation

Problem:
The stock span problem is a financial problem where we have a series of daily price 
quotes for a stock and we need to calculate the span of the stock's price for all days.

The span S[i] of the stock's price on a given day i is defined as the maximum number 
of consecutive days just before the given day, for which the price of the stock on 
the current day is less than or equal to its price on the given day.

For example, if an array of 7 days prices is given as {100, 80, 60, 70, 60, 75, 85}, 
then the span values for corresponding 7 days are {1, 1, 1, 2, 1, 4, 6}.

Approach (Stack-based, O(n)):
The brute force approach would be O(n²) - for each element, scan backwards until we 
find a larger element. Instead, we use a stack to maintain indices of previous days 
in a way that helps us calculate spans efficiently.

Algorithm:
1. Create a stack to store indices of array elements
2. For each day i:
   - While stack is not empty AND price at stack top is <= current price:
     * Pop from stack (these days have smaller/equal prices)
   - If stack is empty after popping:
     * Span = i + 1 (all previous days had smaller/equal prices)
   - Else:
     * Span = i - stack.top (days between current and last higher price)
   - Push current index i onto stack
   - Store the calculated span

The key insight: The stack maintains indices in decreasing order of their prices.
When we pop elements, we're eliminating days that will never be used again because
the current day's price is higher.

Time Complexity: O(n) - each element is pushed and popped at most once
Space Complexity: O(n) - for the stack in worst case (strictly increasing prices)
#>

function Get-StockSpan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$Prices
    )

    $n = $Prices.Length
    if ($n -eq 0) { return @() }
    if ($n -eq 1) { return @(1) }

    $span = @(0) * $n
    $stack = New-Object System.Collections.Generic.Stack[int]

    for ($i = 0; $i -lt $n; $i++) {
        # Pop elements from stack while stack is not empty and 
        # price at top of stack is less than or equal to current price
        while ($stack.Count -gt 0 -and $Prices[$stack.Peek()] -le $Prices[$i]) {
            [void]$stack.Pop()
        }

        # If stack is empty, then price[i] is greater than all elements
        # on left side, so span = i + 1
        # Otherwise, price[i] is greater than elements after top of stack
        # so span = i - stack.top
        if ($stack.Count -eq 0) {
            $span[$i] = $i + 1
        } else {
            $span[$i] = $i - $stack.Peek()
        }

        # Push this element's index to stack
        $stack.Push($i)
    }

    return $span
}

# Example usage when dot-sourced
if ($MyInvocation.InvocationName -eq '.') {
    Write-Host "Example 1: [100, 80, 60, 70, 60, 75, 85]"
    $result1 = Get-StockSpan -Prices @(100, 80, 60, 70, 60, 75, 85)
    Write-Host "Spans: [$($result1 -join ', ')]"
    Write-Host ""
    
    Write-Host "Example 2: [10, 4, 5, 90, 120, 80]"
    $result2 = Get-StockSpan -Prices @(10, 4, 5, 90, 120, 80)
    Write-Host "Spans: [$($result2 -join ', ')]"
}

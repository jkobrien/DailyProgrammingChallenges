<#
Gas Station (Circular Tour) - PowerShell implementation
Problem (paraphrased):
Given two integer arrays gas[] and cost[] of length n, return the starting gas station's
index if you can travel around the circuit once in the clockwise direction; otherwise return -1.
At station i you can fill up gas[i] and moving to station (i+1) costs cost[i].

Approach (Greedy, O(n)):
1. If total gas < total cost, the trip is impossible -> return -1.
2. Otherwise, iterate through stations keeping a running tank. If tank becomes negative
   at station i, you cannot start from any station in the range [start, i] -> set start=i+1 and reset tank=0.
3. After a full pass, the recorded start is the answer.

Time complexity: O(n)
Space complexity: O(1)
#>

function Find-GasStation {
    [CmdletBinding()]
    param(
        [int[]]$Gas = @(),
        [int[]]$Cost = @()
    )

    if ($null -eq $Gas -or $null -eq $Cost) {
        # Treat missing arrays as empty arrays to allow callers to pass @() or omit values
        if ($null -eq $Gas) { $Gas = @() }
        if ($null -eq $Cost) { $Cost = @() }
    }
    if ($Gas.Count -ne $Cost.Count) {
        throw "Gas and Cost arrays must have the same length"
    }

    $n = $Gas.Count
    if ($n -eq 0) { return -1 }

    $total = 0
    $tank = 0
    $start = 0

    for ($i = 0; $i -lt $n; $i++) {
        $diff = $Gas[$i] - $Cost[$i]
        $total += $diff
        $tank += $diff
        if ($tank -lt 0) {
            # cannot start from 'start' to 'i'
            $start = $i + 1
            $tank = 0
        }
    }

    if ($total -lt 0) { return -1 }
    if ($start -ge $n) { return -1 }
    return $start
}

# Quick example when file is dot-sourced directly
if ($MyInvocation.InvocationName -eq '.') {
    $gas = @(1,2,3,4,5)
    $cost = @(3,4,5,1,2)
    Write-Host "Example: start index ->" (Find-GasStation -Gas $gas -Cost $cost)
}

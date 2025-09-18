<#
Next Greater Element in Circular Array - PowerShell implementation
Problem (paraphrased):
Given a circular integer array `nums`, for each element find the next greater
element to its right (clockwise). If such an element doesn't exist, return -1
for that index.

Example:
Input: [1, 2, 1]
Output: [2, -1, 2]

Approach (Stack, O(n)):
Use a monotonic decreasing stack of indices. Iterate through the array twice
(simulating circularity) using indices `i` from 0 to 2*n-1. Let `num = nums[i % n]`.
While the stack is not empty and `nums[stack.Peek()] < num`, we have found the
next greater element for `stack.Pop()` and can set the answer. For the first
pass (i < n) push indices onto the stack to be resolved later.

Time complexity: O(n)
Space complexity: O(n)
#>

function Invoke-NextGreaterCircular {
    [CmdletBinding()]
    param(
        [int[]]$Nums = @()
    )

    if ($null -eq $Nums -or $Nums.Count -eq 0) {
        return @()
    }

    $n = $Nums.Count
    $res = for ($k = 0; $k -lt $n; $k++) { -1 }

    $stack = New-Object System.Collections.Generic.Stack[int]

    for ($i = 0; $i -lt (2 * $n); $i++) {
        $num = $Nums[$i % $n]
        while ($stack.Count -gt 0 -and $Nums[$stack.Peek()] -lt $num) {
            $idx = $stack.Pop()
            $res[$idx] = $num
        }

        if ($i -lt $n) {
            $stack.Push($i)
        }
    }

    return ,$res
}

# Quick example when dot-sourced
if ($MyInvocation.InvocationName -eq '.') {
    Write-Host "Example: [1,2,1] => " + ((Invoke-NextGreaterCircular -Nums @(1,2,1)) -join ',')
}

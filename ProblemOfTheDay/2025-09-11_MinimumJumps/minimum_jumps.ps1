<#
Minimum Jumps - GeeksforGeeks Problem of the Day (11 September 2025)

Problem summary:
Given an array of non-negative integers where each element represents the
maximum number of steps that can be jumped forward from that position,
compute the minimum number of jumps required to reach the last index from
the first index. Return -1 if the last index is not reachable.

Algorithm (Greedy, O(n) time, O(1) space):
Track the farthest index reachable so far and the current range end for
which the current number of jumps suffices. When the loop index reaches
the end of the current range, increment jumps and extend the current
range to the farthest reachable index. If at any point we cannot move
forward (farthest <= i) before reaching the last index, return -1.

Usage:
  # Dot-source the file to import the function into the current session:
  . .\minimum_jumps.ps1

  # Call the function with an integer array:
  Get-MinimumJumps -arr 1,3,5,8,9,2,6,7,6,8,9

This script defines Get-MinimumJumps and also supports being called
as a script with a comma-separated list provided to -arr.
#>

param(
    [int[]]
    $arr
)

function Get-MinimumJumps {
    param(
        [int[]]$arr
    )

    if ($null -eq $arr) {
        throw 'No array provided. Call with -arr <comma-separated-integers> or dot-source the file and call the function.'
    }

    $n = $arr.Length
    if ($n -le 1) { return 0 }

    # If the first element is 0 and array length > 1, we can't move.
    if ($arr[0] -eq 0) { return -1 }

    $farthest = 0
    $currentEnd = 0
    $jumps = 0

    for ($i = 0; $i -lt $n - 1; $i++) {
        $candidate = $i + $arr[$i]
        if ($candidate -gt $farthest) { $farthest = $candidate }

        # When we reach the end of the current range, we must make a jump
        if ($i -eq $currentEnd) {
            $jumps++
            $currentEnd = $farthest

            # If we cannot extend the range from here, array end is unreachable
            if ($currentEnd -le $i -and $i -lt $n - 1) { return -1 }

            # If we've already reached or surpassed the last index, we can stop
            if ($currentEnd -ge $n - 1) { break }
        }
    }

    return $jumps
}

# If the script is invoked directly with -arr parameter (i.e. not dot-sourced)
if ($MyInvocation.InvocationName -ne '.') {
    if ($PSBoundParameters.ContainsKey('arr')) {
        $result = Get-MinimumJumps -arr $arr
        Write-Output $result
    }
}

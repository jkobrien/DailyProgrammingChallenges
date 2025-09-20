<#
Longest Subarray Length - GeeksforGeeks POTD (20 September 2025)

Problem:
Given an integer array arr[], find the length of the longest contiguous subarray such that
all elements of the subarray are <= length of the subarray.

Approach (O(n)):
Use a sliding window (two pointers) and maintain the current window maximum using a
monotonic deque (implemented with System.Collections.Generic.LinkedList of indices).
Expand the right pointer; when the current maximum > window length, move left pointer
until the condition holds. Track the maximum valid window length seen.

Complexity:
Time: O(n) amortized
Space: O(n) for the deque in worst case
#>

function Get-LongestSubarrayLength {
    param ([int[]]$arr)
    if ($null -eq $arr -or $arr.Length -eq 0) { return 0 }
    $n = $arr.Length

    # Compute previous greater (strict) indices
    $prev = New-Object int[] $n
    for ($i=0; $i -lt $n; $i++) { $prev[$i] = -1 }
    $stack = New-Object System.Collections.Generic.List[int]
    for ($i=0; $i -lt $n; $i++) {
        while ($stack.Count -gt 0 -and $arr[$stack[$stack.Count - 1]] -le $arr[$i]) { $null = $stack.RemoveAt($stack.Count - 1) }
        if ($stack.Count -gt 0) { $prev[$i] = $stack[$stack.Count - 1] } else { $prev[$i] = -1 }
        $stack.Add($i)
    }

    # Compute next greater (strict) indices
    $next = New-Object int[] $n
    for ($i=0; $i -lt $n; $i++) { $next[$i] = $n }
    $stack.Clear()
    for ($i = $n - 1; $i -ge 0; $i--) {
        while ($stack.Count -gt 0 -and $arr[$stack[$stack.Count - 1]] -lt $arr[$i]) { $null = $stack.RemoveAt($stack.Count - 1) }
        if ($stack.Count -gt 0) { $next[$i] = $stack[$stack.Count - 1] } else { $next[$i] = $n }
        $stack.Add($i)
    }

    $best = 0
    for ($i=0; $i -lt $n; $i++) {
        $val = $arr[$i]
        if ($val -gt $n) { continue } # cannot satisfy if required length > n
        $span = $next[$i] - $prev[$i] - 1
        if ($span -ge $val -and $span -gt $best) { $best = $span }
    }
    return $best
}

# Brute-force verifier (O(n^2)) used for small test validation
function Get-LongestSubarrayLength-Brute {
    param ([int[]]$arr)
    if ($null -eq $arr -or $arr.Length -eq 0) { return 0 }
    $n = $arr.Length
    $best = 0
    for ($i = 0; $i -lt $n; $i++) {
        $maxVal = 0
        for ($j = $i; $j -lt $n; $j++) {
            if ($arr[$j] -gt $maxVal) { $maxVal = $arr[$j] }
            $len = $j - $i + 1
            if ($maxVal -le $len -and $len -gt $best) { $best = $len }
        }
    }
    return $best
}

# Test harness
function Test-LongestSubarray {
    Write-Host "Running tests for Get-LongestSubarrayLength..." -ForegroundColor Cyan

    $cases = @(
        @{arr = @(1,2,3); expected = 3},
        @{arr = @(6,4,2,5); expected = 0},
        @{arr = @(2,2,2,2); expected = 4},
        @{arr = @(3,1,3,1); expected = 4},
        @{arr = @(1); expected = 1},
        @{arr = @(); expected = 0}
    )

    $passed = 0
    foreach ($c in $cases) {
        $res = Get-LongestSubarrayLength -arr $c.arr
        $ok = ($res -eq $c.expected)
        if ($ok) { $passed++ }
        $arrStr = if ($c.arr.Length -gt 0) { $c.arr -join ',' } else { '<empty>' }
        Write-Host "Input: [$arrStr]  Expected: $($c.expected)  Got: $res  => " -NoNewline
        if ($ok) { Write-Host "PASS" -ForegroundColor Green } else { Write-Host "FAIL" -ForegroundColor Red }
    }

    # Random small tests validated against brute-force
    $rand = New-Object System.Random
    for ($t=0; $t -lt 20; $t++) {
        $len = $rand.Next(0,8) # small arrays only
        $a = for ($i=0;$i -lt $len;$i++) { $rand.Next(1,6) } # values 1..5
        $expected = Get-LongestSubarrayLength-Brute -arr $a
        $actual = Get-LongestSubarrayLength -arr $a
        $arrStr = if ($a.Length -gt 0) { $a -join ',' } else { '<empty>' }
        if ($expected -eq $actual) { $passed++ ; Write-Host "Random Test [$arrStr] => $actual (OK)" -ForegroundColor Green }
        else { Write-Host "Random Test [$arrStr] => expected $expected but got $actual" -ForegroundColor Red }
    }

    Write-Host "Tests completed. (Note: random tests also validated against brute-force)" -ForegroundColor Cyan
}

# If the script is invoked directly, run the tests
if ($MyInvocation.InvocationName -eq '.') {
    Test-LongestSubarray
} elseif ($PSCommandPath -and $PSCommandPath -eq $MyInvocation.MyCommand.Path) {
    # Script executed directly
    Test-LongestSubarray
}

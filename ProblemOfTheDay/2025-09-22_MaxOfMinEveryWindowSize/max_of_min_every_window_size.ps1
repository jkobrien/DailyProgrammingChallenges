<#
Max of min for every window size - GeeksforGeeks POTD (22 September 2025)

Problem:
Given an integer array arr[], for every window size k (1..n) compute the maximum among
all minimums of every contiguous subarray of size k.

Approach (O(n)):
For each element arr[i], determine the length of the longest window for which this element
is the minimum. To do that compute for each index i:
 - prevSmaller[i]: index of previous smaller element (strictly smaller) to the left, or -1
 - nextSmaller[i]: index of next smaller element (strictly smaller) to the right, or n
Then the span where arr[i] is the minimum is len = nextSmaller[i] - prevSmaller[i] - 1.
This means arr[i] is the minimum for some window sizes up to len. Update answer[len] = max(answer[len], arr[i]).
Finally fill empty answer slots by propagating maximums from right to left: answer[k] = max(answer[k], answer[k+1]).

Complexity:
Time: O(n)
Space: O(n)
#>

function Get-MaxOfMinEveryWindowSize {
    param (
        [int[]]$arr
    )
    if ($null -eq $arr -or $arr.Length -eq 0) { return @() }
    $n = $arr.Length

    # prev smaller (strict) indices
    $prev = New-Object int[] $n
    for ($i=0; $i -lt $n; $i++) { $prev[$i] = -1 }
    $stack = New-Object System.Collections.Generic.List[int]
    for ($i=0; $i -lt $n; $i++) {
        while ($stack.Count -gt 0 -and $arr[$stack[$stack.Count-1]] -ge $arr[$i]) { $null = $stack.RemoveAt($stack.Count -1) }
        if ($stack.Count -gt 0) { $prev[$i] = $stack[$stack.Count -1] } else { $prev[$i] = -1 }
        $stack.Add($i)
    }

    # next smaller (strict)
    $next = New-Object int[] $n
    for ($i=0; $i -lt $n; $i++) { $next[$i] = $n }
    $stack.Clear()
    for ($i = $n - 1; $i -ge 0; $i--) {
        while ($stack.Count -gt 0 -and $arr[$stack[$stack.Count-1]] -gt $arr[$i]) { $null = $stack.RemoveAt($stack.Count -1) }
        if ($stack.Count -gt 0) { $next[$i] = $stack[$stack.Count -1] } else { $next[$i] = $n }
        $stack.Add($i)
    }

    $ans = New-Object int[] ($n + 1) # 1-based index for window sizes
    for ($i=0; $i -lt $n; $i++) {
        $len = $next[$i] - $prev[$i] - 1
        if ($arr[$i] -gt $ans[$len]) { $ans[$len] = $arr[$i] }
    }

    # Fill answers for smaller window sizes by propagating from right to left
    for ($k = $n - 1; $k -ge 1; $k--) {
        if ($ans[$k] -lt $ans[$k+1]) { $ans[$k] = $ans[$k+1] }
    }

    # Return 1..n results (skip index 0)
    return ,($ans[1..$n])
}

# Brute-force verifier for small arrays
function Get-MaxOfMinEveryWindowSize-Brute {
    param ([int[]]$arr)
    if ($null -eq $arr -or $arr.Length -eq 0) { return @() }
    $n = $arr.Length
    $res = New-Object System.Collections.ArrayList
    for ($k = 1; $k -le $n; $k++) {
        $best = -1
        for ($i=0; $i -le $n - $k; $i++) {
            $window = $arr[$i..($i+$k-1)]
            $min = $window | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
            if ($min -gt $best) { $best = $min }
        }
        [void]$res.Add($best)
    }
    return ,($res.ToArray())
}

# Tests
function Test-MaxOfMin {
    Write-Host "Running tests for Get-MaxOfMinEveryWindowSize..." -ForegroundColor Cyan
    $cases = @(
        @{arr = @(10,20,30,50,10,70,30); expected = @(70,30,20,10,10,10,10)},
        @{arr = @(10,20,30); expected = @(30,20,10)},
        @{arr = @(); expected = @()}
    )

    foreach ($c in $cases) {
        $out = Get-MaxOfMinEveryWindowSize -arr $c.arr
        $ok = ($out -join ',' -eq $c.expected -join ',')
        $arrStr = if ($c.arr.Length -gt 0) { $c.arr -join ',' } else { '<empty>' }
        Write-Host "Input: [$arrStr]  Expected: [$($c.expected -join ',')]  Got: [$($out -join ',')] => " -NoNewline
        if ($ok) { Write-Host "PASS" -ForegroundColor Green } else { Write-Host "FAIL" -ForegroundColor Red }
    }

    # Random small tests vs brute-force
    $rand = New-Object System.Random
    for ($t=0; $t -lt 30; $t++) {
        $len = $rand.Next(0,8)
        $a = for ($i=0;$i -lt $len;$i++) { $rand.Next(1,6) }
        $expected = Get-MaxOfMinEveryWindowSize-Brute -arr $a
        $actual = Get-MaxOfMinEveryWindowSize -arr $a
        $arrStr = if ($a.Length -gt 0) { $a -join ',' } else { '<empty>' }
        if ($expected -join ',' -eq $actual -join ',') { Write-Host "Random Test [$arrStr] => OK" -ForegroundColor Green }
        else { Write-Host "Random Test [$arrStr] => expected [$($expected -join ',')] but got [$($actual -join ',')]" -ForegroundColor Red }
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

# If script executed directly, run tests
if ($PSCommandPath -and $PSCommandPath -eq $MyInvocation.MyCommand.Path) { Test-MaxOfMin }

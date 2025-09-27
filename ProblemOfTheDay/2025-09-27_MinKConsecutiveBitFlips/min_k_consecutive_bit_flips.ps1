<#
Minimum K Consecutive Bit Flips - GeeksforGeeks POTD (27 September 2025)

Problem:
Given a binary array arr[] and integer k, in one operation you can select a contiguous subarray of length k and flip all its bits. Find the minimum number of such operations to make the entire array all 1's. If impossible, return -1.

Approach (O(n)):
Use a greedy + sliding window approach. Track the number of flips affecting each position using a queue or a difference array. For each position, if the current bit (after flips) is 0, flip at this position (if possible). If not enough room to flip, return -1.

Complexity:
Time: O(n)
Space: O(k) (queue) or O(n) (difference array)
#>

function Get-MinKConsecutiveBitFlips {
    param (
        [int[]]$arr,
        [int]$k
    )
    if ($null -eq $arr -or $arr.Length -eq 0 -or $k -le 0) { return -1 }
    $n = $arr.Length
    $flips = 0
    $flip = 0
    $diff = New-Object int[] ($n+1)
    for ($i=0; $i -lt $n; $i++) {
        $flip += $diff[$i]
        if (($arr[$i] + $flip) % 2 -eq 0) {
            if ($i + $k -gt $n) { return -1 }
            $flips++
            $flip++
            $diff[$i + $k]--
        }
    }
    return $flips
}

# Brute-force verifier for small arrays
function Get-MinKConsecutiveBitFlips-Brute {
    param ([int[]]$arr, [int]$k)
    if ($null -eq $arr -or $arr.Length -eq 0 -or $k -le 0) { return -1 }
    $n = $arr.Length
    $A = $arr.Clone()
    $ops = 0
    for ($i=0; $i -le $n - $k; $i++) {
        if ($A[$i] -eq 0) {
            for ($j=0; $j -lt $k; $j++) { $A[$i+$j] = 1 - $A[$i+$j] }
            $ops++
        }
    }
    foreach ($v in $A) { if ($v -ne 1) { return -1 } }
    return $ops
}

# Tests
function Test-MinKConsecutiveBitFlips {
    Write-Host "Running tests for Get-MinKConsecutiveBitFlips..." -ForegroundColor Cyan
    $cases = @(
        @{arr = @(1,1,0,0,0,1,1,0,1,1,1); k=2; expected=4},
        @{arr = @(0,0,1,1,1,0,0); k=3; expected=-1},
        @{arr = @(1,1,1,1); k=2; expected=0},
        @{arr = @(0,0,0,0); k=2; expected=2},
        @{arr = @(); k=1; expected=-1}
    )
    foreach ($c in $cases) {
        $out = Get-MinKConsecutiveBitFlips -arr $c.arr -k $c.k
        $ok = ($out -eq $c.expected)
        $arrStr = if ($c.arr.Length -gt 0) { $c.arr -join ',' } else { '<empty>' }
        Write-Host "Input: [$arrStr], k=$($c.k)  Expected: $($c.expected)  Got: $out => " -NoNewline
        if ($ok) { Write-Host "PASS" -ForegroundColor Green } else { Write-Host "FAIL" -ForegroundColor Red }
    }
    # Random small tests vs brute-force
    $rand = New-Object System.Random
    for ($t=0; $t -lt 30; $t++) {
        $len = $rand.Next(0,8)
        $k = $rand.Next(1, [Math]::Max(2, $len+1))
        $a = for ($i=0;$i -lt $len;$i++) { $rand.Next(0,2) }
        $expected = Get-MinKConsecutiveBitFlips-Brute -arr $a -k $k
        $actual = Get-MinKConsecutiveBitFlips -arr $a -k $k
        $arrStr = if ($a.Length -gt 0) { $a -join ',' } else { '<empty>' }
        if ($expected -eq $actual) { Write-Host "Random Test [$arrStr], k=$k => OK" -ForegroundColor Green }
        else { Write-Host "Random Test [$arrStr], k=$k => expected $expected but got $actual" -ForegroundColor Red }
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

if ($PSCommandPath -and $PSCommandPath -eq $MyInvocation.MyCommand.Path) { Test-MinKConsecutiveBitFlips }

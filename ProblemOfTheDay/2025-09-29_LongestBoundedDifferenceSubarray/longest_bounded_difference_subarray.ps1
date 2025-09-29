<#
Longest Bounded-Difference Subarray (GeeksforGeeks POTD 2025-09-29)

Given an array of positive integers arr[] and a non-negative integer x, find the longest subarray where the absolute difference between any two elements is not greater than x. If multiple such subarrays exist, return the one that starts at the smallest index.

Approach:
- Use a sliding window with two pointers (left, right).
- Maintain the minimum and maximum in the current window using two deques (monotonic queues).
- Expand the window to the right; if the difference between max and min exceeds x, move the left pointer forward and update deques.
- Track the longest window found.
- Time: O(n), Space: O(n)
#>

function Get-LongestBoundedDifferenceSubarray {
    param(
        [int[]]$arr,
        [int]$x
    )
    $n = $arr.Length
    if ($n -eq 0) { return @() }
    $left = 0
    $maxLen = 0
    $bestL = 0
    $minDeque = New-Object System.Collections.Generic.LinkedList[int]
    $maxDeque = New-Object System.Collections.Generic.LinkedList[int]
    for ($right = 0; $right -lt $n; $right++) {
        # Maintain minDeque (increasing)
        while ($minDeque.Count -gt 0 -and $arr[$minDeque.Last.Value] -ge $arr[$right]) {
            $minDeque.RemoveLast()
        }
        $minDeque.AddLast($right)
        # Maintain maxDeque (decreasing)
        while ($maxDeque.Count -gt 0 -and $arr[$maxDeque.Last.Value] -le $arr[$right]) {
            $maxDeque.RemoveLast()
        }
        $maxDeque.AddLast($right)
        # Shrink window if needed
        while ($arr[$maxDeque.First.Value] - $arr[$minDeque.First.Value] -gt $x) {
            $left++
            if ($minDeque.First.Value -lt $left) { $minDeque.RemoveFirst() }
            if ($maxDeque.First.Value -lt $left) { $maxDeque.RemoveFirst() }
        }
        # Update best window
        if ($right - $left + 1 -gt $maxLen) {
            $maxLen = $right - $left + 1
            $bestL = $left
        }
    }
    return $arr[$bestL..($bestL + $maxLen - 1)]
}

<#
Brute-force verifier for correctness
#>
function Get-LongestBoundedDifferenceSubarray-Brute {
    param(
        [int[]]$arr,
        [int]$x
    )
    $n = $arr.Length
    $maxLen = 0
    $bestL = 0
    for ($i = 0; $i -lt $n; $i++) {
        $minV = $arr[$i]
        $maxV = $arr[$i]
        for ($j = $i; $j -lt $n; $j++) {
            if ($arr[$j] -lt $minV) { $minV = $arr[$j] }
            if ($arr[$j] -gt $maxV) { $maxV = $arr[$j] }
            if ($maxV - $minV -le $x) {
                if ($j - $i + 1 -gt $maxLen) {
                    $maxLen = $j - $i + 1
                    $bestL = $i
                }
            } else {
                break
            }
        }
    }
    if ($maxLen -eq 0) { return @() }
    return $arr[$bestL..($bestL + $maxLen - 1)]
}

<#
Test harness
#>
function Test-LongestBoundedDifferenceSubarray {
    Write-Host "Testing Longest Bounded-Difference Subarray..." -ForegroundColor Cyan
    $tests = @(
        @{ arr = @(8,4,5,6,7); x = 3; expected = @(4,5,6,7) },
        @{ arr = @(1,10,12,13,14); x = 2; expected = @(12,13,14) },
        @{ arr = @(1,2,3,4,5); x = 0; expected = @(1) },
        @{ arr = @(1,1,1,1); x = 0; expected = @(1,1,1,1) },
        @{ arr = @(5,4,3,2,1); x = 1; expected = @(5,4) },
        @{ arr = @(); x = 5; expected = @() }
    )
    foreach ($test in $tests) {
        $result = Get-LongestBoundedDifferenceSubarray $test.arr $test.x
        $brute = Get-LongestBoundedDifferenceSubarray-Brute $test.arr $test.x
        $pass = ($result -join ',' -eq $test.expected -join ',') -and ($result -join ',' -eq $brute -join ',')
        Write-Host "Input: $($test.arr) x=$($test.x) | Expected=$($test.expected) | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    # Randomized tests
    for ($t = 0; $t -lt 5; $t++) {
        $len = Get-Random -Minimum 1 -Maximum 12
        $arr = @(for ($i = 0; $i -lt $len; $i++) { Get-Random -Minimum 1 -Maximum 20 })
        $x = Get-Random -Minimum 0 -Maximum 10
        $result = Get-LongestBoundedDifferenceSubarray $arr $x
        $brute = Get-LongestBoundedDifferenceSubarray-Brute $arr $x
        $pass = ($result -join ',' -eq $brute -join ',')
        Write-Host "Random: $arr x=$x | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Test-LongestBoundedDifferenceSubarray
}

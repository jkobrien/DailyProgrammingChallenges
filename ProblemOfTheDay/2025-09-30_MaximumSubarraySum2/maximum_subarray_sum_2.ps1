<#
Maximum subarray sum 2 (GeeksforGeeks POTD 2025-09-30)

Given an array arr[] of integers and two integers a and b, find the maximum possible sum of a contiguous subarray whose length is at least a and at most b.

Approach:
- Use prefix sums for O(1) subarray sum queries.
- For each end index, maintain a window of possible start indices (using a queue) to efficiently get the minimum prefix sum for valid subarray lengths.
- For each end index, calculate the maximum sum for subarrays ending at that index with length in [a, b].
- Time: O(n), Space: O(n)
#>

function Get-MaximumSubarraySum2 {
    param(
        [int[]]$arr,
        [int]$a,
        [int]$b
    )
    $n = $arr.Length
    if ($n -eq 0 -or $a -gt $n) { return 0 }
    $prefix = @(0)
    for ($i = 0; $i -lt $n; $i++) { $prefix += ($prefix[-1] + $arr[$i]) }
    $maxSum = [int]::MinValue
    $queue = New-Object System.Collections.Generic.Queue[int]
    for ($i = $a; $i -le $n; $i++) {
        # Maintain a window of prefix sums for subarrays of length in [a, b]
        if ($i - $b - 1 -ge 0) {
            if ($queue.Count -gt 0 -and $queue.Peek() -eq $prefix[$i - $b - 1]) {
                $queue.Dequeue() # Remove out-of-window
            }
        }
        # Add new prefix sum for subarray of length a
        $queue.Enqueue($prefix[$i - $a])
        # Find min prefix sum in the window
        $minPrefix = [int]::MaxValue
        foreach ($val in $queue) { if ($val -lt $minPrefix) { $minPrefix = $val } }
        $sum = $prefix[$i] - $minPrefix
        if ($sum -gt $maxSum) { $maxSum = $sum }
    }
    return $maxSum
}

<#
Brute-force verifier for correctness
#>
function Get-MaximumSubarraySum2-Brute {
    param(
        [int[]]$arr,
        [int]$a,
        [int]$b
    )
    $n = $arr.Length
    $maxSum = [int]::MinValue
    for ($i = 0; $i -lt $n; $i++) {
        for ($j = $i; $j -lt $n; $j++) {
            $len = $j - $i + 1
            if ($len -ge $a -and $len -le $b) {
                $sum = 0
                for ($k = $i; $k -le $j; $k++) { $sum += $arr[$k] }
                if ($sum -gt $maxSum) { $maxSum = $sum }
            }
        }
    }
    return $maxSum
}

<#
Test harness
#>
function Test-MaximumSubarraySum2 {
    Write-Host "Testing Maximum Subarray Sum 2..." -ForegroundColor Cyan
    $tests = @(
        @{ arr = @(4,5,-1,-2,6); a = 2; b = 4; expected = 9 },
        @{ arr = @(-1,3,-1,-2,5,3,-5,2,2); a = 3; b = 5; expected = 8 },
        @{ arr = @(1,2,3,4,5); a = 1; b = 5; expected = 15 },
        @{ arr = @(-5,-2,-3,-4); a = 2; b = 3; expected = -5 },
        @{ arr = @(); a = 1; b = 1; expected = 0 }
    )
    foreach ($test in $tests) {
        $result = Get-MaximumSubarraySum2 $test.arr $test.a $test.b
        $brute = Get-MaximumSubarraySum2-Brute $test.arr $test.a $test.b
        $pass = ($result -eq $test.expected) -and ($result -eq $brute)
        Write-Host "Input: $($test.arr) a=$($test.a) b=$($test.b) | Expected=$($test.expected) | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    # Randomized tests
    for ($t = 0; $t -lt 5; $t++) {
        $len = Get-Random -Minimum 3 -Maximum 10
        $arr = @(for ($i = 0; $i -lt $len; $i++) { Get-Random -Minimum -10 -Maximum 10 })
        $a = Get-Random -Minimum 1 -Maximum [Math]::Min(5, $len)
        $b = Get-Random -Minimum $a -Maximum $len
        $result = Get-MaximumSubarraySum2 $arr $a $b
        $brute = Get-MaximumSubarraySum2-Brute $arr $a $b
        $pass = ($result -eq $brute)
        Write-Host "Random: $arr a=$a b=$b | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Test-MaximumSubarraySum2
}

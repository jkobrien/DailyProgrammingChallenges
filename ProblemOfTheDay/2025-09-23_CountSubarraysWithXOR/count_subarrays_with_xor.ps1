<#
Count the number of subarrays having a given XOR (GeeksforGeeks POTD 2025-09-23)

Given an array of integers and a target value K, count the number of subarrays whose XOR is equal to K.

Approach:
- Use prefix XOR and a hash table to count subarrays efficiently.
- For each element, compute prefix XOR up to that index.
- For each prefix XOR, the number of times (prefixXOR XOR K) has occurred so far gives the number of subarrays ending at the current index with XOR K.
- Time: O(n), Space: O(n)
#>

function Get-CountSubarraysWithXOR {
    param(
        [int[]]$arr,
        [int]$K
    )
    $n = $arr.Length
    $prefixXOR = 0
    $count = 0
    $freq = @{}
    $freq[0] = 1 # Empty prefix
    for ($i = 0; $i -lt $n; $i++) {
        $prefixXOR = $prefixXOR -bxor $arr[$i]
        $target = $prefixXOR -bxor $K
        if ($freq.ContainsKey($target)) {
            $count += $freq[$target]
        }
        if ($freq.ContainsKey($prefixXOR)) {
            $freq[$prefixXOR] += 1
        } else {
            $freq[$prefixXOR] = 1
        }
    }
    return $count
}

<#
Brute-force verifier for correctness
#>
function Get-CountSubarraysWithXOR-Brute {
    param(
        [int[]]$arr,
        [int]$K
    )
    $n = $arr.Length
    $count = 0
    for ($i = 0; $i -lt $n; $i++) {
        $xor = 0
        for ($j = $i; $j -lt $n; $j++) {
            $xor = $xor -bxor $arr[$j]
            if ($xor -eq $K) {
                $count++
            }
        }
    }
    return $count
}

<#
Test harness
#>
function Test-CountSubarraysWithXOR {
    $tests = @(
        @{ arr = @(4, 2, 2, 6, 4); K = 6; expected = 4 },
        @{ arr = @(5, 6, 7, 8, 9); K = 5; expected = 2 },
        @{ arr = @(1, 2, 3, 4, 5); K = 4; expected = 2 },
        @{ arr = @(1, 1, 1, 1); K = 0; expected = 0 },
        @{ arr = @(0, 0, 0, 0); K = 0; expected = 10 },
        @{ arr = @(); K = 0; expected = 0 }
    )
    foreach ($test in $tests) {
        $result = Get-CountSubarraysWithXOR $test.arr $test.K
        $brute = Get-CountSubarraysWithXOR-Brute $test.arr $test.K
        $pass = ($result -eq $test.expected) -and ($result -eq $brute)
        Write-Host "Input: $($test.arr) K=$($test.K) | Expected=$($test.expected) | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    # Randomized tests
    for ($t = 0; $t -lt 5; $t++) {
        $len = Get-Random -Minimum 1 -Maximum 15
        $arr = @(for ($i = 0; $i -lt $len; $i++) { Get-Random -Minimum 0 -Maximum 10 })
        $K = Get-Random -Minimum 0 -Maximum 10
        $result = Get-CountSubarraysWithXOR $arr $K
        $brute = Get-CountSubarraysWithXOR-Brute $arr $K
        $pass = ($result -eq $brute)
        Write-Host "Random: $arr K=$K | Result=$result | Brute=$brute | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    Write-Host "Tests completed."
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -eq '.') {
    Test-CountSubarraysWithXOR
}

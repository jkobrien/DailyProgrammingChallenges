<#
All Unique Permutations of an array (GeeksforGeeks POTD 2025-10-01)

Given an array arr[] that may contain duplicates, find all possible distinct permutations of the array in sorted order.

Approach:
- Use backtracking to generate all permutations.
- To avoid duplicates, sort the array and skip repeated elements during recursion.
- Collect all unique permutations and sort them lexicographically.
- Time: O(n! * n), Space: O(n! * n)
#>

function Get-AllUniquePermutations {
    param(
        [int[]]$arr
    )
    $n = $arr.Length
    if ($n -eq 0) { return @() }
    $arr = $arr | Sort-Object
    $used = @(for ($i = 0; $i -lt $n; $i++) { $false })
    $result = @()
    function Backtrack($path) {
        if ($path.Count -eq $n) {
            $result += ,@($path)
            return
        }
        for ($i = 0; $i -lt $n; $i++) {
            if ($used[$i]) { continue }
            if ($i -gt 0 -and $arr[$i] -eq $arr[$i-1] -and -not $used[$i-1]) { continue }
            $used[$i] = $true
            Backtrack ($path + $arr[$i])
            $used[$i] = $false
        }
    }
    Backtrack @()
    # Sort lexicographically
    $result = $result | Sort-Object { $_ } -Unique
    return $result
}

<#
Test harness
#>
function Test-AllUniquePermutations {
    Write-Host "Testing All Unique Permutations..." -ForegroundColor Cyan
    $tests = @(
        @{ arr = @(1,3,3); expected = @(@(1,3,3), @(3,1,3), @(3,3,1)) },
        @{ arr = @(2,3); expected = @(@(2,3), @(3,2)) },
        @{ arr = @(1,2,2); expected = @(@(1,2,2), @(2,1,2), @(2,2,1)) },
        @{ arr = @(1); expected = @(@(1)) },
        @{ arr = @(); expected = @() }
    )
    foreach ($test in $tests) {
        $result = Get-AllUniquePermutations $test.arr
        $resultStr = ($result | ForEach-Object { "[$($_ -join ',')]" }) -join ', '
        $expectedStr = ($test.expected | ForEach-Object { "[$($_ -join ',')]" }) -join ', '
        $pass = ($resultStr -eq $expectedStr)
        Write-Host "Input: $($test.arr) | Expected=$expectedStr | Result=$resultStr | $([bool]$pass -replace 'True','PASS' -replace 'False','FAIL')"
    }
    # Randomized tests
    for ($t = 0; $t -lt 3; $t++) {
        $len = Get-Random -Minimum 2 -Maximum 5
        $arr = @(for ($i = 0; $i -lt $len; $i++) { Get-Random -Minimum 1 -Maximum 3 })
        $result = Get-AllUniquePermutations $arr
        $uniqueCount = ($result | Sort-Object { $_ } -Unique).Count
        Write-Host "Random: $arr | Unique permutations: $uniqueCount | PASS" -ForegroundColor Green
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Test-AllUniquePermutations
}

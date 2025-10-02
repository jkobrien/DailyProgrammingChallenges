<#
Unique K-Number Sum - GeeksforGeeks POTD (2 October 2025)

Problem:
Given two integers n and k, find all valid combinations of k distinct numbers from 1 to 9 that sum to n.
Each number can be used at most once.

Approach:
Use backtracking to generate all k-length combinations from [1..9] whose sum is n.

Complexity:
Time: O(C(9, k))
Space: O(k) per combination
#>

function Get-UniqueKNumberSum {
    param (
        [int]$n,
        [int]$k
    )
    $results = New-Object System.Collections.ArrayList
    
    function Backtrack([int]$start, [int[]]$path, [int]$remaining) {
        if ($path.Count -eq $k) {
            if ($remaining -eq 0) { 
                [void]$results.Add(@($path))
            }
            return
        }
        
        for ($i = $start; $i -le 9; $i++) {
            if ($remaining -lt $i) { break }
            $newPath = $path + $i
            Backtrack ($i + 1) $newPath ($remaining - $i)
        }
    }
    
    Backtrack 1 @() $n
    return $results.ToArray()
}

# Tests
function Test-UniqueKNumberSum {
    Write-Host "Running tests for Get-UniqueKNumberSum..." -ForegroundColor Cyan
    $cases = @(
        @{n=9; k=3; expected=@(@(1,2,6),@(1,3,5),@(2,3,4))},
        @{n=3; k=3; expected=@()},
        @{n=7; k=2; expected=@(@(1,6),@(2,5),@(3,4))},
        @{n=15; k=5; expected=@(@(1,2,3,4,5))},
        @{n=50; k=9; expected=@()} # impossible
    )
    foreach ($c in $cases) {
        $out = Get-UniqueKNumberSum -n $c.n -k $c.k
        $outSorted = $out | Sort-Object { $_ -join ',' }
        $expectedSorted = $c.expected | Sort-Object { $_ -join ',' }
        $ok = ($outSorted.Count -eq $expectedSorted.Count -and ($outSorted -join ';' -eq $expectedSorted -join ';'))
        $expectedStr = ($expectedSorted | ForEach-Object { '[' + ($_ -join ',') + ']' }) -join ', '
        $outStr = ($outSorted | ForEach-Object { '[' + ($_ -join ',') + ']' }) -join ', '
        Write-Host "Input: n=$($c.n), k=$($c.k)  Expected: [$expectedStr]  Got: [$outStr] => " -NoNewline
        if ($ok) { Write-Host "PASS" -ForegroundColor Green } else { Write-Host "FAIL" -ForegroundColor Red }
    }
    Write-Host "Tests completed." -ForegroundColor Cyan
}

if ($PSCommandPath -and $PSCommandPath -eq $MyInvocation.MyCommand.Path) { Test-UniqueKNumberSum }

# PowerShell Solution for "Make Strings Equal"
<#
Given two strings s and t, and a set of allowed character transformations with costs,
find the minimum total cost to make the strings identical. If impossible, return -1.

Approach:
1. Build a 26x26 cost matrix for all character transformations ('a'-'z').
2. Use Floyd-Warshall to compute minimum cost between all pairs.
3. For each position, find the cheapest way to make s[i] and t[i] equal (possibly via a third character).
4. Sum costs; if any position is impossible, return -1.
#>

function Make-Strings-Equal {
    param(
        [string]$s,
        [string]$t,
        [string[][]]$transform,
        [int[]]$cost
    )

    $INF = 1e9
    $n = $s.Length

    # Build cost matrix
    $alphabet = @()
    for ($i = [int][char]'a'; $i -le [int][char]'z'; $i++) {
        $alphabet += [char]$i
    }
    $dist = @{}
    foreach ($c1 in $alphabet) {
        $dist[$c1] = @{}
        foreach ($c2 in $alphabet) {
            if ($c1 -eq $c2) {
                $dist[$c1][$c2] = 0
            } else {
                $dist[$c1][$c2] = $INF
            }
        }
    }
    for ($i = 0; $i -lt $transform.Length; $i++) {
        $from = $transform[$i][0].ToLower()
        $to = $transform[$i][1].ToLower()
        if ($alphabet -contains $from -and $alphabet -contains $to -and $dist.ContainsKey($from) -and $dist[$from].ContainsKey($to)) {
            $dist[$from][$to] = [Math]::Min($dist[$from][$to], $cost[$i])
        }
    }

    # Floyd-Warshall
    foreach ($k in $alphabet) {
        foreach ($i in $alphabet) {
            foreach ($j in $alphabet) {
                if ($dist[$i][$k] + $dist[$k][$j] -lt $dist[$i][$j]) {
                    $dist[$i][$j] = $dist[$i][$k] + $dist[$k][$j]
                }
            }
        }
    }

    $total = 0
    for ($i = 0; $i -lt $n; $i++) {
        $c1 = $s[$i]
        $c2 = $t[$i]
        if ($c1 -eq $c2) { continue }

        $minCost = $INF
        foreach ($target in $alphabet) {
            $cost1 = $dist[$c1][$target]
            $cost2 = $dist[$c2][$target]
            if ($cost1 -lt $INF -and $cost2 -lt $INF) {
                $minCost = [Math]::Min($minCost, $cost1 + $cost2)
            }
        }
        if ($minCost -eq $INF) { return -1 }
        $total += $minCost
    }
    return $total
}

# Example usage and tests
$s1 = "abcc"; $t1 = "bccc"
$transform1 = @( @('a','b'), @('b','c'), @('c','a') )
$cost1 = @(2, 1, 4)
Write-Host "Test 1: $(Make-Strings-Equal $s1 $t1 $transform1 $cost1) (Expected: 3)"

$s2 = "az"; $t2 = "dc"
$transform2 = @( @('a','b'), @('b','c'), @('c','d'), @('a','d'), @('z','c') )
$cost2 = @(5, 3, 2, 50, 10)
Write-Host "Test 2: $(Make-Strings-Equal $s2 $t2 $transform2 $cost2) (Expected: 20)"

$s3 = "xyz"; $t3 = "xzy"
$transform3 = @( @('x','y'), @('x','z') )
$cost3 = @(3, 3)
Write-Host "Test 3: $(Make-Strings-Equal $s3 $t3 $transform3 $cost3) (Expected: -1)"

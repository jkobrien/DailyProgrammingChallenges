<#
Ways To Tile A Floor (GeeksforGeeks POTD 2025-11-07)
Given a 2 x n floor and 2 x 1 tiles, find the number of ways to tile the floor.
DP Recurrence: ways(n) = ways(n-1) + ways(n-2)
#>

function Get-WaysToTileFloor {
    param(
        [Parameter(Mandatory=$true)]
        [int]$n
    )
    if ($n -le 0) { return 0 }
    if ($n -eq 1) { return 1 }
    if ($n -eq 2) { return 2 }
    $a = 1
    $b = 2
    for ($i = 3; $i -le $n; $i++) {
        $c = $a + $b
        $a = $b
        $b = $c
    }
    return $b
}

# If run directly, parse argument and print result
if ($MyInvocation.InvocationName -eq '.') { return } # Prevent auto-run on dot-source
if ($MyInvocation.PSScriptRoot) {
    param([int]$n)
    if ($n) {
        Write-Output (Get-WaysToTileFloor -n $n)
    }
}

<#
assign_mice_holes.ps1
PowerShell solution for "Assign Mice Holes" (GeeksforGeeks POTD)

Problem summary:
Given two equal-length arrays `mices` and `holes` representing integer positions on a line,
assign each mouse to a distinct hole so that the time taken by the slowest mouse to reach
its assigned hole (time = |mouse_pos - hole_pos|) is minimized. Each hole can take exactly
one mouse.

Approach (greedy / optimal):
Sort both arrays and pair elements at the same indices. The maximum absolute difference over
all pairs is the minimized maximum time. This runs in O(n log n) time due to sorting.

Usage examples (from GfG samples):
PS> .\assign_mice_holes.ps1 -Mice 4,-4,2 -Holes 4,0,5
4

PS> .\assign_mice_holes.ps1 -Mice 1,2 -Holes 20,10
18

Parameters:
- Mice: comma-separated integers (no spaces or with spaces) or an array of ints.
- Holes: comma-separated integers (no spaces or with spaces) or an array of ints.

Exit codes:
0 - success
1 - input error (unequal sizes or parse error)

#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [String]$Mice,
    [Parameter(Mandatory=$true, Position=1)]
    [String]$Holes
)

function Parse-IntArray {
    param(
        [Parameter(Mandatory=$true)]
        [string]$s
    )
    # Acceptable formats: "1,2,3" or "[1, 2, 3]" or space-separated
    $trimmed = $s.Trim()
    if ($trimmed.StartsWith('[') -and $trimmed.EndsWith(']')) {
        $trimmed = $trimmed.TrimStart('[').TrimEnd(']')
    }
    if ($trimmed -eq '') { return @() }
    # Split on comma or whitespace
    $parts = -split $trimmed -Pattern '[,\s]+' | Where-Object { $_ -ne '' }
    try {
        return $parts | ForEach-Object { [int]$_ }
    } catch {
        Throw "Unable to parse integer array from input: '$s'"
    }
}

function Get-MinMaxTime {
    param(
        [int[]]$mices,
        [int[]]$holes
    )
    if ($mices.Length -ne $holes.Length) {
        Throw "The number of mice and holes must be equal."
    }
    if ($mices.Length -eq 0) { return 0 }

    $sortedMices = $mices | Sort-Object
    $sortedHoles = $holes | Sort-Object

    $maxTime = 0
    for ($i = 0; $i -lt $sortedMices.Length; $i++) {
        $t = [math]::Abs($sortedMices[$i] - $sortedHoles[$i])
        if ($t -gt $maxTime) { $maxTime = $t }
    }
    return $maxTime
}

try {
    $mArr = Parse-IntArray -s $Mice
    $hArr = Parse-IntArray -s $Holes
} catch {
    Write-Error $_
    exit 1
}

try {
    $result = Get-MinMaxTime -mices $mArr -holes $hArr
    Write-Output $result
    exit 0
} catch {
    Write-Error $_
    exit 1
}

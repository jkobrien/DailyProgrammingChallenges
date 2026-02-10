<#
.SYNOPSIS
    Koko Eating Bananas — find the minimum eating speed.

.DESCRIPTION
    Given an array of pile sizes and k hours, returns the minimum speed s
    such that Koko can eat all bananas within k hours.

    Uses binary search on the answer space [1, max(arr)].

.PARAMETER Piles
    An array of integers representing banana pile sizes.

.PARAMETER Hours
    The maximum number of hours Koko has to eat all bananas.

.OUTPUTS
    [int] The minimum eating speed s.

.EXAMPLE
    Get-MinEatingSpeed -Piles @(5,10,3) -Hours 4   # returns 5
#>
function Get-MinEatingSpeed {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [int[]]$Piles,

        [Parameter(Mandatory)]
        [int]$Hours
    )

    # Helper: compute total hours needed at a given speed
    function Get-HoursNeeded([int[]]$piles, [int]$speed) {
        [long]$total = 0
        foreach ($p in $piles) {
            # Ceiling division: (p + speed - 1) / speed
            $total += [Math]::Ceiling($p / $speed)
        }
        return $total
    }

    # Binary search on speed s in [1 .. max(piles)]
    [int]$lo = 1
    [int]$hi = ($Piles | Measure-Object -Maximum).Maximum

    while ($lo -lt $hi) {
        $mid = [Math]::Floor(($lo + $hi) / 2)

        if ((Get-HoursNeeded $Piles $mid) -le $Hours) {
            $hi = $mid        # mid is fast enough — try slower
        }
        else {
            $lo = $mid + 1    # mid is too slow — go faster
        }
    }

    return $lo
}

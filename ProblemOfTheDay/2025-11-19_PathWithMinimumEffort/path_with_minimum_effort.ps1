# PowerShell Solution: Path With Minimum Effort

function Path-WithMinimumEffort {
    param (
        [int[][]]$mat
    )
    $n = $mat.Count
    $m = $mat[0].Count

    function IsPathPossible($maxDiff) {
        $visited = @{}
        $queue = New-Object System.Collections.Queue
        $queue.Enqueue(@(0, 0))
        $visited["0,0"] = $true

        $dirs = @( @(0,1), @(1,0), @(0,-1), @(-1,0) )

        while ($queue.Count -gt 0) {
            $curr = $queue.Dequeue()
            $x = $curr[0]
            $y = $curr[1]
            if ($x -eq $n-1 -and $y -eq $m-1) {
                return $true
            }
            foreach ($d in $dirs) {
                $nx = $x + $d[0]
                $ny = $y + $d[1]
                if ($nx -ge 0 -and $nx -lt $n -and $ny -ge 0 -and $ny -lt $m) {
                    $diff = [Math]::Abs($mat[$x][$y] - $mat[$nx][$ny])
                    if ($diff -le $maxDiff -and -not $visited["$nx,$ny"]) {
                        $visited["$nx,$ny"] = $true
                        $queue.Enqueue(@($nx, $ny))
                    }
                }
            }
        }
        return $false
    }

    $low = 0
    $high = 1000000
    $answer = $high
    while ($low -le $high) {
        $mid = [math]::Floor(($low + $high) / 2)
        if (IsPathPossible $mid) {
            $answer = $mid
            $high = $mid - 1
        } else {
            $low = $mid + 1
        }
    }
    return $answer
}

# Example usage:
# $mat = @( @(7,2,6,5), @(3,1,10,8) )
# Path-WithMinimumEffort $mat

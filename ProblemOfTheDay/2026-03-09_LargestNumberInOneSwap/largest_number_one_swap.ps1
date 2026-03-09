<#
.SYNOPSIS
    Largest Number in One Swap - GeeksforGeeks Problem of the Day (2026-03-09)

.DESCRIPTION
    Given a string s (representing a number), return the lexicographically largest 
    string that can be obtained by swapping at most one pair of characters in s.

.PARAMETER s
    A string containing digits '0' to '9'

.EXAMPLE
    Get-LargestNumberInOneSwap -s "768"
    Returns: "867"

.EXAMPLE
    Get-LargestNumberInOneSwap -s "333"
    Returns: "333"

.NOTES
    Algorithm:
    1. Traverse from left to right
    2. For each position, find the maximum digit to its right
    3. If a larger digit exists, swap with its rightmost occurrence
    4. Return after first beneficial swap (or original if no swap helps)
    
    Time Complexity: O(n)
    Space Complexity: O(n)
#>

function Get-LargestNumberInOneSwap {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$s
    )

    # Handle edge cases
    if ($s.Length -le 1) {
        return $s
    }

    # Convert string to char array for easy manipulation
    $chars = $s.ToCharArray()
    $n = $chars.Length

    # For each position, store the index of the maximum digit to its right
    # We'll precompute the rightmost maximum from each position
    
    # Array to store the index of the rightmost maximum digit from position i to end
    $rightMaxIndex = New-Object int[] $n
    
    # Initialize: the last position's rightmost max is itself
    $rightMaxIndex[$n - 1] = $n - 1
    
    # Fill from right to left
    for ($i = $n - 2; $i -ge 0; $i--) {
        # If current digit is greater than the digit at rightMaxIndex[i+1],
        # then current position becomes the new rightmost max
        # Note: We use >= to get the RIGHTMOST occurrence of the maximum
        if ($chars[$i] -gt $chars[$rightMaxIndex[$i + 1]]) {
            $rightMaxIndex[$i] = $i
        }
        else {
            $rightMaxIndex[$i] = $rightMaxIndex[$i + 1]
        }
    }

    # Now traverse from left to find the first position where we can swap
    for ($i = 0; $i -lt $n; $i++) {
        # Get the index of the rightmost maximum digit after position i
        $maxIdx = $rightMaxIndex[$i]
        
        # If there's a larger digit to the right, swap and return
        if ($chars[$maxIdx] -gt $chars[$i]) {
            # Swap
            $temp = $chars[$i]
            $chars[$i] = $chars[$maxIdx]
            $chars[$maxIdx] = $temp
            
            # Return the result
            return -join $chars
        }
    }

    # No beneficial swap found, return original string
    return $s
}

# Alternative implementation using a simpler O(n^2) approach
# (Useful for understanding the logic)
function Get-LargestNumberInOneSwapSimple {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$s
    )

    # Handle edge cases
    if ($s.Length -le 1) {
        return $s
    }

    $chars = $s.ToCharArray()
    $n = $chars.Length

    # For each position from left to right
    for ($i = 0; $i -lt $n; $i++) {
        $maxDigit = $chars[$i]
        $maxIdx = -1

        # Find the rightmost digit that is greater than current
        for ($j = $i + 1; $j -lt $n; $j++) {
            if ($chars[$j] -ge $maxDigit) {
                # Only update if strictly greater, or same (to get rightmost)
                if ($chars[$j] -gt $chars[$i]) {
                    if ($chars[$j] -ge $maxDigit) {
                        $maxDigit = $chars[$j]
                        $maxIdx = $j
                    }
                }
            }
        }

        # If we found a larger digit, swap and return
        if ($maxIdx -ne -1) {
            $temp = $chars[$i]
            $chars[$i] = $chars[$maxIdx]
            $chars[$maxIdx] = $temp
            return -join $chars
        }
    }

    return $s
}

# If running directly (not imported as module), demonstrate the solution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "Largest Number in One Swap - GfG POTD 2026-03-09" -ForegroundColor Cyan
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host ""

    # Test cases
    $testCases = @(
        @{ Input = "768"; Expected = "867" },
        @{ Input = "333"; Expected = "333" },
        @{ Input = "1993"; Expected = "9913" },
        @{ Input = "12345"; Expected = "52341" },
        @{ Input = "98765"; Expected = "98765" },
        @{ Input = "9"; Expected = "9" },
        @{ Input = "19"; Expected = "91" },
        @{ Input = "91"; Expected = "91" },
        @{ Input = "1234567890"; Expected = "9234567810" }
    )

    $passCount = 0
    $failCount = 0

    foreach ($test in $testCases) {
        $result = Get-LargestNumberInOneSwap -s $test.Input
        $status = if ($result -eq $test.Expected) { 
            $passCount++
            "[PASS]" 
        } else { 
            $failCount++
            "[FAIL]" 
        }
        
        $color = if ($result -eq $test.Expected) { "Green" } else { "Red" }
        
        Write-Host "$status Input: `"$($test.Input)`" => Output: `"$result`" (Expected: `"$($test.Expected)`")" -ForegroundColor $color
    }

    Write-Host ""
    Write-Host "=" * 60 -ForegroundColor Cyan
    Write-Host "Results: $passCount passed, $failCount failed" -ForegroundColor $(if ($failCount -eq 0) { "Green" } else { "Yellow" })
    Write-Host "=" * 60 -ForegroundColor Cyan
}
<#
.SYNOPSIS
    AND In Range - GeeksforGeeks Problem of the Day (November 26, 2025)

.DESCRIPTION
    Finds the result of applying bitwise AND operation on all numbers in range [l, r].
    
    The solution uses an efficient bit manipulation approach:
    - Find the common prefix of l and r in binary representation
    - Right shift both numbers until they become equal
    - Left shift back to get the result
    
    Time Complexity: O(log l)
    Space Complexity: O(1)

.PARAMETER l
    The left boundary of the range (inclusive)

.PARAMETER r
    The right boundary of the range (inclusive)

.EXAMPLE
    Get-ANDInRange -l 8 -r 13
    Returns: 8

.EXAMPLE
    Get-ANDInRange -l 2 -r 3
    Returns: 2

.NOTES
    Author: Daily Programming Challenges
    Date: November 26, 2025
#>

function Get-ANDInRange {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [long]$l,
        
        [Parameter(Mandatory = $true, Position = 1)]
        [long]$r
    )
    
    # Validate input ranges
    if ($l -lt 1 -or $l -gt 1000000000) {
        throw "l must be between 1 and 1000000000"
    }
    if ($r -lt 1 -or $r -gt 1000000000) {
        throw "r must be between 1 and 1000000000"
    }
    if ($l -gt $r) {
        throw "Invalid range: l must be less than or equal to r"
    }
    
    # If l equals r, return l
    if ($l -eq $r) {
        return $l
    }
    
    # Use temporary variables to avoid validation issues
    [long]$tempL = $l
    [long]$tempR = $r
    [int]$shift = 0
    
    # Keep shifting right until both numbers become equal
    # This finds the common prefix in binary representation
    while ($tempL -ne $tempR) {
        $tempL = $tempL -shr 1  # Right shift l by 1
        $tempR = $tempR -shr 1  # Right shift r by 1
        $shift++
    }
    
    # Shift back left to get the final result
    # This gives us the common prefix with zeros in differing positions
    return $tempL -shl $shift
}

# Alternative implementation using bitwise operations directly
function Get-ANDInRangeAlternative {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [long]$l,
        
        [Parameter(Mandatory = $true)]
        [long]$r
    )
    
    if ($l -gt $r) {
        throw "Invalid range: l must be less than or equal to r"
    }
    
    # Find the position of the most significant differing bit
    [long]$xor = $l -bxor $r
    
    # If no difference, return l
    if ($xor -eq 0) {
        return $l
    }
    
    # Find the most significant bit position in xor
    [int]$msbPos = 0
    [long]$temp = $xor
    while ($temp -gt 0) {
        $temp = $temp -shr 1
        $msbPos++
    }
    
    # Create mask to clear all bits from MSB position onwards
    [long]$mask = [long]::MaxValue -shl $msbPos
    
    return $l -band $mask
}

# Helper function to display binary representation
function Show-BinaryRepresentation {
    param (
        [long]$number,
        [int]$bits = 16
    )
    
    $binary = [Convert]::ToString($number, 2).PadLeft($bits, '0')
    return "$number = $binary"
}

# Main execution block for standalone script execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "`n=== AND In Range Solver ===" -ForegroundColor Cyan
    Write-Host "GeeksforGeeks Problem of the Day - November 26, 2025`n" -ForegroundColor Gray
    
    # Example 1
    Write-Host "Example 1:" -ForegroundColor Yellow
    $l1 = 8
    $r1 = 13
    $result1 = Get-ANDInRange -l $l1 -r $r1
    Write-Host "Input: l = $l1, r = $r1"
    Write-Host "Output: $result1"
    Write-Host "Binary visualization:" -ForegroundColor Gray
    for ($i = $l1; $i -le $r1; $i++) {
        Write-Host "  $(Show-BinaryRepresentation $i)" -ForegroundColor DarkGray
    }
    Write-Host "  Result: $(Show-BinaryRepresentation $result1)" -ForegroundColor Green
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2:" -ForegroundColor Yellow
    $l2 = 2
    $r2 = 3
    $result2 = Get-ANDInRange -l $l2 -r $r2
    Write-Host "Input: l = $l2, r = $r2"
    Write-Host "Output: $result2"
    Write-Host "Binary visualization:" -ForegroundColor Gray
    for ($i = $l2; $i -le $r2; $i++) {
        Write-Host "  $(Show-BinaryRepresentation $i)" -ForegroundColor DarkGray
    }
    Write-Host "  Result: $(Show-BinaryRepresentation $result2)" -ForegroundColor Green
    Write-Host ""
    
    # Additional test cases
    Write-Host "Additional Test Cases:" -ForegroundColor Yellow
    
    $testCases = @(
        @{l = 1; r = 1},
        @{l = 5; r = 7},
        @{l = 10; r = 15},
        @{l = 100; r = 200},
        @{l = 1000000; r = 1000010}
    )
    
    foreach ($test in $testCases) {
        $result = Get-ANDInRange -l $test.l -r $test.r
        Write-Host "  Range [$($test.l), $($test.r)] => $result" -ForegroundColor White
    }
    
    Write-Host "`nDone!" -ForegroundColor Green
}

# Export functions for module usage (only works when loaded as a module)
if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript' -and (Get-Module -Name ($MyInvocation.MyCommand.Name -replace '\.ps1$', '') -ErrorAction SilentlyContinue)) {
    Export-ModuleMember -Function Get-ANDInRange, Get-ANDInRangeAlternative, Show-BinaryRepresentation
}

<#
.SYNOPSIS
    Meeting Rooms - Determine if a person can attend all meetings

.DESCRIPTION
    Given a 2D array of meeting times [start, end], determines if it's possible
    for a person to attend all meetings without conflicts.
    
.PARAMETER meetings
    2D array where each element is @(start_time, end_time)

.EXAMPLE
    Can-Attend-All-Meetings -meetings @(@(1,4), @(10,15), @(7,10))
    Returns: $true

.EXAMPLE
    Can-Attend-All-Meetings -meetings @(@(2,4), @(9,12), @(6,10))
    Returns: $false

.NOTES
    Time Complexity: O(n log n) - due to sorting
    Space Complexity: O(1) - constant extra space
    
    Algorithm:
    1. Sort meetings by start time
    2. Check consecutive meetings for overlaps
    3. If end_time[i] > start_time[i+1], there's a conflict
    
    Key Insight: After sorting by start time, we only need to check
    if consecutive meetings overlap. If they don't, we can attend all.
#>

function Can-Attend-All-Meetings {
    param (
        [Parameter(Mandatory=$true)]
        [array]$meetings
    )
    
    # Edge case: 0 or 1 meeting
    if ($meetings.Count -le 1) {
        return $true
    }
    
    # Sort meetings by start time
    # PowerShell's Sort-Object with a script block
    $sortedMeetings = $meetings | Sort-Object { $_[0] }
    
    # Check for overlaps in consecutive meetings
    for ($i = 0; $i -lt $sortedMeetings.Count - 1; $i++) {
        $currentEnd = $sortedMeetings[$i][1]
        $nextStart = $sortedMeetings[$i + 1][0]
        
        # If current meeting ends after next meeting starts, there's an overlap
        if ($currentEnd -gt $nextStart) {
            return $false
        }
    }
    
    # No overlaps found
    return $true
}

<#
.SYNOPSIS
    Alternative implementation with detailed step-by-step output

.DESCRIPTION
    Same algorithm but with verbose output for understanding the process
#>
function Can-Attend-All-Meetings-Verbose {
    param (
        [Parameter(Mandatory=$true)]
        [array]$meetings,
        
        [Parameter(Mandatory=$false)]
        [switch]$ShowSteps
    )
    
    if ($meetings.Count -le 1) {
        if ($ShowSteps) {
            Write-Host "Only $($meetings.Count) meeting(s). Can attend all." -ForegroundColor Green
        }
        return $true
    }
    
    # Sort meetings by start time
    $sortedMeetings = $meetings | Sort-Object { $_[0] }
    
    if ($ShowSteps) {
        Write-Host "`nOriginal meetings:" -ForegroundColor Cyan
        $meetings | ForEach-Object { Write-Host "  [$($_[0]), $($_[1])]" }
        
        Write-Host "`nSorted by start time:" -ForegroundColor Cyan
        $sortedMeetings | ForEach-Object { Write-Host "  [$($_[0]), $($_[1])]" }
        
        Write-Host "`nChecking for overlaps:" -ForegroundColor Cyan
    }
    
    # Check for overlaps
    for ($i = 0; $i -lt $sortedMeetings.Count - 1; $i++) {
        $currentEnd = $sortedMeetings[$i][1]
        $nextStart = $sortedMeetings[$i + 1][0]
        
        if ($ShowSteps) {
            Write-Host "  Meeting $($i): ends at $currentEnd" -NoNewline
            Write-Host " vs Meeting $($i+1): starts at $nextStart" -NoNewline
        }
        
        if ($currentEnd -gt $nextStart) {
            if ($ShowSteps) {
                Write-Host " -> OVERLAP!" -ForegroundColor Red
            }
            return $false
        } else {
            if ($ShowSteps) {
                Write-Host " -> OK" -ForegroundColor Green
            }
        }
    }
    
    if ($ShowSteps) {
        Write-Host "`nResult: Can attend all meetings!" -ForegroundColor Green
    }
    
    return $true
}

<#
.SYNOPSIS
    Optimized version using .NET ArrayList for better performance

.DESCRIPTION
    Uses .NET collections for faster sorting on large datasets
#>
function Can-Attend-All-Meetings-Optimized {
    param (
        [Parameter(Mandatory=$true)]
        [array]$meetings
    )
    
    if ($meetings.Count -le 1) {
        return $true
    }
    
    # Convert to ArrayList for better performance
    $meetingsList = New-Object System.Collections.ArrayList
    foreach ($meeting in $meetings) {
        [void]$meetingsList.Add($meeting)
    }
    
    # Sort using custom comparer
    $meetingsList.Sort({
        param($a, $b)
        return $a[0].CompareTo($b[0])
    })
    
    # Check overlaps
    for ($i = 0; $i -lt $meetingsList.Count - 1; $i++) {
        if ($meetingsList[$i][1] -gt $meetingsList[$i + 1][0]) {
            return $false
        }
    }
    
    return $true
}

<#
.SYNOPSIS
    Interactive demo and runner for Meeting Rooms problem solution

.DESCRIPTION
    Provides an interactive interface to test the Meeting Rooms solution
    with custom inputs or run predefined examples
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Show-Banner {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    MEETING ROOMS                             ║" -ForegroundColor Cyan
    Write-Host "║              GeeksforGeeks Problem of the Day                ║" -ForegroundColor Cyan
    Write-Host "║                  February 16, 2026                           ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
}

function Show-Menu {
    Write-Host "`n┌──────────────────────────────────────────────────────────────┐" -ForegroundColor White
    Write-Host "│                        MAIN MENU                             │" -ForegroundColor White
    Write-Host "└──────────────────────────────────────────────────────────────┘" -ForegroundColor White
    Write-Host "  1. Run Example 1 (Non-overlapping meetings)" -ForegroundColor Yellow
    Write-Host "  2. Run Example 2 (Overlapping meetings)" -ForegroundColor Yellow
    Write-Host "  3. Run Custom Input" -ForegroundColor Yellow
    Write-Host "  4. Run All Test Cases" -ForegroundColor Yellow
    Write-Host "  5. Show Algorithm Explanation" -ForegroundColor Yellow
    Write-Host "  6. Quick Demo with Multiple Examples" -ForegroundColor Yellow
    Write-Host "  0. Exit" -ForegroundColor Red
    Write-Host ""
}

function Run-Example1 {
    Write-Host "`n┌─────────────────────────────────────────┐" -ForegroundColor Green
    Write-Host "│  EXAMPLE 1: Non-overlapping Meetings   │" -ForegroundColor Green
    Write-Host "└─────────────────────────────────────────┘" -ForegroundColor Green
    
    $meetings = @(@(1,4), @(10,15), @(7,10))
    
    Write-Host "`nMeetings:" -ForegroundColor Cyan
    Write-Host "  [1, 4]   - Meeting from time 1 to 4" -ForegroundColor White
    Write-Host "  [10, 15] - Meeting from time 10 to 15" -ForegroundColor White
    Write-Host "  [7, 10]  - Meeting from time 7 to 10" -ForegroundColor White
    
    $result = Can-Attend-All-Meetings-Verbose -meetings $meetings -ShowSteps
    
    Write-Host "`n────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "Final Answer: " -NoNewline -ForegroundColor White
    Write-Host "$result" -ForegroundColor $(if ($result) { "Green" } else { "Red" })
}

function Run-Example2 {
    Write-Host "`n┌─────────────────────────────────────────┐" -ForegroundColor Yellow
    Write-Host "│  EXAMPLE 2: Overlapping Meetings       │" -ForegroundColor Yellow
    Write-Host "└─────────────────────────────────────────┘" -ForegroundColor Yellow
    
    $meetings = @(@(2,4), @(9,12), @(6,10))
    
    Write-Host "`nMeetings:" -ForegroundColor Cyan
    Write-Host "  [2, 4]   - Meeting from time 2 to 4" -ForegroundColor White
    Write-Host "  [9, 12]  - Meeting from time 9 to 12" -ForegroundColor White
    Write-Host "  [6, 10]  - Meeting from time 6 to 10" -ForegroundColor White
    
    $result = Can-Attend-All-Meetings-Verbose -meetings $meetings -ShowSteps
    
    Write-Host "`n────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "Final Answer: " -NoNewline -ForegroundColor White
    Write-Host "$result" -ForegroundColor $(if ($result) { "Green" } else { "Red" })
}

function Run-CustomInput {
    Write-Host "`n┌─────────────────────────────────────────┐" -ForegroundColor Magenta
    Write-Host "│         Custom Input Mode               │" -ForegroundColor Magenta
    Write-Host "└─────────────────────────────────────────┘" -ForegroundColor Magenta
    
    Write-Host "`nEnter the number of meetings: " -NoNewline -ForegroundColor Cyan
    $n = Read-Host
    
    if (-not ($n -match '^\d+$')) {
        Write-Host "Invalid input. Please enter a number." -ForegroundColor Red
        return
    }
    
    $n = [int]$n
    $meetings = @()
    
    Write-Host "`nEnter each meeting as 'start end' (e.g., '1 4'):" -ForegroundColor Cyan
    for ($i = 0; $i -lt $n; $i++) {
        Write-Host "  Meeting $($i+1): " -NoNewline -ForegroundColor Yellow
        $input = Read-Host
        
        $parts = $input.Split(' ', [StringSplitOptions]::RemoveEmptyEntries)
        if ($parts.Count -ne 2) {
            Write-Host "Invalid format. Using default [1, 2]" -ForegroundColor Red
            $meetings += ,@(1, 2)
        } else {
            $start = [int]$parts[0]
            $end = [int]$parts[1]
            $meetings += ,@($start, $end)
        }
    }
    
    Write-Host "`nProcessing your meetings..." -ForegroundColor Cyan
    $result = Can-Attend-All-Meetings-Verbose -meetings $meetings -ShowSteps
    
    Write-Host "`n────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host "Final Answer: " -NoNewline -ForegroundColor White
    Write-Host "$result" -ForegroundColor $(if ($result) { "Green" } else { "Red" })
}

function Run-AllTests {
    Write-Host "`n┌─────────────────────────────────────────┐" -ForegroundColor Blue
    Write-Host "│      Running Comprehensive Tests        │" -ForegroundColor Blue
    Write-Host "└─────────────────────────────────────────┘" -ForegroundColor Blue
    Write-Host ""
    
    & "$PSScriptRoot\Tests.ps1"
}

function Show-AlgorithmExplanation {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                  ALGORITHM EXPLANATION                       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    Write-Host "`nProblem: " -ForegroundColor Yellow
    Write-Host "  Can a person attend all meetings without conflicts?" -ForegroundColor White
    
    Write-Host "`nKey Insight:" -ForegroundColor Yellow
    Write-Host "  A meeting conflict occurs when one meeting starts before" -ForegroundColor White
    Write-Host "  another meeting ends. We need to check if any two meetings" -ForegroundColor White
    Write-Host "  overlap in time." -ForegroundColor White
    
    Write-Host "`nApproach:" -ForegroundColor Yellow
    Write-Host "  1. Sort all meetings by their START time" -ForegroundColor Green
    Write-Host "  2. Check consecutive meetings for overlaps" -ForegroundColor Green
    Write-Host "  3. If meeting[i] ends AFTER meeting[i+1] starts → CONFLICT" -ForegroundColor Green
    Write-Host "  4. If no conflicts found → Can attend all meetings" -ForegroundColor Green
    
    Write-Host "`nWhy Sorting Works:" -ForegroundColor Yellow
    Write-Host "  • After sorting, if consecutive meetings don't overlap," -ForegroundColor White
    Write-Host "    no other meetings will overlap" -ForegroundColor White
    Write-Host "  • We only need O(n) time to check after O(n log n) sorting" -ForegroundColor White
    
    Write-Host "`nComplexity Analysis:" -ForegroundColor Yellow
    Write-Host "  • Time Complexity:  O(n log n) - dominated by sorting" -ForegroundColor Cyan
    Write-Host "  • Space Complexity: O(1) - constant extra space" -ForegroundColor Cyan
    
    Write-Host "`nExample Walkthrough:" -ForegroundColor Yellow
    Write-Host "  Input:    [[2,4], [9,12], [6,10]]" -ForegroundColor White
    Write-Host "  Sorted:   [[2,4], [6,10], [9,12]]" -ForegroundColor White
    Write-Host "  Check 1:  [2,4] ends at 4, [6,10] starts at 6  ✓ OK" -ForegroundColor Green
    Write-Host "  Check 2:  [6,10] ends at 10, [9,12] starts at 9 ✗ OVERLAP!" -ForegroundColor Red
    Write-Host "  Result:   False - Cannot attend all meetings" -ForegroundColor Red
    
    Write-Host ""
}

function Run-QuickDemo {
    Write-Host "`n╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                     QUICK DEMO MODE                          ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    $testCases = @(
        @{
            Name = "Back-to-back meetings"
            Meetings = @(@(1,2), @(2,3), @(3,4))
            Expected = $true
        },
        @{
            Name = "One long meeting spanning others"
            Meetings = @(@(1,10), @(3,5), @(6,8))
            Expected = $false
        },
        @{
            Name = "Complex schedule - no conflicts"
            Meetings = @(@(15,20), @(5,10), @(0,3), @(21,25))
            Expected = $true
        },
        @{
            Name = "Identical meeting times"
            Meetings = @(@(5,10), @(5,10))
            Expected = $false
        }
    )
    
    foreach ($test in $testCases) {
        Write-Host "`n──────────────────────────────────────────" -ForegroundColor DarkGray
        Write-Host $test.Name -ForegroundColor Yellow
        Write-Host "Meetings: $($test.Meetings | ForEach-Object { "[$($_[0]),$($_[1])]" } | Join-String -Separator ', ')" -ForegroundColor White
        
        $result = Can-Attend-All-Meetings -meetings $test.Meetings
        
        Write-Host "Result: " -NoNewline
        Write-Host "$result" -ForegroundColor $(if ($result) { "Green" } else { "Red" })
        Write-Host "Status: " -NoNewline
        if ($result -eq $test.Expected) {
            Write-Host "✓ Correct" -ForegroundColor Green
        } else {
            Write-Host "✗ Incorrect (Expected: $($test.Expected))" -ForegroundColor Red
        }
    }
    
    Write-Host ""
}

# Main program loop
Show-Banner

do {
    Show-Menu
    Write-Host "Select an option: " -NoNewline -ForegroundColor White
    $choice = Read-Host
    
    switch ($choice) {
        "1" { Run-Example1 }
        "2" { Run-Example2 }
        "3" { Run-CustomInput }
        "4" { Run-AllTests }
        "5" { Show-AlgorithmExplanation }
        "6" { Run-QuickDemo }
        "0" { 
            Write-Host "`nThank you for using Meeting Rooms solver!" -ForegroundColor Green
            break
        }
        default { 
            Write-Host "`nInvalid option. Please try again." -ForegroundColor Red
        }
    }
    
    if ($choice -ne "0") {
        Write-Host "`nPress any key to continue..." -ForegroundColor DarkGray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    
} while ($choice -ne "0")
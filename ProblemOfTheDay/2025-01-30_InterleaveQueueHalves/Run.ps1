<#
.SYNOPSIS
    Interactive runner for the Interleave Queue solution

.DESCRIPTION
    Allows you to test the solution with custom inputs
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Show-Menu {
    Write-Host @"
╔══════════════════════════════════════════════════════════════════╗
║   Interleave the First Half of the Queue with Second Half        ║
║   GeeksforGeeks Problem of the Day - January 30, 2026            ║
╚══════════════════════════════════════════════════════════════════╝

Select an option:
  1. Run with Example 1: [2, 4, 3, 1]
  2. Run with Example 2: [3, 5]
  3. Run with custom input
  4. Run all tests
  5. Show algorithm explanation
  6. Exit

"@ -ForegroundColor Cyan
}

function Get-CustomInput {
    Write-Host "Enter queue elements separated by commas (e.g., 1,2,3,4):" -ForegroundColor Yellow
    $input = Read-Host
    try {
        $queue = $input -split ',' | ForEach-Object { [int]$_.Trim() }
        return $queue
    } catch {
        Write-Host "Invalid input. Please enter integers separated by commas." -ForegroundColor Red
        return $null
    }
}

function Run-Solution {
    param([int[]]$Queue)
    
    Write-Host "`nInput Queue: [$($Queue -join ', ')]" -ForegroundColor White
    Write-Host ""
    
    try {
        Write-Host "Method 1 (Array Split):" -ForegroundColor Cyan
        $result1 = Invoke-InterleaveQueue -Queue $Queue
        Write-Host "  Result: [$($result1 -join ', ')]" -ForegroundColor Green
        
        Write-Host "`nMethod 2 (Using Stack):" -ForegroundColor Cyan
        $result2 = Invoke-InterleaveQueueUsingStack -Queue $Queue
        Write-Host "  Result: [$($result2 -join ', ')]" -ForegroundColor Green
        
        Write-Host "`nMethod 3 (Using Temp Queue):" -ForegroundColor Cyan
        $result3 = Invoke-InterleaveQueueSimple -Queue $Queue
        Write-Host "  Result: [$($result3 -join ', ')]" -ForegroundColor Green
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

function Show-Explanation {
    Write-Host @"

╔══════════════════════════════════════════════════════════════════╗
║                    ALGORITHM EXPLANATION                          ║
╚══════════════════════════════════════════════════════════════════╝

Problem: Given queue [2, 4, 3, 1], interleave first half with second half.

┌─────────────────────────────────────────────────────────────────┐
│ STEP 1: Identify the halves                                     │
├─────────────────────────────────────────────────────────────────┤
│   Original Queue: [2, 4, 3, 1]                                  │
│                    ├───┤ ├───┤                                  │
│   First Half:     [2, 4]                                        │
│   Second Half:          [3, 1]                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ STEP 2: Interleave alternately                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   Position 0: Take from First Half  → 2                        │
│   Position 1: Take from Second Half → 3                        │
│   Position 2: Take from First Half  → 4                        │
│   Position 3: Take from Second Half → 1                        │
│                                                                 │
│   Result: [2, 3, 4, 1]                                          │
└─────────────────────────────────────────────────────────────────┘

TIME COMPLEXITY:  O(n) - We visit each element once
SPACE COMPLEXITY: O(n) - We use auxiliary storage for half the queue

THREE APPROACHES IMPLEMENTED:
1. Array Split Method   - Directly split and merge (simplest)
2. Stack-Based Method   - Classic DSA approach with stack operations
3. Temp Queue Method    - Uses auxiliary queue (most intuitive)

"@ -ForegroundColor Cyan
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "1" { Run-Solution -Queue @(2, 4, 3, 1) }
        "2" { Run-Solution -Queue @(3, 5) }
        "3" {
            $customQueue = Get-CustomInput
            if ($customQueue) {
                Run-Solution -Queue $customQueue
            }
        }
        "4" {
            Write-Host "`nRunning all tests..." -ForegroundColor Yellow
            & "$PSScriptRoot\Tests.ps1"
        }
        "5" { Show-Explanation }
        "6" {
            Write-Host "Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "Invalid choice. Please try again." -ForegroundColor Red
        }
    }
    
    if ($choice -ne "6") {
        Write-Host "`nPress Enter to continue..." -ForegroundColor Gray
        Read-Host
        Clear-Host
    }
} while ($choice -ne "6")

<#
.SYNOPSIS
    Interactive runner for the Smallest Window solution.

.DESCRIPTION
    This script allows you to interactively test the Get-SmallestWindow function
    with custom inputs or run the predefined examples.

.EXAMPLE
    .\Run.ps1
#>

# Import the solution
. "$PSScriptRoot\smallest_window.ps1"

function Show-Menu {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  Smallest Window - Interactive Runner" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  1. Run with GFG examples" -ForegroundColor White
    Write-Host "  2. Enter custom input" -ForegroundColor White
    Write-Host "  3. Run verbose mode (shows algorithm steps)" -ForegroundColor White
    Write-Host "  4. Run all tests" -ForegroundColor White
    Write-Host "  5. Exit" -ForegroundColor White
    Write-Host ""
}

function Run-Examples {
    Write-Host "`n--- Running GFG Examples ---`n" -ForegroundColor Yellow
    
    $examples = @(
        @{ s = "timetopractice"; p = "toc"; expected = "toprac" },
        @{ s = "zoomlazapzo"; p = "oza"; expected = "apzo" },
        @{ s = "abc"; p = "xyz"; expected = "" }
    )
    
    foreach ($example in $examples) {
        Write-Host "Input:    s = '$($example.s)', p = '$($example.p)'" -ForegroundColor White
        $result = Get-SmallestWindow -s $example.s -p $example.p
        Write-Host "Output:   '$result'" -ForegroundColor Green
        Write-Host "Expected: '$($example.expected)'" -ForegroundColor Gray
        
        if ($result -eq $example.expected) {
            Write-Host "Status:   CORRECT" -ForegroundColor Green
        } else {
            Write-Host "Status:   INCORRECT" -ForegroundColor Red
        }
        Write-Host ""
    }
}

function Run-CustomInput {
    Write-Host "`n--- Custom Input ---`n" -ForegroundColor Yellow
    
    $s = Read-Host "Enter source string (s)"
    $p = Read-Host "Enter pattern string (p)"
    
    Write-Host "`nProcessing..." -ForegroundColor Gray
    $result = Get-SmallestWindow -s $s -p $p
    
    Write-Host "`nResult: " -NoNewline -ForegroundColor White
    if ($result -eq "") {
        Write-Host "(empty string - no valid window found)" -ForegroundColor Yellow
    } else {
        Write-Host "'$result'" -ForegroundColor Green
        Write-Host "Length: $($result.Length)" -ForegroundColor Gray
    }
}

function Run-VerboseMode {
    Write-Host "`n--- Verbose Mode ---`n" -ForegroundColor Yellow
    
    $s = Read-Host "Enter source string (s)"
    $p = Read-Host "Enter pattern string (p)"
    
    Write-Host "`n--- Algorithm Trace ---`n" -ForegroundColor Cyan
    $result = Get-SmallestWindowVerbose -s $s -p $p -Verbose
    
    Write-Host "`n--- Final Result ---" -ForegroundColor Cyan
    if ($result -eq "") {
        Write-Host "No valid window found" -ForegroundColor Yellow
    } else {
        Write-Host "Smallest window: '$result' (length: $($result.Length))" -ForegroundColor Green
    }
}

function Run-AllTests {
    Write-Host "`n--- Running All Tests ---`n" -ForegroundColor Yellow
    & "$PSScriptRoot\test_smallest_window.ps1"
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Select an option (1-5)"
    
    switch ($choice) {
        "1" { Run-Examples }
        "2" { Run-CustomInput }
        "3" { Run-VerboseMode }
        "4" { Run-AllTests }
        "5" { 
            Write-Host "`nGoodbye!`n" -ForegroundColor Cyan
            exit 0
        }
        default {
            Write-Host "`nInvalid option. Please select 1-5." -ForegroundColor Red
        }
    }
} while ($true)
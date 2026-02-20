<#
.SYNOPSIS
    Run the Form the Largest Number solution with interactive examples

.DESCRIPTION
    Demonstrates the solution with various test cases and allows user input
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Show-Header {
    Clear-Host
    Write-Host @"
╔══════════════════════════════════════════════════════════════════╗
║            Form the Largest Number                                ║
║       GeeksforGeeks Problem of the Day - February 20, 2026        ║
╚══════════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan
    Write-Host ""
}

function Show-ProblemDescription {
    Write-Host "PROBLEM:" -ForegroundColor Yellow
    Write-Host "Given an array of non-negative integers, arrange them so that after"
    Write-Host "concatenating all of them in order, it results in the largest possible number."
    Write-Host ""
}

function Run-Example {
    param (
        [string]$Name,
        [int[]]$Numbers
    )
    
    Write-Host "Example: $Name" -ForegroundColor Cyan
    Write-Host "Input:  [$($Numbers -join ', ')]" -ForegroundColor White
    
    $result = Get-LargestNumberOptimized -Numbers $Numbers
    
    Write-Host "Output: $result" -ForegroundColor Green
    Write-Host ""
}

function Show-StepByStepDemo {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "STEP-BY-STEP DEMONSTRATION" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    $numbers = @(3, 30, 34, 5, 9)
    Write-Host "Let's solve: [$($numbers -join ', ')]" -ForegroundColor White
    Write-Host ""
    
    # Step 1
    Write-Host "Step 1: Convert to strings" -ForegroundColor Yellow
    Write-Host "        [3, 30, 34, 5, 9] → ['3', '30', '34', '5', '9']" -ForegroundColor Cyan
    Write-Host ""
    
    # Step 2
    Write-Host "Step 2: Compare pairs to determine order" -ForegroundColor Yellow
    
    $comparisons = @(
        @{X="9"; Y="5"; XY="95"; YX="59"; Winner="9 before 5"},
        @{X="9"; Y="34"; XY="934"; YX="349"; Winner="9 before 34"},
        @{X="5"; Y="34"; XY="534"; YX="345"; Winner="5 before 34"},
        @{X="34"; Y="3"; XY="343"; YX="334"; Winner="34 before 3"},
        @{X="3"; Y="30"; XY="330"; YX="303"; Winner="3 before 30"}
    )
    
    foreach ($comp in $comparisons) {
        Write-Host "        Compare: '$($comp.X)' vs '$($comp.Y)'" -ForegroundColor Cyan
        Write-Host "          '$($comp.X)$($comp.Y)' = '$($comp.XY)' vs '$($comp.Y)$($comp.X)' = '$($comp.YX)'" -ForegroundColor Gray
        Write-Host "          Result: $($comp.Winner)" -ForegroundColor Green
    }
    Write-Host ""
    
    # Step 3
    Write-Host "Step 3: After sorting with custom comparator" -ForegroundColor Yellow
    Write-Host "        ['9', '5', '34', '3', '30']" -ForegroundColor Cyan
    Write-Host ""
    
    # Step 4
    Write-Host "Step 4: Concatenate the sorted strings" -ForegroundColor Yellow
    $result = Get-LargestNumberOptimized -Numbers $numbers
    Write-Host "        Final Result: $result" -ForegroundColor Green
    Write-Host ""
}

function Run-InteractiveMode {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "INTERACTIVE MODE" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    while ($true) {
        Write-Host "Enter numbers separated by commas (or 'q' to quit): " -ForegroundColor Yellow -NoNewline
        $input = Read-Host
        
        if ($input -eq 'q' -or $input -eq 'quit' -or $input -eq 'exit') {
            Write-Host "Exiting interactive mode." -ForegroundColor Cyan
            break
        }
        
        try {
            # Parse the input
            $numbers = $input -split ',' | ForEach-Object { [int]$_.Trim() }
            
            if ($numbers.Count -eq 0) {
                Write-Host "Please enter at least one number." -ForegroundColor Red
                continue
            }
            
            Write-Host "`nProcessing: [$($numbers -join ', ')]" -ForegroundColor Cyan
            
            $result = Get-LargestNumberOptimized -Numbers $numbers
            
            Write-Host "Largest Number: " -NoNewline -ForegroundColor White
            Write-Host "$result" -ForegroundColor Green
            Write-Host ""
            
        } catch {
            Write-Host "Invalid input. Please enter numbers separated by commas." -ForegroundColor Red
            Write-Host "Example: 3, 30, 34, 5, 9" -ForegroundColor Gray
            Write-Host ""
        }
    }
}

function Show-Menu {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "MENU" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "1. Run predefined examples" -ForegroundColor White
    Write-Host "2. Step-by-step demonstration" -ForegroundColor White
    Write-Host "3. Interactive mode (enter your own numbers)" -ForegroundColor White
    Write-Host "4. Run full test suite" -ForegroundColor White
    Write-Host "5. Performance benchmark" -ForegroundColor White
    Write-Host "Q. Quit" -ForegroundColor White
    Write-Host ""
    Write-Host "Select an option: " -ForegroundColor Yellow -NoNewline
}

function Run-PredefinedExamples {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "RUNNING PREDEFINED EXAMPLES" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    
    Run-Example "Basic case with prefix overlap" @(3, 30, 34, 5, 9)
    Run-Example "Similar prefix numbers" @(54, 546, 548, 60)
    Run-Example "All zeros" @(0, 0, 0)
    Run-Example "Sequential numbers" @(1, 2, 3, 4, 5)
    Run-Example "Large numbers" @(824, 938, 1399, 5607, 6973)
    Run-Example "Numbers with common prefix" @(121, 12)
    Run-Example "Complex prefix case" @(8, 80, 800, 8000)
    
    Write-Host "Press any key to continue..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Run-PerformanceBenchmark {
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "PERFORMANCE BENCHMARK" -ForegroundColor Magenta
    Write-Host "========================================`n" -ForegroundColor Magenta
    
    $sizes = @(10, 50, 100, 500, 1000)
    
    Write-Host "Testing with different array sizes...`n" -ForegroundColor Cyan
    
    foreach ($size in $sizes) {
        $testArray = 1..$size | ForEach-Object { Get-Random -Minimum 0 -Maximum 100000 }
        
        # Test optimized version
        $start = Get-Date
        $result = Get-LargestNumberOptimized -Numbers $testArray
        $elapsed = ((Get-Date) - $start).TotalMilliseconds
        
        Write-Host "Size: $size elements" -ForegroundColor White
        Write-Host "  Time: $($elapsed.ToString('F2')) ms" -ForegroundColor Green
        Write-Host "  Result length: $($result.Length) digits" -ForegroundColor Cyan
        Write-Host ""
    }
    
    Write-Host "Press any key to continue..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main execution
Show-Header
Show-ProblemDescription

while ($true) {
    Show-Menu
    $choice = Read-Host
    
    switch ($choice.ToUpper()) {
        '1' {
            Show-Header
            Run-PredefinedExamples
        }
        '2' {
            Show-Header
            Show-StepByStepDemo
            Write-Host "Press any key to continue..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '3' {
            Show-Header
            Run-InteractiveMode
        }
        '4' {
            Show-Header
            Write-Host "Running full test suite...`n" -ForegroundColor Cyan
            & "$PSScriptRoot\Tests.ps1"
            Write-Host "`nPress any key to continue..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '5' {
            Show-Header
            Run-PerformanceBenchmark
        }
        'Q' {
            Write-Host "`nThank you for using the Form the Largest Number solution!" -ForegroundColor Green
            Write-Host "Visit: https://www.geeksforgeeks.org/problems/largest-number-formed-from-an-array1117/1" -ForegroundColor Cyan
            exit
        }
        default {
            Write-Host "Invalid option. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}
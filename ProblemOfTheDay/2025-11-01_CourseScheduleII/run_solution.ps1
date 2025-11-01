# Course Schedule II - Solution Runner
# Simple script to run the Course Schedule II solution with custom inputs

param(
    [switch]$RunTests,
    [switch]$RunExamples,
    [int]$n = 0,
    [string]$Prerequisites = ""
)

Write-Host "Course Schedule II - Solution Runner" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

# Import the solution
. "$PSScriptRoot\course_schedule_ii.ps1"

if ($RunTests) {
    Write-Host "Running comprehensive test suite..." -ForegroundColor Yellow
    . "$PSScriptRoot\test_course_schedule_ii.ps1"
    Test-CourseScheduleII
    return
}

if ($RunExamples) {
    Write-Host "Running example cases from the problem..." -ForegroundColor Yellow
    Write-Host ""
    
    # Example 1
    Write-Host "Example 1: Basic chain (n=3, prerequisites=[[1,0],[2,1]])"
    Solve-CourseScheduleII -n 3 -prerequisites @(@(1, 0), @(2, 1))
    Write-Host ""
    
    # Example 2
    Write-Host "Example 2: Multiple dependencies (n=4, prerequisites=[[2,0],[2,1],[3,2]])"
    Solve-CourseScheduleII -n 4 -prerequisites @(@(2, 0), @(2, 1), @(3, 2))
    Write-Host ""
    
    return
}

if ($n -gt 0 -and $Prerequisites -ne "") {
    Write-Host "Running custom input..." -ForegroundColor Yellow
    Write-Host "n = $n"
    Write-Host "Prerequisites string: $Prerequisites"
    
    try {
        # Parse prerequisites string (expected format: "[[1,0],[2,1]]")
        $prereqArray = @()
        $Prerequisites = $Prerequisites.Trim()
        if ($Prerequisites.StartsWith("[[") -and $Prerequisites.EndsWith("]]")) {
            $cleanStr = $Prerequisites.Substring(2, $Prerequisites.Length - 4)
            $pairs = $cleanStr -split '\],\['
            
            foreach ($pair in $pairs) {
                $numbers = $pair -split ','
                if ($numbers.Count -eq 2) {
                    $prereqArray += @([int]$numbers[0].Trim(), [int]$numbers[1].Trim())
                }
            }
        }
        
        Write-Host "Parsed prerequisites: $($prereqArray | ConvertTo-Json -Compress)"
        Write-Host ""
        
        Solve-CourseScheduleII -n $n -prerequisites $prereqArray
    }
    catch {
        Write-Host "Error parsing prerequisites. Expected format: [[1,0],[2,1]]" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    }
    return
}

# Show usage if no parameters provided
Write-Host "Usage:" -ForegroundColor Cyan
Write-Host "  .\run_solution.ps1 -RunTests              # Run all test cases"
Write-Host "  .\run_solution.ps1 -RunExamples           # Run problem examples"
Write-Host "  .\run_solution.ps1 -n 3 -Prerequisites '[[1,0],[2,1]]'  # Custom input"
Write-Host ""
Write-Host "Examples:" -ForegroundColor Cyan
Write-Host "  .\run_solution.ps1 -RunTests"
Write-Host "  .\run_solution.ps1 -RunExamples"
Write-Host "  .\run_solution.ps1 -n 4 -Prerequisites '[[2,0],[2,1],[3,2]]'"
Write-Host ""
Write-Host "Interactive mode - Enter your own test case:" -ForegroundColor Yellow

do {
    try {
        $inputN = Read-Host "Enter number of courses (or 'q' to quit)"
        if ($inputN -eq 'q') { break }
        
        $n = [int]$inputN
        if ($n -le 0) {
            Write-Host "Number of courses must be positive" -ForegroundColor Red
            continue
        }
        
        $inputPrereq = Read-Host "Enter prerequisites as [[x,y],[a,b],...] (or empty for no prerequisites)"
        
        if ($inputPrereq -eq "" -or $inputPrereq -eq "[]") {
            $prereqArray = @()
        } else {
            $prereqArray = @()
            $cleanStr = $inputPrereq.Trim()
            if ($cleanStr.StartsWith("[[") -and $cleanStr.EndsWith("]]")) {
                $cleanStr = $cleanStr.Substring(2, $cleanStr.Length - 4)
                $pairs = $cleanStr -split '\],\['
                
                foreach ($pair in $pairs) {
                    $numbers = $pair -split ','
                    if ($numbers.Count -eq 2) {
                        $prereqArray += @([int]$numbers[0].Trim(), [int]$numbers[1].Trim())
                    }
                }
            } else {
                Write-Host "Invalid format. Expected: [[x,y],[a,b],...]" -ForegroundColor Red
                continue
            }
        }
        
        Write-Host ""
        Solve-CourseScheduleII -n $n -prerequisites $prereqArray
        Write-Host ""
        
    } catch {
        Write-Host "Invalid input. Please try again." -ForegroundColor Red
    }
} while ($true)

Write-Host "Goodbye!" -ForegroundColor Green

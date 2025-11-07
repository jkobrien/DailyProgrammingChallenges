# PowerShell Tests for fetch_and_solve_potd.ps1

# Import the script to test
. .\fetch_and_solve_potd.ps1

# Test: Verify Get-ProblemOfTheDay fetches a valid problem
function Test-GetProblemOfTheDay {
    $problem = Get-ProblemOfTheDay
    if ($problem -and $problem.Title -and $problem.Url) {
        Write-Output "Test Passed: Get-ProblemOfTheDay fetched a valid problem."
    } else {
        Write-Error "Test Failed: Get-ProblemOfTheDay did not fetch a valid problem."
    }
}

# Test: Verify Solve-ProblemOfTheDay outputs the correct format
function Test-SolveProblemOfTheDay {
    $mockProblem = @{
        Title = "Mock Problem Title"
        Url = "https://practice.geeksforgeeks.org/mock-problem-url"
    }
    $output = Solve-ProblemOfTheDay -Title $mockProblem.Title -Url $mockProblem.Url
    if ($output -match "Problem Title: Mock Problem Title" -and $output -match "Problem URL: https://practice.geeksforgeeks.org/mock-problem-url") {
        Write-Output "Test Passed: Solve-ProblemOfTheDay outputs the correct format."
    } else {
        Write-Error "Test Failed: Solve-ProblemOfTheDay did not output the correct format."
    }
}

# Run Tests
Test-GetProblemOfTheDay
Test-SolveProblemOfTheDay

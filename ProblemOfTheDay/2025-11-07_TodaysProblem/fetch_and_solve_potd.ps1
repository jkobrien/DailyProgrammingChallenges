# PowerShell Script to Fetch and Solve Geeks for Geeks Problem of the Day

# Fetch the Problem of the Day from Geeks for Geeks
function Get-ProblemOfTheDay {
    $url = "https://practice.geeksforgeeks.org/problem-of-the-day"
    $response = Invoke-WebRequest -Uri $url -UseBasicParsing
    $html = $response.Content

    # Extract the problem title and URL using regex
    if ($html -match '<a href="(/problems/[^"]+)"[^>]*>([^<]+)</a>') {
        $problemUrl = "https://practice.geeksforgeeks.org$($matches[1])"
        $problemTitle = $matches[2]
        return @{
            Title = $problemTitle
            Url = $problemUrl
        }
    } else {
        Write-Error "Failed to fetch the Problem of the Day."
        return $null
    }
}

# Solve the Problem of the Day (Example Solution)
function Solve-ProblemOfTheDay {
    param (
        [string]$Title,
        [string]$Url
    )

    # Example solution placeholder
    Write-Output "Problem Title: $Title"
    Write-Output "Problem URL: $Url"
    Write-Output "Solution: This is a placeholder for the solution."
}

# Main Script Execution
$problem = Get-ProblemOfTheDay
if ($problem) {
    Solve-ProblemOfTheDay -Title $problem.Title -Url $problem.Url
}

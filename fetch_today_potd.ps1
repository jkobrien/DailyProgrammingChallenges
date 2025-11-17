# Fetch today's Problem of the Day from GeeksforGeeks
$url = "https://practiceapi.geeksforgeeks.org/api/v1/problems-of-day/problem/today"
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
}

try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    
    if ($response.problem) {
        $problem = $response.problem
        
        Write-Host "Title: $($problem.title)" -ForegroundColor Green
        Write-Host ("-" * 50)
        Write-Host "`nProblem Statement:" -ForegroundColor Yellow
        Write-Host $problem.problem_statement
        Write-Host "`nExample:" -ForegroundColor Yellow
        Write-Host $problem.example
        Write-Host "`nConstraints:" -ForegroundColor Yellow
        Write-Host $problem.constraints
        
        # Return the problem data
        return $problem
    }
} catch {
    Write-Host "Error fetching problem: $_" -ForegroundColor Red
    return $null
}

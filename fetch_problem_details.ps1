# Fetch today's Problem of the Day details
$url = "https://practiceapi.geeksforgeeks.org/api/v1/problems-of-day/problem/today"
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
}

try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    $response | ConvertTo-Json -Depth 10 | Out-File -FilePath "problem_today.json" -Encoding UTF8
    Write-Host "Problem fetched successfully!" -ForegroundColor Green
    Write-Host "Title: $($response.problem_name)" -ForegroundColor Cyan
    Write-Host "URL: $($response.problem_url)" -ForegroundColor Yellow
    $response | ConvertTo-Json -Depth 10
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
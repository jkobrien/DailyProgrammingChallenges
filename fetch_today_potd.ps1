# Fetch today's Problem of the Day from GeeksforGeeks
$url = "https://practiceapi.geeksforgeeks.org/api/v1/problems-of-day/problem/today"
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
}

try {
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    if ($response) {
        Write-Host "Title: $($response.problem_name)" -ForegroundColor Green
        Write-Host ("-" * 50)
        Write-Host "`nProblem URL: $($response.problem_url)" -ForegroundColor Yellow
        #Write-Host "`nDifficulty: $($response.difficulty)"
        #Write-Host "`nTags: $($response.tags.topic_tags -join ', ')"
        #Write-Host "`nAccuracy: $($response.accuracy)%"
        #Write-Host "`nTotal Submissions: $($response.total_submissions)"

        # Fetch problem HTML from problem_url
        $problemHtml = Invoke-WebRequest -Uri $response.problem_url -Headers $headers -UseBasicParsing
        $htmlContent = $problemHtml.Content

        $decoded  = [System.Net.WebUtility]::HtmlDecode($htmlContent)
        $htmlContent = [System.Net.WebUtility]::HtmlDecode($decoded)
        # Automated extraction using regex
        $html = $htmlContent
        $ogTitle = ""
        $ogDesc = ""
        if ($html -match '<meta property="og:title" content="([^"]+)"') {
            $ogTitle = $matches[1]
        }
        if ($html -match '<meta property="og:description" content="([^"]+)"') {
            $ogDesc = $matches[1]
        }
        #Write-Host "`nTitle: $ogTitle" -ForegroundColor Cyan
        #Write-Host "`nDescription: $ogDesc" -ForegroundColor Cyan
        return $ogDesc
    }
} catch {
    Write-Host "Error fetching problem: $_" -ForegroundColor Red
    return $null
}

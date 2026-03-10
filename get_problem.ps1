$html = Invoke-WebRequest -Uri 'https://www.geeksforgeeks.org/problems/subarrays-with-first-element-minimum/1' -Headers @{'User-Agent'='Mozilla/5.0'} -UseBasicParsing
$html.Content | Out-File -FilePath 'problem_temp.html' -Encoding UTF8
Write-Host "Downloaded problem page"
$costs = @(@(3, 5, 2, 9))
Write-Host "Walls: $($costs.Count)"
Write-Host "Colors: $($costs[0].Count)"

$result = . "$PSScriptRoot\walls_coloring_ii.ps1" | Out-Null
$result2 = Get-MinCostToPaintWalls -costs $costs
Write-Host "Result: $result2"

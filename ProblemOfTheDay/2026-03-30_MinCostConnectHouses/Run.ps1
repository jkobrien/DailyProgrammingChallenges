<#
.SYNOPSIS
    Run script for Minimum Cost to Connect All Houses solution

.DESCRIPTION
    Interactive script to run the solution with custom inputs or examples
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

Write-Host "=" * 60
Write-Host "Minimum Cost to Connect All Houses in a City"
Write-Host "=" * 60
Write-Host ""

# Run with example inputs
Write-Host "Example 1:" -ForegroundColor Cyan
Write-Host "Houses: [[0,7], [0,9], [20,7], [30,7], [40,70]]"
$houses1 = @(
    @(0, 7),
    @(0, 9),
    @(20, 7),
    @(30, 7),
    @(40, 70)
)
$result1 = Get-MinCostToConnectHouses -houses $houses1
Write-Host "Minimum cost to connect all houses: " -NoNewline
Write-Host $result1 -ForegroundColor Green
Write-Host ""

Write-Host "Example 2:" -ForegroundColor Cyan
Write-Host "Houses: [[0,0], [1,1], [1,3], [3,0]]"
$houses2 = @(
    @(0, 0),
    @(1, 1),
    @(1, 3),
    @(3, 0)
)
$result2 = Get-MinCostToConnectHouses -houses $houses2
Write-Host "Minimum cost to connect all houses: " -NoNewline
Write-Host $result2 -ForegroundColor Green
Write-Host ""

# Interactive mode
Write-Host "-" * 60
Write-Host "Try your own input:" -ForegroundColor Yellow
Write-Host "Enter house coordinates, one per line (format: x y)"
Write-Host "Enter an empty line when done"
Write-Host ""

$customHouses = @()
while ($true) {
    $input = Read-Host "House $($customHouses.Count + 1) (x y)"
    
    if ([string]::IsNullOrWhiteSpace($input)) {
        break
    }
    
    $parts = $input -split '\s+'
    if ($parts.Count -ge 2) {
        try {
            $x = [int]$parts[0]
            $y = [int]$parts[1]
            $customHouses += ,@($x, $y)
        }
        catch {
            Write-Host "Invalid input. Please enter two numbers separated by space." -ForegroundColor Red
        }
    }
    else {
        Write-Host "Invalid input. Please enter two numbers separated by space." -ForegroundColor Red
    }
}

if ($customHouses.Count -gt 0) {
    Write-Host ""
    Write-Host "Your houses:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $customHouses.Count; $i++) {
        Write-Host "  House $($i + 1): ($($customHouses[$i][0]), $($customHouses[$i][1]))"
    }
    
    $customResult = Get-MinCostToConnectHouses -houses $customHouses
    Write-Host ""
    Write-Host "Minimum cost to connect all houses: " -NoNewline
    Write-Host $customResult -ForegroundColor Green
}
else {
    Write-Host "No custom houses entered." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=" * 60
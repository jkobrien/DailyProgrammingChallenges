<#
.SYNOPSIS
    Test cases for Minimum Cost to Connect All Houses solution

.DESCRIPTION
    Runs comprehensive tests to verify the solution works correctly
    for various inputs including edge cases.
#>

# Import the solution
. "$PSScriptRoot\Solution.ps1"

function Test-MinCostToConnectHouses {
    param(
        [string]$TestName,
        [array]$Houses,
        [int]$Expected,
        [string]$Algorithm = "Prim"
    )
    
    if ($Algorithm -eq "Prim") {
        $result = Get-MinCostToConnectHouses -houses $Houses
    } else {
        $result = Get-MinCostKruskal -houses $Houses
    }
    
    $status = if ($result -eq $Expected) { "PASS" } else { "FAIL" }
    $color = if ($result -eq $Expected) { "Green" } else { "Red" }
    
    Write-Host "[$status] $TestName ($Algorithm)" -ForegroundColor $color
    if ($result -ne $Expected) {
        Write-Host "        Expected: $Expected, Got: $result" -ForegroundColor Yellow
    }
    
    return $result -eq $Expected
}

Write-Host "=" * 60
Write-Host "Testing: Minimum Cost to Connect All Houses in a City"
Write-Host "=" * 60
Write-Host ""

$allPassed = $true

# ============================================================
# Example Test Cases from GeeksforGeeks
# ============================================================
Write-Host "--- GeeksforGeeks Examples ---" -ForegroundColor Cyan

# Example 1: n=5, houses=[[0,7],[0,9],[20,7],[30,7],[40,70]] -> 105
$houses1 = @(
    @(0, 7),
    @(0, 9),
    @(20, 7),
    @(30, 7),
    @(40, 70)
)
$allPassed = (Test-MinCostToConnectHouses -TestName "Example 1" -Houses $houses1 -Expected 105) -and $allPassed
$allPassed = (Test-MinCostToConnectHouses -TestName "Example 1" -Houses $houses1 -Expected 105 -Algorithm "Kruskal") -and $allPassed

# Example 2: n=4, houses=[[0,0],[1,1],[1,3],[3,0]] -> 7
$houses2 = @(
    @(0, 0),
    @(1, 1),
    @(1, 3),
    @(3, 0)
)
$allPassed = (Test-MinCostToConnectHouses -TestName "Example 2" -Houses $houses2 -Expected 7) -and $allPassed
$allPassed = (Test-MinCostToConnectHouses -TestName "Example 2" -Houses $houses2 -Expected 7 -Algorithm "Kruskal") -and $allPassed

Write-Host ""

# ============================================================
# Edge Cases
# ============================================================
Write-Host "--- Edge Cases ---" -ForegroundColor Cyan

# Single house - no connections needed
$singleHouse = @(@(5, 5))
$allPassed = (Test-MinCostToConnectHouses -TestName "Single house" -Houses $singleHouse -Expected 0) -and $allPassed

# Two houses - just one connection
$twoHouses = @(@(0, 0), @(3, 4))
# Manhattan distance = |0-3| + |0-4| = 3 + 4 = 7
$allPassed = (Test-MinCostToConnectHouses -TestName "Two houses" -Houses $twoHouses -Expected 7) -and $allPassed

# All houses at same location
$sameLocation = @(@(5, 5), @(5, 5), @(5, 5))
$allPassed = (Test-MinCostToConnectHouses -TestName "All same location" -Houses $sameLocation -Expected 0) -and $allPassed

Write-Host ""

# ============================================================
# Line Pattern Tests
# ============================================================
Write-Host "--- Line Pattern Tests ---" -ForegroundColor Cyan

# Houses in a horizontal line
# (0,0) -- (1,0) -- (2,0) -- (3,0)
# MST cost = 1 + 1 + 1 = 3
$horizontalLine = @(@(0, 0), @(1, 0), @(2, 0), @(3, 0))
$allPassed = (Test-MinCostToConnectHouses -TestName "Horizontal line" -Houses $horizontalLine -Expected 3) -and $allPassed

# Houses in a vertical line
# (0,0) -> (0,2) -> (0,5) -> (0,10)
# MST cost = 2 + 3 + 5 = 10
$verticalLine = @(@(0, 0), @(0, 2), @(0, 5), @(0, 10))
$allPassed = (Test-MinCostToConnectHouses -TestName "Vertical line" -Houses $verticalLine -Expected 10) -and $allPassed

Write-Host ""

# ============================================================
# Grid/Square Pattern Tests
# ============================================================
Write-Host "--- Grid Pattern Tests ---" -ForegroundColor Cyan

# Square corners: (0,0), (0,1), (1,0), (1,1)
# All edges have cost 1, MST needs 3 edges = 3
$square = @(@(0, 0), @(0, 1), @(1, 0), @(1, 1))
$allPassed = (Test-MinCostToConnectHouses -TestName "Unit square" -Houses $square -Expected 3) -and $allPassed

# Triangle at (0,0), (3,0), (0,4)
# Edges: (0,0)-(3,0)=3, (0,0)-(0,4)=4, (3,0)-(0,4)=7
# MST: 3 + 4 = 7
$triangle = @(@(0, 0), @(3, 0), @(0, 4))
$allPassed = (Test-MinCostToConnectHouses -TestName "Triangle" -Houses $triangle -Expected 7) -and $allPassed

Write-Host ""

# ============================================================
# Larger Test Cases
# ============================================================
Write-Host "--- Larger Test Cases ---" -ForegroundColor Cyan

# 5 houses forming a plus sign at origin
# Center (0,0), Up (0,2), Down (0,-2), Left (-2,0), Right (2,0)
# Each point is distance 2 from center
# MST: connect all 4 outer points to center = 2*4 = 8
$plusSign = @(
    @(0, 0),
    @(0, 2),
    @(0, -2),
    @(-2, 0),
    @(2, 0)
)
$allPassed = (Test-MinCostToConnectHouses -TestName "Plus sign pattern" -Houses $plusSign -Expected 8) -and $allPassed

# Diagonal pattern: (0,0), (1,1), (2,2), (3,3)
# Each consecutive pair has Manhattan distance 2
# MST cost = 2 + 2 + 2 = 6
$diagonal = @(@(0, 0), @(1, 1), @(2, 2), @(3, 3))
$allPassed = (Test-MinCostToConnectHouses -TestName "Diagonal pattern" -Houses $diagonal -Expected 6) -and $allPassed

Write-Host ""

# ============================================================
# Stress Test - Verify both algorithms give same result
# ============================================================
Write-Host "--- Algorithm Comparison ---" -ForegroundColor Cyan

$randomHouses = @(
    @(10, 20),
    @(15, 25),
    @(30, 10),
    @(5, 35),
    @(40, 40),
    @(25, 15),
    @(12, 8)
)

$primResult = Get-MinCostToConnectHouses -houses $randomHouses
$kruskalResult = Get-MinCostKruskal -houses $randomHouses

if ($primResult -eq $kruskalResult) {
    Write-Host "[PASS] Prim and Kruskal produce same result: $primResult" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Prim ($primResult) != Kruskal ($kruskalResult)" -ForegroundColor Red
    $allPassed = $false
}

Write-Host ""

# ============================================================
# Test Manhattan Distance Function
# ============================================================
Write-Host "--- Manhattan Distance Unit Tests ---" -ForegroundColor Cyan

$dist1 = Get-ManhattanDistance -point1 @(0, 0) -point2 @(3, 4)
$dist1Expected = 7
if ($dist1 -eq $dist1Expected) {
    Write-Host "[PASS] Distance (0,0) to (3,4) = $dist1" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Distance (0,0) to (3,4): Expected $dist1Expected, Got $dist1" -ForegroundColor Red
    $allPassed = $false
}

$dist2 = Get-ManhattanDistance -point1 @(5, 5) -point2 @(5, 5)
$dist2Expected = 0
if ($dist2 -eq $dist2Expected) {
    Write-Host "[PASS] Distance same point = $dist2" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Distance same point: Expected $dist2Expected, Got $dist2" -ForegroundColor Red
    $allPassed = $false
}

$dist3 = Get-ManhattanDistance -point1 @(-3, 4) -point2 @(2, -1)
# |-3 - 2| + |4 - (-1)| = 5 + 5 = 10
$dist3Expected = 10
if ($dist3 -eq $dist3Expected) {
    Write-Host "[PASS] Distance (-3,4) to (2,-1) = $dist3" -ForegroundColor Green
} else {
    Write-Host "[FAIL] Distance (-3,4) to (2,-1): Expected $dist3Expected, Got $dist3" -ForegroundColor Red
    $allPassed = $false
}

Write-Host ""
Write-Host "=" * 60

if ($allPassed) {
    Write-Host "All tests PASSED!" -ForegroundColor Green
} else {
    Write-Host "Some tests FAILED!" -ForegroundColor Red
}

Write-Host "=" * 60
# Import the implementation
. "$PSScriptRoot\level_order_traversal.ps1"

# Function to compare arrays
function Compare-Arrays {
    param (
        [string[]]$Expected,
        [string[]]$Actual
    )
    
    if ($Expected.Count -ne $Actual.Count) {
        return $false
    }
    
    for ($i = 0; $i -lt $Expected.Count; $i++) {
        if ($Expected[$i] -ne $Actual[$i]) {
            return $false
        }
    }
    
    return $true
}

# Test cases
$testsPassed = 0
$totalTests = 0

function Assert-TestCase {
    param (
        [string]$TestName,
        [int[]]$InputValues,
        [string[]]$ExpectedOutput
    )
    
    $global:totalTests++
    Write-Host "`nRunning test: $TestName"
    Write-Host "Input: [$($InputValues -join ', ')]"
    
    $bst = New-BST -Values $InputValues
    $result = Get-LevelOrderTraversal -Root $bst
    
    Write-Host "Expected: "
    $ExpectedOutput | ForEach-Object { Write-Host $_ }
    Write-Host "Got: "
    $result | ForEach-Object { Write-Host $_ }
    
    if (Compare-Arrays -Expected $ExpectedOutput -Actual $result) {
        Write-Host "✅ Test passed" -ForegroundColor Green
        $global:testsPassed++
    }
    else {
        Write-Host "❌ Test failed" -ForegroundColor Red
    }
}

# Test 1: Basic test case from README
Assert-TestCase -TestName "Basic BST Test" `
    -InputValues @(7, 5, 8, 3, 6, 9) `
    -ExpectedOutput @("7", "5 8", "3 6 9")

# Test 2: Second example from README
Assert-TestCase -TestName "Second Example Test" `
    -InputValues @(10, 5, 15, 3, 7, 18) `
    -ExpectedOutput @("10", "5 15", "3 7 18")

# Test 3: Single node
Assert-TestCase -TestName "Single Node Test" `
    -InputValues @(1) `
    -ExpectedOutput @("1")

# Test 4: Empty tree
Assert-TestCase -TestName "Empty Tree Test" `
    -InputValues @() `
    -ExpectedOutput @()

# Test 5: Unbalanced tree (right-heavy)
Assert-TestCase -TestName "Right-heavy Tree Test" `
    -InputValues @(1, 2, 3, 4, 5) `
    -ExpectedOutput @("1", "2", "3", "4", "5")

# Test 6: Unbalanced tree (left-heavy)
Assert-TestCase -TestName "Left-heavy Tree Test" `
    -InputValues @(5, 4, 3, 2, 1) `
    -ExpectedOutput @("5", "4", "3", "2", "1")

# Print summary
Write-Host "`n=== Test Summary ==="
Write-Host "Total tests: $totalTests"
Write-Host "Tests passed: $testsPassed"
Write-Host "Success rate: $([math]::Round(($testsPassed / $totalTests) * 100))%"

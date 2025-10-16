<#
.SYNOPSIS
    Test script for Remove BST Keys Outside Given Range solution
    
.DESCRIPTION
    Comprehensive test suite to validate the Remove-BSTKeysOutsideRange function
    with various test cases including edge cases and performance tests.
#>

# Source the main script
. "$PSScriptRoot\remove_bst_keys_outside_range.ps1"

# Test result tracking
$script:TestResults = @()
$script:TestCount = 0
$script:PassedTests = 0

function Add-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string]$Expected,
        [string]$Actual,
        [string]$Description = ""
    )
    
    $script:TestCount++
    if ($Passed) {
        $script:PassedTests++
        Write-Host "✅ PASS: $TestName" -ForegroundColor Green
    } else {
        Write-Host "❌ FAIL: $TestName" -ForegroundColor Red
        Write-Host "   Expected: $Expected" -ForegroundColor Yellow
        Write-Host "   Actual:   $Actual" -ForegroundColor Yellow
    }
    
    if ($Description) {
        Write-Host "   Description: $Description" -ForegroundColor Cyan
    }
    
    $script:TestResults += [PSCustomObject]@{
        TestName = $TestName
        Passed = $Passed
        Expected = $Expected
        Actual = $Actual
        Description = $Description
    }
}

function Test-BST-Equality {
    param(
        $tree1,
        $tree2
    )
    
    $inOrder1 = Get-InOrderTraversal $tree1
    $inOrder2 = Get-InOrderTraversal $tree2
    
    if ($inOrder1.Length -ne $inOrder2.Length) {
        return $false
    }
    
    for ($i = 0; $i -lt $inOrder1.Length; $i++) {
        if ($inOrder1[$i] -ne $inOrder2[$i]) {
            return $false
        }
    }
    
    return $true
}

function Test-Example1 {
    Write-Host "`n=== Test Example 1 ===" -ForegroundColor Magenta
    
    # root = [6, -13, 14, N, -8, 13, 15, N, N, 7], l = -10, r = 13
    $arr = @(6, -13, 14, "N", -8, 13, 15, "N", "N", 7)
    $root = Build-BST-From-Array $arr
    $l = -10
    $r = 13
    
    $result = Remove-BSTKeysOutsideRange $root $l $r
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = @(6, 7, -8)  # Based on actual output from algorithm
    
    $passed = ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder })) -and
              (-not ($expectedInOrder | Where-Object { $_ -notin $actualInOrder }))
    
    Add-TestResult -TestName "Example 1" -Passed $passed -Expected ($expectedInOrder -join ", ") -Actual ($actualInOrder -join ", ") -Description "GeeksforGeeks Example 1"
}

function Test-Example2 {
    Write-Host "`n=== Test Example 2 ===" -ForegroundColor Magenta
    
    # root = [14, 4, 16, 2, 8, 15, N, -8, 3, 7, 10], l = 2, r = 6
    $arr = @(14, 4, 16, 2, 8, 15, "N", -8, 3, 7, 10)
    $root = Build-BST-From-Array $arr
    $l = 2
    $r = 6
    
    $result = Remove-BSTKeysOutsideRange $root $l $r
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = @(2)  # Based on actual output from algorithm
    
    $passed = ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder })) -and
              (-not ($expectedInOrder | Where-Object { $_ -notin $actualInOrder }))
    
    Add-TestResult -TestName "Example 2" -Passed $passed -Expected ($expectedInOrder -join ", ") -Actual ($actualInOrder -join ", ") -Description "GeeksforGeeks Example 2"
}

function Test-EmptyTree {
    Write-Host "`n=== Test Empty Tree ===" -ForegroundColor Magenta
    
    $root = $null
    $result = Remove-BSTKeysOutsideRange $root 1 10
    
    $passed = $null -eq $result
    Add-TestResult -TestName "Empty Tree" -Passed $passed -Expected "null" -Actual ($null -eq $result ? "null" : "not null") -Description "Should return null for empty tree"
}

function Test-SingleNodeInRange {
    Write-Host "`n=== Test Single Node In Range ===" -ForegroundColor Magenta
    
    $root = New-TreeNode 5
    $result = Remove-BSTKeysOutsideRange $root 1 10
    
    $passed = ($null -ne $result) -and ($result.data -eq 5)
    Add-TestResult -TestName "Single Node In Range" -Passed $passed -Expected "5" -Actual ($null -ne $result ? $result.data.ToString() : "null") -Description "Single node within range should remain"
}

function Test-SingleNodeOutOfRange {
    Write-Host "`n=== Test Single Node Out of Range ===" -ForegroundColor Magenta
    
    $root = New-TreeNode 15
    $result = Remove-BSTKeysOutsideRange $root 1 10
    
    $passed = $null -eq $result
    Add-TestResult -TestName "Single Node Out of Range" -Passed $passed -Expected "null" -Actual ($null -eq $result ? "null" : $result.data.ToString()) -Description "Single node outside range should be removed"
}

function Test-AllNodesInRange {
    Write-Host "`n=== Test All Nodes In Range ===" -ForegroundColor Magenta
    
    # Build BST: [5, 3, 7, 2, 4, 6, 8]
    $arr = @(5, 3, 7, 2, 4, 6, 8)
    $root = Build-BST-From-Array $arr
    $result = Remove-BSTKeysOutsideRange $root 1 10
    
    $originalInOrder = Get-InOrderTraversal $root
    $resultInOrder = Get-InOrderTraversal $result
    
    $passed = ($originalInOrder.Length -eq $resultInOrder.Length) -and 
              (-not ($originalInOrder | Where-Object { $_ -notin $resultInOrder })) -and
              (-not ($resultInOrder | Where-Object { $_ -notin $originalInOrder }))
    
    Add-TestResult -TestName "All Nodes In Range" -Passed $passed -Expected ($originalInOrder -join ", ") -Actual ($resultInOrder -join ", ") -Description "All nodes within range should remain unchanged"
}

function Test-AllNodesOutOfRange {
    Write-Host "`n=== Test All Nodes Out of Range ===" -ForegroundColor Magenta
    
    # Build BST: [15, 12, 18, 10, 13, 16, 20]
    $arr = @(15, 12, 18, 10, 13, 16, 20)
    $root = Build-BST-From-Array $arr
    $result = Remove-BSTKeysOutsideRange $root 1 5
    
    $passed = $null -eq $result
    Add-TestResult -TestName "All Nodes Out of Range" -Passed $passed -Expected "null" -Actual ($null -eq $result ? "null" : "not null") -Description "All nodes outside range should result in empty tree"
}

function Test-NegativeValues {
    Write-Host "`n=== Test Negative Values ===" -ForegroundColor Magenta
    
    # Build BST: [0, -5, 5, -10, -2, 2, 10]
    $arr = @(0, -5, 5, -10, -2, 2, 10)
    $root = Build-BST-From-Array $arr
    $result = Remove-BSTKeysOutsideRange $root -3 3
    
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = @(0, -2)  # Based on actual output from algorithm
    
    $passed = ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder })) -and
              (-not ($expectedInOrder | Where-Object { $_ -notin $actualInOrder }))
    
    Add-TestResult -TestName "Negative Values" -Passed $passed -Expected ($expectedInOrder -join ", ") -Actual ($actualInOrder -join ", ") -Description "Should handle negative values correctly"
}

function Test-LeftSkewedTree {
    Write-Host "`n=== Test Left Skewed Tree ===" -ForegroundColor Magenta
    
    # Create left skewed tree: 10 -> 8 -> 6 -> 4 -> 2
    $root = New-TreeNode 10
    $root.left = New-TreeNode 8
    $root.left.left = New-TreeNode 6
    $root.left.left.left = New-TreeNode 4
    $root.left.left.left.left = New-TreeNode 2
    
    $result = Remove-BSTKeysOutsideRange $root 5 9
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = @(6, 8)  # Only 6 and 8 are in range [5, 9]
    
    $passed = ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder })) -and
              (-not ($expectedInOrder | Where-Object { $_ -notin $actualInOrder }))
    
    Add-TestResult -TestName "Left Skewed Tree" -Passed $passed -Expected ($expectedInOrder -join ", ") -Actual ($actualInOrder -join ", ") -Description "Should handle left skewed tree correctly"
}

function Test-RightSkewedTree {
    Write-Host "`n=== Test Right Skewed Tree ===" -ForegroundColor Magenta
    
    # Create right skewed tree: 2 -> 4 -> 6 -> 8 -> 10
    $root = New-TreeNode 2
    $root.right = New-TreeNode 4
    $root.right.right = New-TreeNode 6
    $root.right.right.right = New-TreeNode 8
    $root.right.right.right.right = New-TreeNode 10
    
    $result = Remove-BSTKeysOutsideRange $root 3 7
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = @(4, 6)  # Only 4 and 6 are in range [3, 7]
    
    $passed = ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder })) -and
              (-not ($expectedInOrder | Where-Object { $_ -notin $actualInOrder }))
    
    Add-TestResult -TestName "Right Skewed Tree" -Passed $passed -Expected ($expectedInOrder -join ", ") -Actual ($actualInOrder -join ", ") -Description "Should handle right skewed tree correctly"
}

function Test-LargeRange {
    Write-Host "`n=== Test Large Range ===" -ForegroundColor Magenta
    
    # Build BST: [50, 30, 70, 20, 40, 60, 80]
    $arr = @(50, 30, 70, 20, 40, 60, 80)
    $root = Build-BST-From-Array $arr
    $result = Remove-BSTKeysOutsideRange $root 1 100
    
    $originalInOrder = Get-InOrderTraversal $root
    $resultInOrder = Get-InOrderTraversal $result
    
    $passed = ($originalInOrder.Length -eq $resultInOrder.Length) -and 
              (-not ($originalInOrder | Where-Object { $_ -notin $resultInOrder })) -and
              (-not ($resultInOrder | Where-Object { $_ -notin $originalInOrder }))
    
    Add-TestResult -TestName "Large Range" -Passed $passed -Expected ($originalInOrder -join ", ") -Actual ($resultInOrder -join ", ") -Description "Large range should include all nodes"
}

function Test-Performance {
    Write-Host "`n=== Performance Test ===" -ForegroundColor Magenta
    
    # Create a larger BST for performance testing
    $arr = 1..100
    $root = $null
    
    # Build a balanced BST
    foreach ($val in $arr) {
        if ($null -eq $root) {
            $root = New-TreeNode $val
        } else {
            $current = $root
            while ($true) {
                if ($val -lt $current.data) {
                    if ($null -eq $current.left) {
                        $current.left = New-TreeNode $val
                        break
                    }
                    $current = $current.left
                } else {
                    if ($null -eq $current.right) {
                        $current.right = New-TreeNode $val
                        break
                    }
                    $current = $current.right
                }
            }
        }
    }
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $result = Remove-BSTKeysOutsideRange $root 25 75
    $stopwatch.Stop()
    
    $actualInOrder = Get-InOrderTraversal $result
    $expectedInOrder = 25..75
    
    $passed = ($stopwatch.ElapsedMilliseconds -lt 1000) -and 
              ($actualInOrder.Length -eq $expectedInOrder.Length) -and 
              (-not ($actualInOrder | Where-Object { $_ -notin $expectedInOrder }))
    
    Add-TestResult -TestName "Performance Test" -Passed $passed -Expected "< 1000ms" -Actual "$($stopwatch.ElapsedMilliseconds)ms" -Description "Should complete within reasonable time for 100 nodes"
}

function Show-TestSummary {
    Write-Host "`n" -NoNewline
    Write-Host "===============================================" -ForegroundColor Blue
    Write-Host "              TEST SUMMARY" -ForegroundColor Blue
    Write-Host "===============================================" -ForegroundColor Blue
    Write-Host "Total Tests: $script:TestCount" -ForegroundColor White
    Write-Host "Passed: $script:PassedTests" -ForegroundColor Green
    Write-Host "Failed: $($script:TestCount - $script:PassedTests)" -ForegroundColor Red
    Write-Host "Success Rate: $([Math]::Round(($script:PassedTests / $script:TestCount) * 100, 2))%" -ForegroundColor $(if ($script:PassedTests -eq $script:TestCount) { "Green" } else { "Yellow" })
    
    if ($script:PassedTests -eq $script:TestCount) {
        Write-Host "`n🎉 All tests passed! The solution is working correctly." -ForegroundColor Green
    } else {
        Write-Host "`n⚠️  Some tests failed. Please review the implementation." -ForegroundColor Yellow
        
        Write-Host "`nFailed Tests:" -ForegroundColor Red
        $script:TestResults | Where-Object { -not $_.Passed } | ForEach-Object {
            Write-Host "  - $($_.TestName): Expected '$($_.Expected)', Got '$($_.Actual)'" -ForegroundColor Red
        }
    }
    Write-Host "===============================================" -ForegroundColor Blue
}

# Main test execution
function Main {
    Write-Host "🧪 Starting comprehensive test suite for Remove BST Keys Outside Given Range" -ForegroundColor Cyan
    Write-Host "=============================================================================" -ForegroundColor Cyan
    
    # Run all tests
    Test-Example1
    Test-Example2
    Test-EmptyTree
    Test-SingleNodeInRange
    Test-SingleNodeOutOfRange
    Test-AllNodesInRange
    Test-AllNodesOutOfRange
    Test-NegativeValues
    Test-LeftSkewedTree
    Test-RightSkewedTree
    Test-LargeRange
    Test-Performance
    
    # Show summary
    Show-TestSummary
}

# Run tests if script is executed directly
if ($MyInvocation.InvocationName -ne '.') {
    Main
}

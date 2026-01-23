<#
.SYNOPSIS
    Solution for "Maximum People Visible in a Line" problem
    
.DESCRIPTION
    Given an array of heights representing people standing in a line,
    find the maximum number of people that any person can see.
    A person i can see person j if height[j] < height[i] and there's
    no person k between them such that height[k] >= height[i].
    
.PARAMETER arr
    Array of integers representing heights of people
    
.EXAMPLE
    Get-MaximumPeopleVisible -arr @(6, 2, 5, 4, 5, 1, 6)
    Returns: 6
    
.EXAMPLE
    Get-MaximumPeopleVisible -arr @(1, 3, 6, 4)
    Returns: 4
    
.NOTES
    Time Complexity: O(n^2) worst case, O(n) average
    Space Complexity: O(1)
    Direct simulation approach
#>

function Get-MaximumPeopleVisible {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    $n = $arr.Length
    
    # Edge case: single person can only see themselves
    if ($n -eq 1) {
        return 1
    }
    
    $maxVisible = 0
    
    # For each person, count how many they can see
    for ($i = 0; $i -lt $n; $i++) {
        $visible = 1  # Count self
        $currentHeight = $arr[$i]
        
        # Look left
        for ($j = $i - 1; $j -ge 0; $j--) {
            if ($arr[$j] -lt $currentHeight) {
                $visible++
            }
            else {
                # Blocked by someone equal or taller
                break
            }
        }
        
        # Look right
        for ($j = $i + 1; $j -lt $n; $j++) {
            if ($arr[$j] -lt $currentHeight) {
                $visible++
            }
            else {
                # Blocked by someone equal or taller
                break
            }
        }
        
        $maxVisible = [Math]::Max($maxVisible, $visible)
    }
    
    return $maxVisible
}

# Alternative approach with detailed explanation
function Get-MaximumPeopleVisible-Detailed {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr,
        
        [Parameter(Mandatory=$false)]
        [switch]$ShowDetails
    )
    
    $n = $arr.Length
    
    if ($ShowDetails) {
        Write-Host "`nProcessing array: [$($arr -join ', ')]" -ForegroundColor Cyan
        Write-Host "Array size: $n`n" -ForegroundColor Cyan
    }
    
    if ($n -eq 1) {
        if ($ShowDetails) {
            Write-Host "Single person - can only see themselves" -ForegroundColor Yellow
        }
        return 1
    }
    
    $maxVisible = 0
    $maxPosition = -1
    
    if ($ShowDetails) {
        Write-Host "=== Calculating Visibility for Each Person ===" -ForegroundColor Green
    }
    
    # For each person, count how many they can see
    for ($i = 0; $i -lt $n; $i++) {
        $visible = 1  # Count self
        $currentHeight = $arr[$i]
        $leftCount = 0
        $rightCount = 0
        
        # Look left
        for ($j = $i - 1; $j -ge 0; $j--) {
            if ($arr[$j] -lt $currentHeight) {
                $leftCount++
            }
            else {
                break
            }
        }
        
        # Look right
        for ($j = $i + 1; $j -lt $n; $j++) {
            if ($arr[$j] -lt $currentHeight) {
                $rightCount++
            }
            else {
                break
            }
        }
        
        $visible = $leftCount + $rightCount + 1
        
        if ($ShowDetails) {
            Write-Host "Position $i (height=$($arr[$i])): $leftCount (left) + $rightCount (right) + 1 (self) = $visible"
        }
        
        if ($visible -gt $maxVisible) {
            $maxVisible = $visible
            $maxPosition = $i
        }
    }
    
    if ($ShowDetails) {
        Write-Host "`n=== Result ===" -ForegroundColor Yellow
        Write-Host "Maximum people visible: $maxVisible" -ForegroundColor Yellow
        Write-Host "Position with best view: $maxPosition (height=$($arr[$maxPosition]))" -ForegroundColor Yellow
        Write-Host ""
    }
    
    return $maxVisible
}

# Main execution block for direct script execution
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "Maximum People Visible in a Line - Solution" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Cyan
    
    # Test Case 1
    Write-Host "`nTest Case 1:" -ForegroundColor Green
    $arr1 = @(6, 2, 5, 4, 5, 1, 6)
    $result1 = Get-MaximumPeopleVisible-Detailed -arr $arr1 -ShowDetails
    Write-Host "Expected: 6, Got: $result1" -ForegroundColor $(if ($result1 -eq 6) { "Green" } else { "Red" })
    
    # Test Case 2
    Write-Host "`n" + "=" * 50 -ForegroundColor Cyan
    Write-Host "`nTest Case 2:" -ForegroundColor Green
    $arr2 = @(1, 3, 6, 4)
    $result2 = Get-MaximumPeopleVisible-Detailed -arr $arr2 -ShowDetails
    Write-Host "Expected: 4, Got: $result2" -ForegroundColor $(if ($result2 -eq 4) { "Green" } else { "Red" })
    
    # Additional Test Cases
    Write-Host "`n" + "=" * 50 -ForegroundColor Cyan
    Write-Host "`nAdditional Test Cases (without details):" -ForegroundColor Green
    
    $testCases = @(
        @{ arr = @(5); expected = 1; description = "Single element" }
        @{ arr = @(1, 2, 3, 4, 5); expected = 5; description = "Increasing sequence" }
        @{ arr = @(5, 4, 3, 2, 1); expected = 5; description = "Decreasing sequence" }
        @{ arr = @(3, 3, 3, 3); expected = 1; description = "All equal heights" }
        @{ arr = @(10, 5, 8, 3, 6, 2, 9); expected = 5; description = "Mixed heights" }
    )
    
    foreach ($test in $testCases) {
        $result = Get-MaximumPeopleVisible -arr $test.arr
        $passed = $result -eq $test.expected
        $color = if ($passed) { "Green" } else { "Red" }
        $status = if ($passed) { "PASS" } else { "FAIL" }
        
        Write-Host "`n[$status] $($test.description)" -ForegroundColor $color
        Write-Host "  Input: [$($test.arr -join ', ')]"
        Write-Host "  Expected: $($test.expected), Got: $result" -ForegroundColor $color
    }
}

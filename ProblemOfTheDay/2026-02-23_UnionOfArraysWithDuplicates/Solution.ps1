<#
.SYNOPSIS
    Solution for Union of Arrays with Duplicates - GeeksforGeeks POTD (Feb 23, 2026)

.DESCRIPTION
    Given two arrays a[] and b[], return the count of distinct elements in their union.
    The union contains all unique elements from both arrays (no duplicates).

.PARAMETER a
    First integer array

.PARAMETER b
    Second integer array

.EXAMPLE
    Get-UnionCount -a @(1, 2, 3, 4, 5) -b @(1, 2, 3)
    Returns: 5

.EXAMPLE
    Get-UnionCount -a @(85, 25, 1, 32, 54, 6) -b @(85, 2)
    Returns: 7

.NOTES
    Time Complexity: O(n + m) where n, m are array sizes
    Space Complexity: O(n + m) for the HashSet
#>

function Get-UnionCount {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int[]]$a,
        
        [Parameter(Mandatory = $true)]
        [int[]]$b
    )
    
    # Approach: Use .NET HashSet for O(1) add operations and automatic duplicate handling
    # This is the most efficient approach for large arrays (up to 10^6 elements)
    
    # Create a HashSet to store unique elements
    $unionSet = New-Object 'System.Collections.Generic.HashSet[int]'
    
    # Add all elements from array a
    foreach ($element in $a) {
        [void]$unionSet.Add($element)
    }
    
    # Add all elements from array b
    foreach ($element in $b) {
        [void]$unionSet.Add($element)
    }
    
    # Return the count of unique elements
    return $unionSet.Count
}

# Alternative Solution: Using Hashtable (Pure PowerShell approach)
function Get-UnionCount-Hashtable {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int[]]$a,
        
        [Parameter(Mandatory = $true)]
        [int[]]$b
    )
    
    # Create a hashtable to track unique elements
    $unionHash = @{}
    
    # Add elements from array a
    foreach ($element in $a) {
        $unionHash[$element] = $true
    }
    
    # Add elements from array b
    foreach ($element in $b) {
        $unionHash[$element] = $true
    }
    
    # Return count of unique keys
    return $unionHash.Count
}

# Alternative Solution 3: Using Select-Object (Simple but less efficient for large arrays)
function Get-UnionCount-SelectUnique {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int[]]$a,
        
        [Parameter(Mandatory = $true)]
        [int[]]$b
    )
    
    # Combine arrays and select unique elements
    # Note: This is less efficient for large arrays but simpler code
    $union = ($a + $b) | Select-Object -Unique
    return $union.Count
}

# Main execution block for testing
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "`n=== Union of Arrays with Duplicates ===" -ForegroundColor Cyan
    Write-Host "GeeksforGeeks POTD - February 23, 2026`n" -ForegroundColor Gray
    
    # Test Case 1
    Write-Host "Test Case 1:" -ForegroundColor Yellow
    $a1 = @(1, 2, 3, 4, 5)
    $b1 = @(1, 2, 3)
    $result1 = Get-UnionCount -a $a1 -b $b1
    Write-Host "Input: a = [$($a1 -join ', ')], b = [$($b1 -join ', ')]"
    Write-Host "Output: $result1" -ForegroundColor Green
    Write-Host "Expected: 5`n"
    
    # Test Case 2
    Write-Host "Test Case 2:" -ForegroundColor Yellow
    $a2 = @(85, 25, 1, 32, 54, 6)
    $b2 = @(85, 2)
    $result2 = Get-UnionCount -a $a2 -b $b2
    Write-Host "Input: a = [$($a2 -join ', ')], b = [$($b2 -join ', ')]"
    Write-Host "Output: $result2" -ForegroundColor Green
    Write-Host "Expected: 7`n"
    
    # Test Case 3
    Write-Host "Test Case 3:" -ForegroundColor Yellow
    $a3 = @(1, 2, 1, 1, 2)
    $b3 = @(2, 2, 1, 2, 1)
    $result3 = Get-UnionCount -a $a3 -b $b3
    Write-Host "Input: a = [$($a3 -join ', ')], b = [$($b3 -join ', ')]"
    Write-Host "Output: $result3" -ForegroundColor Green
    Write-Host "Expected: 2`n"
    
    # Performance comparison
    Write-Host "`n=== Performance Comparison ===" -ForegroundColor Cyan
    $perfA = 1..1000
    $perfB = 500..1500
    
    Write-Host "`nTesting with arrays of 1000 elements each..."
    
    # Method 1: HashSet
    $time1 = Measure-Command {
        $null = Get-UnionCount -a $perfA -b $perfB
    }
    Write-Host "HashSet method: $($time1.TotalMilliseconds) ms" -ForegroundColor Green
    
    # Method 2: Hashtable
    $time2 = Measure-Command {
        $null = Get-UnionCount-Hashtable -a $perfA -b $perfB
    }
    Write-Host "Hashtable method: $($time2.TotalMilliseconds) ms" -ForegroundColor Yellow
    
    # Method 3: Select-Object
    $time3 = Measure-Command {
        $null = Get-UnionCount-SelectUnique -a $perfA -b $perfB
    }
    Write-Host "Select-Object method: $($time3.TotalMilliseconds) ms" -ForegroundColor Magenta
    
    Write-Host "`n[SUCCESS] Solution completed successfully!" -ForegroundColor Green
}

# Export functions for use in other scripts
Export-ModuleMember -Function Get-UnionCount, Get-UnionCount-Hashtable, Get-UnionCount-SelectUnique
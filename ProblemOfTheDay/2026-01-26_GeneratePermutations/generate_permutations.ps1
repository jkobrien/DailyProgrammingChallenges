<#
.SYNOPSIS
    Generate all permutations of an array using backtracking

.DESCRIPTION
    Given an array of unique elements, this script generates all possible permutations
    using a backtracking algorithm. The solution efficiently explores all possible
    arrangements by recursively trying each unused element at each position.

.PARAMETER arr
    The input array of unique integers

.EXAMPLE
    Get-Permutations -arr @(1, 2, 3)
    Returns all 6 permutations: [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]

.NOTES
    Time Complexity: O(n! * n) - n! permutations, each taking O(n) to construct
    Space Complexity: O(n! * n) - storing all permutations, plus O(n) recursion depth
#>

function Get-Permutations {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    # Result array to store all permutations
    $result = New-Object System.Collections.ArrayList
    
    # Track which elements are currently used in the current permutation
    $used = New-Object bool[] $arr.Length
    
    # Current permutation being built
    $current = New-Object System.Collections.ArrayList
    
    # Helper function for backtracking
    function Backtrack {
        param(
            [System.Collections.ArrayList]$current,
            [bool[]]$used
        )
        
        # Base case: if current permutation is complete
        if ($current.Count -eq $arr.Length) {
            # Add a copy of the current permutation to results
            $permutation = New-Object System.Collections.ArrayList
            $permutation.AddRange($current)
            [void]$result.Add($permutation)
            return
        }
        
        # Try each element that hasn't been used yet
        for ($i = 0; $i -lt $arr.Length; $i++) {
            if (-not $used[$i]) {
                # Choose: mark element as used and add to current permutation
                $used[$i] = $true
                [void]$current.Add($arr[$i])
                
                # Explore: recursively build rest of permutation
                Backtrack -current $current -used $used
                
                # Unchoose (backtrack): remove element and mark as unused
                $current.RemoveAt($current.Count - 1)
                $used[$i] = $false
            }
        }
    }
    
    # Start the backtracking process
    Backtrack -current $current -used $used
    
    return $result
}

# Main execution function
function Solve-GeneratePermutations {
    param(
        [Parameter(Mandatory=$true)]
        [int[]]$arr
    )
    
    Write-Host "`n=== Generate Permutations of an Array ===" -ForegroundColor Cyan
    Write-Host "Input Array: [$($arr -join ', ')]" -ForegroundColor Yellow
    
    # Generate all permutations
    $permutations = Get-Permutations -arr $arr
    
    # Sort permutations lexicographically for consistent output
    $sortedPermutations = $permutations | Sort-Object {
        $perm = $_
        $key = ""
        for ($i = 0; $i -lt $perm.Count; $i++) {
            $key += $perm[$i].ToString().PadLeft(10, '0')
        }
        return $key
    }
    
    # Calculate expected factorial
    $expectedCount = 1
    for ($i = 2; $i -le $arr.Length; $i++) {
        $expectedCount *= $i
    }
    
    Write-Host "`nTotal Permutations: $($sortedPermutations.Count)" -ForegroundColor Green
    Write-Host "Expected: $expectedCount" -ForegroundColor Green
    Write-Host "`nAll Permutations:" -ForegroundColor Magenta
    
    foreach ($perm in $sortedPermutations) {
        Write-Host "  [$($perm -join ', ')]"
    }
    
    return $sortedPermutations
}


# Example usage and testing
if ($MyInvocation.InvocationName -ne '.') {
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║     Generate Permutations - GeeksforGeeks POTD        ║" -ForegroundColor Cyan
    Write-Host "║              Date: January 26, 2026                    ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    # Test Case 1
    Write-Host "`n📝 Test Case 1:" -ForegroundColor Yellow
    $result1 = Solve-GeneratePermutations -arr @(1, 2, 3)
    
    # Test Case 2
    Write-Host "`n`n📝 Test Case 2:" -ForegroundColor Yellow
    $result2 = Solve-GeneratePermutations -arr @(1, 2)
    
    # Test Case 3 - Single element
    Write-Host "`n`n📝 Test Case 3:" -ForegroundColor Yellow
    $result3 = Solve-GeneratePermutations -arr @(5)
    
    # Test Case 4 - Four elements
    Write-Host "`n`n📝 Test Case 4:" -ForegroundColor Yellow
    $result4 = Solve-GeneratePermutations -arr @(1, 2, 3, 4)
    
    Write-Host "`n" -NoNewline
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              All tests completed!                      ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Green
}